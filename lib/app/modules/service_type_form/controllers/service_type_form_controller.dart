import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/controllers/controller.dart';
import 'package:inforamclub/app/core/firestore_resources/service_types_firestore_resource.dart';
import 'package:inforamclub/app/core/models/service_type.dart';
import 'package:inforamclub/app/core/services/fire_storage_service.dart';
import 'package:path/path.dart' as path;
import 'package:get/utils.dart';

class ServiceTypeFormController extends GetxController {

  final formKey = GlobalKey<FormBuilderState>();

  var isLoading = false.obs;

  Future<void> confirm() async {
    final formState = formKey.currentState;
    if (formState.validate()) {
      formState.save();
      isLoading(true);
      final formStateValue = formState.value;
      final String imagePath = formStateValue['image'];
      final isGif = path.extension(imagePath).toLowerCase() == '.gif';
      Uint8List uint8listImage;
      if (isGif) {
        uint8listImage = File(imagePath).readAsBytesSync();
      } else {
        uint8listImage = await FlutterImageCompress.compressWithFile(
          formStateValue['image'],
          format: CompressFormat.jpeg,
          quality: 100,
        );
      }

      final imageUrl = await FireStorageService.uploadUint8List(
          'SERVICE_TYPES', imagePath, uint8listImage);

      await ServiceTypeFirestoreResource()
          .add(ServiceTypeModel(image: imageUrl, name: formStateValue['name']));
      Get.find<CoreController>().update();
      isLoading(false);
    }
  }
}
