import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_glow/flutter_glow.dart';

import 'package:get/get.dart';

import '../controllers/send_notification_controller.dart';
import 'package:inforamclub/app/core/app_localizatioan/localization.dart';

class SendNotificationView extends GetView<SendNotificationController> {
  @override
  Widget build(BuildContext context) {

    final tr = Localization.of(context).languageCode;

    Get.put(SendNotificationController());
    return Scaffold(
      appBar: AppBar(
        title: Text('SendNotificationView'),
        centerTitle: true,
      ),
      body: FormBuilder(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              Text(
                '${tr[24]} ...',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 40,
              ),
              FormBuilderTextField(
                name: 'title',
                decoration: InputDecoration(hintText: tr[29]),
              ),
              SizedBox(
                height: 45,
              ),
              FormBuilderTextField(
                  decoration: InputDecoration(hintText: tr[30]), name: 'body'),
              SizedBox(
                height: 45,
              ),
              FormBuilderDropdown(
                initialValue: 'Male',
                items: ['Male', 'Female']
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                name: 'gender',
              ),
              SizedBox(
                height: 200,
              ),
              Center(
                child: GlowButton(
                  color: Colors.green,
                  onPressed: controller.send,
                  width: 250,
                  height: 50,
                  child: Text(
                    'Send now',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
