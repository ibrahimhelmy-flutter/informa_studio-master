import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/modules/profile/controllers/profile_controller.dart';

class OthersProfilePicture extends GetView<MyProfileController> {
  final String profilePicUrl;

  OthersProfilePicture(this.profilePicUrl);

  @override
  Widget build(BuildContext context) {


    return CircleAvatar(
      radius: 65.0,
      backgroundImage: profilePicUrl == null
          ? AssetImage('assets/images/empty-avatar.jpg')
          : NetworkImage(
              profilePicUrl,
            ),
      backgroundColor: Colors.white,
    );
  }
}
