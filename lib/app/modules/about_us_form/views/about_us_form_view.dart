import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:inforamclub/app/core/controllers/controller.dart';
import 'package:inforamclub/app/modules/about_us_form/controllers/about_us_form_controller.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AboutUsFormView extends GetView<AboutUsFormController> {
  @override
  Widget build(BuildContext context) {
    final coreController = Get.find<CoreController>();
    final aboutUs = coreController.aboutUs;

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: controller.confirm,
      ),
      body: Obx(
        () => coreController.isAboutUsLoading.value
            ? Center(child: CircularProgressIndicator())
            : Obx(
                () => ModalProgressHUD(
                  inAsyncCall: controller.isLoading.value,
                  child: FormBuilder(
                    key: controller.formKey,
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        FormBuilderTextField(
                          initialValue: aboutUs.instagram,
                          maxLines: null,
                          validator: FormBuilderValidators.required(context),
                          decoration: InputDecoration(hintText: 'Instagram'),
                          name: 'instagram',
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        FormBuilderTextField(
                          initialValue: aboutUs.wazeToString,
                          maxLines: null,
                          validator: FormBuilderValidators.required(context),
                          name: 'waze',
                          readOnly: true,
                          valueTransformer: (value) => GeoPoint(
                              double.parse(value.split('-')[0]),
                              double.parse(value.split('-')[1])),
                          onTap: controller.pickLocation,
                          decoration: InputDecoration(hintText: 'Waze'),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        FormBuilderTextField(
                          initialValue: aboutUs.whatsApp,
                          maxLines: null,
                          inputFormatters: [],
                          keyboardType: TextInputType.phone,
                          maxLength: 9,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            // FormBuilderValidators.minLength(context, 9),
                            // FormBuilderValidators.maxLength(context, 9),
                          ]),
                          decoration: InputDecoration(
                            prefixText: '+972 ',
                            hintText: 'Whatsapp',
                          ),
                          name: 'whatsApp',
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        FormBuilderTextField(
                          initialValue: aboutUs.text,
                          validator: FormBuilderValidators.required(context),
                          maxLines: null,
                          decoration: InputDecoration(hintText: 'About us'),
                          name: 'text',
                        ),
                        SizedBox(
                          height: 120,
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
