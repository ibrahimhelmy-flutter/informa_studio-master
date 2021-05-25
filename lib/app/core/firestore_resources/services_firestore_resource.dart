import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inforamclub/app/core/models/schedule_notification_model.dart';
import 'package:inforamclub/app/core/models/service_model.dart';
import 'package:inforamclub/app/core/models/service_subscriber_model.dart';
import 'package:inforamclub/app/core/services/user.dart';
import 'firestore_resource.dart';
import 'schedule_notification_firestore_resource.dart';

class ServicesFirestoreResource extends FirestoreResource<ServiceModel> {
  ServicesFirestoreResource() : super('SERVICES', ServiceModel());

  Future<void> removeJoinedUser(String serviceId, String userId) async {
    final service = await get(serviceId);
    final newSubscribersIds = service.subscribersIds;
    newSubscribersIds.removeAt(
        service.subscribersIds.indexWhere((element) => element.id == userId));

    await update(
        service.copyWith(subscribersIds: newSubscribersIds), serviceId);
  }

  Future<void> unScheduleNotificationFromService(
    ServiceModel serviceModel,
  ) async {
    final scheduledNotification = await ScheduleNotificationFirestoreResource()
        .getNotificationFromService(serviceModel);
    if (scheduledNotification.isEnabled)
      ScheduleNotificationFirestoreResource().delete(scheduledNotification.id);
  }

  Future<void> scheduleNotificationFromService(ServiceModel service) async {
    await ScheduleNotificationFirestoreResource().add(ScheduleNotificationModel(
        body: '${service.serviceType.name} Time !',
        whenToNotify: service.start,
        serviceId: service.id));
  }

  Future<void> toggleJoin(ServiceModel service) async {
    if (service.isSubscribed) {
      await leave(service);
    } else {
      await join(service);
    }
  }

  Future<void> deleteServicesFromServiceId(String serviceId) async {
    final result = await collectionReference
        .where('serviceTypeId', isEqualTo: serviceId)
        .get();
    final deletedServices = result.docs
        .map((e) => ServiceModel().fromDocumentSnapshot(e))
        .toList()
        .map((e) => collectionReference.doc(e.id).delete())
        .toList();

    await Future.wait(deletedServices);
  }

  Future<void> join(ServiceModel service) async {
    await scheduleNotificationFromService(service);
    final uid = UserService.id;

    final newSubscribersIds = service.subscribersIds;

    newSubscribersIds.add(ServiceSubscriber(id: uid, at: DateTime.now()));
    await updateSubscribers(service.id, newSubscribersIds);
  }

  Future<void> leave(ServiceModel service) async {
    await unScheduleNotificationFromService(service);

    final uid = UserService.id;

    final newSubscribersIds = service.subscribersIds;

    newSubscribersIds.removeWhere((element) => element.id == uid);

    await updateSubscribers(service.id, newSubscribersIds);
  }

  Stream<QuerySnapshot> getThisWeekServices(DateTime minDate) {
    final afterSevenDays = minDate.add(Duration(days: 6));

    return collectionReference
        .where('gender', isEqualTo: UserService.gender)
        .where('start',
            isGreaterThanOrEqualTo:
                DateTime(minDate.year, minDate.month, minDate.day, 0, 0))
        .where('start',
            isLessThanOrEqualTo: DateTime(
              afterSevenDays.year,
              afterSevenDays.month,
              afterSevenDays.day,
              23,
              59,
              59,
            ))
        .orderBy('start')
        .snapshots();
        // .map((event) => event.docs
        //     .map((e) => ServiceModel().fromDocumentSnapshot(e))
        //     .toList());
  }

  Stream<DocumentSnapshot> service(String doc) {
    return collectionReference.doc(doc).snapshots();
  }

  Future<void> updateSubscribers(
          String serviceId, List<ServiceSubscriber> subscribersIds) async =>
      await collectionReference.doc(serviceId).update(
          {'subscribersIds': subscribersIds.map((e) => e.toMap()).toList()});

  //----------------------------------------------
  Future<void> updateWaitingRoomJoiners(ServiceModel serviceModel) async {
    await collectionReference.doc(serviceModel.id).update(serviceModel.toMap);
  }

  Future<List<ServiceSubscriber>> toggleJoinToWaitingRoom(
      ServiceModel service) async {
    ServiceModel newServiceModel = service;

    if (service.isJoinedToWaitingRoom) {
      service.leaveWaitingRoom();
    } else {
      service.joinWaitingRoom();
    }
    await updateWaitingRoomJoiners(newServiceModel);
    return newServiceModel.waitingRoomIds;
  }
}
