import 'package:get/get.dart';

import '../controllers/reminder_setting_controller.dart';

class ReminderSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReminderSettingController>(
      () => ReminderSettingController(),
    );
  }
}
