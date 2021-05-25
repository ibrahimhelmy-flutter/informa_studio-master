import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/controllers/controller.dart';
import 'package:inforamclub/app/core/models/user_model.dart';
import 'package:inforamclub/app/modules/profile/controllers/profile_controller.dart';
import 'package:inforamclub/app/modules/root/controllers/root_controller.dart';

class MyProfilePicture extends GetView<MyProfileController> {
  @override
  Widget build(BuildContext context) {
    final data = Get.find<CoreController>().currentLoggedUser;


    return Stack(
      children: [
        Obx(
          () => Stack(
            children: [
              CircleAvatar(
                radius: 65.0,
                backgroundImage: controller.selectedImagePath.value.isNotEmpty
                    ? FileImage(File(controller.selectedImagePath.value))
                    : data.picUrl == null
                        ? AssetImage('assets/images/empty-avatar.jpg')
                        : CachedNetworkImageProvider(
                            data.picUrl,
                          ),
                backgroundColor: Colors.white,
              ),
              Visibility(
                visible: controller.isUploadingImage.value,
                child: Positioned.fill(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                      Center(child: CircularProgressIndicator())
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: SizedBox(
                width: 40,
                height: 40,
                child: FloatingActionButton(
                  child: Icon(Icons.camera_alt_outlined),
                  onPressed: () => controller.changeProfilePicture(context),
                )),
          ),
        )      ],
    );
  }
}
