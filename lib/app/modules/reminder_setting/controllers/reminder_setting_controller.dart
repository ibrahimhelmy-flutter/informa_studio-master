import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/firestore_resources/schedule_notification_firestore_resource.dart';
import 'package:inforamclub/app/core/models/schedule_notification_model.dart';
import 'package:inforamclub/app/core/models/service_reminder_arguments_model.dart';
import 'package:inforamclub/app/core/widgets/pop_up.dart';
import 'package:inforamclub/app/modules/send_notification/models/notification_model.dart';

class ReminderSettingController extends GetxController {
  ScheduleNotificationModel notificationModel;

  DateTime start;
  ServiceReminderArgumentModel serviceReminderArgumentModel = Get.arguments;
  var isReminderSaving = false.obs;
  bool isReminderEnabled;
  Duration duration;
  final formKey = GlobalKey<FormBuilderState>();

  void onToggle(int index) {
    if (index == 0) {
      this.isReminderEnabled = true;
    } else {
      this.isReminderEnabled = false;
    }
    update();
  }

  void onTimerDurationChanged(
      Duration duration,
      ) =>
      notificationModel.setWhenToNotify(duration, start);

  void onTextFieldChanged(String value) =>
      this.notificationModel = notificationModel.copyWith(body: value);

  Future<void> toggleNotification() async {
    if (notificationModel.isEnabled) {
      await ScheduleNotificationFirestoreResource()
          .delete(notificationModel.id);
      this.isReminderEnabled = false;

      PopUp.showSnackBar('Reminder disabled');
    } else {
      await ScheduleNotificationFirestoreResource().addToDoc(notificationModel);
      this.isReminderEnabled = true;

      PopUp.showSnackBar('Reminder enabled');
    }
    notificationModel.toggleEnabled();
    update();
  }

  Future<void> saveScheduleNotification() async {
    final formState = formKey.currentState;
    if (formState.validate()) {
      formState.save();
      this.isReminderSaving(true);
      if (isReminderEnabled)
        await ScheduleNotificationFirestoreResource()
            .update(notificationModel, notificationModel.id);
      else
        await unScheduleNotification();

      this.isReminderSaving(false);
    }
  }

  Future<void> unScheduleNotification() async =>
      await ScheduleNotificationFirestoreResource()
          .delete(notificationModel.id);

  @override
  void onInit() {
    super.onInit();
    this.notificationModel =
        serviceReminderArgumentModel.scheduleNotificationModel;
    this.start = serviceReminderArgumentModel.start;

    this.isReminderEnabled = notificationModel.isEnabled;

    this.duration = notificationModel.alertBefore(start);
  }
}
