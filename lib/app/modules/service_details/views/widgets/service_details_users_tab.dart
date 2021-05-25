import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/firestore_resources/services_firestore_resource.dart';
import 'package:inforamclub/app/modules/service_details/controllers/service_details_controller.dart';
import 'package:inforamclub/app/modules/users/controllers/users_controller.dart';
import 'package:inforamclub/app/routes/app_pages.dart';
import 'package:intl/intl.dart';

class ServiceDetailsUsers extends GetView<ServiceDetailsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceDetailsController>(builder: (_) {
      final users = controller.joinedUsers;
      if (users == null) return Center(child: CircularProgressIndicator());

      return users.isEmpty
          ? Center(
              child: Text('Users list is empty now !'),
            )
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) {
                final user = users[index].userModel;
                return ListTile(
                  onTap: () =>
                      Get.toNamed(Routes.USER_PROFILE, arguments: user.id),
                  trailing: IconButton(

                    onPressed: () =>
                        controller.removeUser(user),
                    icon: Icon(Icons.cancel_rounded),
                  ),
                  subtitle: Text(DateFormat().format(users[index].at)),
                  leading: CircleAvatar(
                    backgroundImage: user.picUrl == null
                        ? AssetImage('assets/images/empty-avatar.jpg')
                        : CachedNetworkImageProvider(user.picUrl),
                  ),
                  title: Text(user.name),
                );
              });
    });
  }
}
