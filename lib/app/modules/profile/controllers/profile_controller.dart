import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inforamclub/app/core/controllers/controller.dart';
import 'package:inforamclub/app/core/firestore_resources/users_firestore_resource.dart';
import 'package:inforamclub/app/core/services/fire_storage_service.dart';
import 'package:inforamclub/app/core/services/user.dart';
import 'package:inforamclub/app/modules/profile/widgets/profile_bottom_sheet_widget.dart';

class MyProfileController extends GetxController {
  var selectedImagePath = ''.obs;
  List<String> gender = ['Male', 'Female'];
  var isUploadingImage = false.obs;

  Future<void> changeProfilePicture(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return ProfileBottomSheetWidget();
        });
  }

  Future<void> changeAvatar(ImageSource imageSource) async {
    final pickedImage =
    await ImagePicker.platform.pickImage(source: imageSource);
    final pickedImagePath = pickedImage.path;

    if (pickedImagePath == null) return;



    this.isUploadingImage(true);
    Get.back();
    UserFirestoreResource().update(Get
        .find<CoreController>()
        .currentLoggedUser
        .copyWith(picUrl: await FireStorageService.uploadFile(
        'PROFILE_IMAGES', pickedImagePath)), UserService.id);

    this.selectedImagePath.value = pickedImagePath;
    this.isUploadingImage(false);
  }
}
