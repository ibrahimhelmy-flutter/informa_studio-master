import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inforamclub/app/core/controllers/controller.dart';
import 'package:inforamclub/app/core/firestore_resources/about_us_firestore_resource.dart';
import 'package:inforamclub/app/core/models/about_us.dart';
import 'package:inforamclub/app/routes/app_pages.dart';

class AboutUsFormController extends GetxController {
  var isLoading = false.obs;

  LatLng latLng;

  var formKey = GlobalKey<FormBuilderState>();
  AboutUsModel aboutUsModel;

  Future<void> confirm() async {
    final formState = formKey.currentState;
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      final formValue = formState.value;
      isLoading(true);
      final newAboutUs = AboutUsModel().fromMap(formValue);

      final coreController = Get.find<CoreController>();
      await AboutUsFirestoreResource().update(newAboutUs);
      coreController.aboutUs = newAboutUs;
      coreController.update();

      isLoading(false);
    }
  }

  Future<void> pickLocation() async {
    final result = await Get.toNamed(Routes.LOCATION_ON_MAP);
    LatLng latLng = result;
    formKey.currentState.fields['waze']
        .didChange('${latLng.latitude}-${latLng.longitude}');
  }
}
