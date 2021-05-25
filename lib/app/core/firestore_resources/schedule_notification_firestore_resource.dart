import 'package:inforamclub/app/core/models/schedule_notification_model.dart';
import 'package:inforamclub/app/core/models/service_model.dart';
import 'package:inforamclub/app/core/services/user.dart';

import 'firestore_resource.dart';

class ScheduleNotificationFirestoreResource
    extends FirestoreResource<ScheduleNotificationModel> {
  ScheduleNotificationFirestoreResource()
      : super('SCHEDULE_NOTIFICATIONS', ScheduleNotificationModel());

  Future<ScheduleNotificationModel> getNotificationFromService(
      ServiceModel serviceModel) async {
    final serviceId = serviceModel.id;
    final result = await collectionReference
        .where('uid', isEqualTo: UserService.id)
        .where('serviceId', isEqualTo: serviceId)
        .get();
    if (result.docs.isEmpty) {
      return ScheduleNotificationModel(
        serviceId: serviceModel.id,
        body: '${serviceModel.serviceType.name} Time !',
        whenToNotify: serviceModel.start,
      );
    } else {
      return ScheduleNotificationModel()
          .fromDocumentSnapshot(result.docs.first);
    }
  }
  Stream<ScheduleNotificationModel> getNotificationFromServiceStream(
      ServiceModel serviceModel) {
    final serviceId = serviceModel.id;
    return collectionReference
        .where('uid', isEqualTo: UserService.id)
        .where('serviceId', isEqualTo: serviceId)
        .snapshots()
        .map((result) {
      if (result.docs.isEmpty) {
        return ScheduleNotificationModel(
          serviceId: serviceModel.id,
          body: '${serviceModel.serviceType.name} Time !',
          whenToNotify: serviceModel.start,
        );
      } else {
        return ScheduleNotificationModel()
            .fromDocumentSnapshot(result.docs.first);
      }
    });
  }
  Future<void> addToDoc(ScheduleNotificationModel scheduleNotificationModel) {
    return collectionReference
        .doc(scheduleNotificationModel.id)
        .set(scheduleNotificationModel.toMap);
  }
}
