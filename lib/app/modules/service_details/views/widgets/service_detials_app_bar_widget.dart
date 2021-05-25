import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/app_localizatioan/localization.dart';
import 'package:inforamclub/app/core/models/service_reminder_arguments_model.dart';
import 'package:inforamclub/app/core/services/user.dart';
import 'package:inforamclub/app/modules/service_details/controllers/service_details_controller.dart';
import 'package:inforamclub/app/routes/app_pages.dart';

class ServiceDetailsAppBar extends GetView<ServiceDetailsController> {
  @override
  Widget build(BuildContext context) {
    final tr = Localization.of(context).languageCode;

    return GetBuilder<ServiceDetailsController>(
      builder: (_) => AppBar(
          actions: [
            if (controller.notificationModel != null &&
                controller.service.isSubscribed) ...[
              TextButton.icon(
                onPressed: controller.toggleNotification,
                label: Text(controller.notificationModel.isEnabled
                    ? 'Disable Reminder'
                    : 'Enable Reminder'),
                icon: Icon(!controller.notificationModel.isEnabled
                    ? Icons.notifications_active
                    : Icons.notifications_off_rounded),
              ),
              if (controller.notificationModel.isEnabled)
                IconButton(
                  onPressed: () => Get.toNamed(Routes.REMINDER_SETTING,
                      arguments: ServiceReminderArgumentModel(
                          controller.notificationModel,
                          controller.service.start)),
                  icon: Icon(
                    Icons.settings,
                    color: Colors.blue,
                  ),
                )
            ] else
              SizedBox.shrink()
          ],
          bottom: (UserService.isIamAdmin)
              ? TabBar(tabs: [
                  Tab(
                    child: Text(
                      tr[71],
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Tab(
                    child: Text(
                      tr[72],
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ])
              : null),
    );
  }
}
