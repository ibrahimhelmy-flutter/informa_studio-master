import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/firestore_resources/schedule_notification_firestore_resource.dart';
import 'package:inforamclub/app/core/firestore_resources/services_firestore_resource.dart';
import 'package:inforamclub/app/core/firestore_resources/users_firestore_resource.dart';
import 'package:inforamclub/app/core/models/schedule_notification_model.dart';
import 'package:inforamclub/app/core/models/service_model.dart';
import 'package:inforamclub/app/core/models/user_model.dart';
import 'package:inforamclub/app/modules/service_details/models/service_details_user_model.dart';

class ServiceDetailsController extends GetxController {
  var isReminderSaving = false.obs;
  var isServiceLoading = true.obs;
  var isNotificationLoading = true.obs;
  ServiceModel service;
  String serviceId = Get.arguments;

  List<ServiceDetailsUserModel> joinedUsers;

  ScheduleNotificationModel notificationModel;

  final formKey = GlobalKey<FormBuilderState>();

  void fetchData(String serviceId) {
    final serviceStream = ServicesFirestoreResource().service(serviceId);

    serviceStream.listen((event) {
      final service = ServiceModel().fromDocumentSnapshot(event);
      fetchUsers(service);
      this.service = service;
    });
    serviceStream.first.then((value) {
      fetchScheduleNotification();
    });
  }

  Future<void> removeUser(UserModel userModel) async {
    await ServicesFirestoreResource()
        .removeJoinedUser(service.id, userModel.id);
    update();
  }

  Future fetchScheduleNotification() async {
    final stream = ScheduleNotificationFirestoreResource()
        .getNotificationFromServiceStream(service);
    stream.listen((event) {
      print(event.toMap);
      notificationModel = event;

      update();
    });
  }

  Future<void> fetchUsers(ServiceModel serviceModel) async {
    joinedUsers = await Future.wait(serviceModel.subscribersIds
        .map((e) async => ServiceDetailsUserModel(
            userModel: await UserFirestoreResource().get(e.id), at: e.at))
        .toList());
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchData(serviceId);
  }

  Future<void> unScheduleNotification() async =>
      await ScheduleNotificationFirestoreResource()
          .delete(notificationModel.id);

  Future<void> saveScheduleNotification() async {
    final formState = formKey.currentState;
    if (formState.validate()) {
      formState.save();
      this.isReminderSaving(true);
      await ScheduleNotificationFirestoreResource()
          .update(notificationModel, notificationModel.id);

      this.isReminderSaving(false);
    }
  }

  void onTextFieldChanged(String value) =>
      this.notificationModel = notificationModel.copyWith(body: value);

  Future<void> toggleNotification() async {
    if (notificationModel.isEnabled) {
      await ScheduleNotificationFirestoreResource()
          .delete(notificationModel.id);
    } else {
      await ScheduleNotificationFirestoreResource().addToDoc(notificationModel);
    }
    update();
  }
}
