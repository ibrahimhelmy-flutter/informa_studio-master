import 'package:inforamclub/app/core/controllers/controller.dart';
import 'package:inforamclub/app/modules/profile/views/widgets/my_profile_pircture_widget.dart';
import 'package:flutter/material.dart';
import 'package:inforamclub/app/core/models/user_model.dart';
import 'package:inforamclub/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/widgets/profile_widgets.dart';
import 'package:inforamclub/app/core/widgets/language_tile.dart';
import 'package:inforamclub/app/modules/root/controllers/root_controller.dart';
import 'package:inforamclub/app/routes/app_pages.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MyProfileView extends StatelessWidget {
   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Get.put(MyProfileController());

    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.EDIT_PROFILE,
            arguments: Get.find<CoreController>().currentLoggedUser),
        child: Container(
          width: 70,
          height: 70,
          child: Icon(Icons.edit),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.deepPurple[800], Colors.deepPurpleAccent],
              )),
        ),
      ),
      body: GetBuilder<MyProfileController>(builder: (_) {
        return Profile(
          languageTile: LanguageTile(),
          profilePic: MyProfilePicture(),
          data: Get.find<CoreController>().currentLoggedUser,
        );
      }),
    );
  }
}
