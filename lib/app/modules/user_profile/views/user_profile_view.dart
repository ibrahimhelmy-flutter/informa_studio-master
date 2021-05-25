import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:inforamclub/app/core/models/user_model.dart';
import 'package:inforamclub/app/core/widgets/profile_widgets.dart';
import 'package:inforamclub/app/modules/user_profile/views/widgets/others_profile_picture_widget.dart';

import '../controllers/user_profile_controller.dart';

class UserProfileView extends GetView<UserProfileController> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<UserProfileController>(
            builder: (_) => FutureBuilder<UserModel>(
                future: controller.future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final data = snapshot.data;
                    return Profile(
                      isMyProfile: false,
                      profilePic: OthersProfilePicture(data.picUrl),
                      data: data,
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
          // IconButton(icon: Icon(Icons.back), onPressed: onPressed)
          BackButton(
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
