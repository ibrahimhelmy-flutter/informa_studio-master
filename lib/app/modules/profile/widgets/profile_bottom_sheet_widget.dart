import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inforamclub/app/modules/profile/controllers/profile_controller.dart';

class ProfileBottomSheetWidget extends GetView<MyProfileController> {
  @override
  Widget build(BuildContext context) {


    return Container(
      margin: const EdgeInsets.only(bottom: 50),
      height: 150,
      child: new Wrap(
        children: <Widget>[
          new ListTile(
              leading: new Icon(
                Icons.camera_alt_outlined,
                size: 30,
              ),
              title: new Text('from camera'),
              onTap: () {
                controller.changeAvatar(ImageSource.camera);
              }),
          new Divider(),
          new ListTile(
            leading: new Icon(
              Icons.camera,
              size: 30,
            ),
            title: new Text('from gallery'),
            onTap: () {
              controller.changeAvatar(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }
}
