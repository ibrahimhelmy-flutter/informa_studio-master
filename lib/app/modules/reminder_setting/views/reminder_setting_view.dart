import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/reminder_setting_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:inforamclub/app/modules/service_details/controllers/service_details_controller.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/app_localizatioan/localization.dart';
import 'package:inforamclub/app/core/models/schedule_notification_model.dart';
import 'package:inforamclub/app/modules/service_details/controllers/service_details_controller.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ReminderSettingView extends GetView<ReminderSettingController> {
  @override
  Widget build(BuildContext context) {
      final tr = Localization.of(context).languageCode;

      return Scaffold(
          appBar: AppBar(
            title: Text('ReminderView'),
            centerTitle: true,
          ),
          body: GetBuilder<ServiceDetailsController>(builder: (_) {
            return Obx(
                  () => ModalProgressHUD(
                inAsyncCall: controller.isReminderSaving.value,
                child: Scaffold(
                  floatingActionButton: FloatingActionButton(
                    child: Icon(Icons.check),
                    onPressed: controller.saveScheduleNotification,
                  ),
                  body: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
/*
                      ListTile(
                        trailing: ToggleSwitch(
                          minWidth: 90.0,
                          cornerRadius: 10.0,
                          activeBgColor: Colors.cyan,
                          activeFgColor: Colors.white,
                          inactiveBgColor: Colors.grey,
                          inactiveFgColor: Colors.white,
                          labels: [tr[63], tr[64]],
                          initialLabelIndex: controller.isReminderEnabled ? 0 : 1,
                          icons: [FontAwesomeIcons.check, FontAwesomeIcons.times],
                          onToggle: controller.onToggle,
                        ),
                        title: Text(tr[77]),
                      ),
*/
                      SizedBox(
                        height: 20,
                      ),
                      if (controller.isReminderEnabled)
                        Column(
                          children: [
                            CupertinoTimerPicker(
                              initialTimerDuration: controller.duration,
                              mode: CupertinoTimerPickerMode.hm,
                              onTimerDurationChanged:
                              controller.onTimerDurationChanged,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: FormBuilder(
                                key: controller.formKey,
                                child: FormBuilderTextField(
                                  onChanged: controller.onTextFieldChanged,
                                  validator:
                                  FormBuilderValidators.required(context),
                                  initialValue: controller.notificationModel.body,
                                  name: 'body',
                                ),
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              ),
            );
          }));
    }
}
