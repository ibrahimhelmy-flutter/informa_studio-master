import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:inforamclub/app/core/firestore_resources/users_firestore_resource.dart';
import 'package:inforamclub/app/core/services/user.dart';
import 'package:inforamclub/app/routes/app_pages.dart';

import '../controllers/users_controller.dart';

class UsersView extends GetView<UsersController> {
  @override
  Widget build(BuildContext context) {
    Get.put(UsersController());
    // UserFirestoreResource().listenToCollection().
    return Scaffold(body: GetBuilder<UsersController>(builder: (_) {
      final users = controller.users;

      if (users != null) {
        return Column(
          children: [


            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                )),
                onChanged: controller.onChanged,
              ),
            ),
            SizedBox(
              height: 20,
            ),


            Expanded(
              child: controller.displayedList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.search,
                            size: 20,
                          ),
                          Text('Not found')
                        ],
                      ),
                    )
                  : ListView.separated(
                      itemCount: controller.displayedList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final user = users[index];
                        return Card(
                          child: Column(
                            children: [
                              ListTile(
                                trailing:
                                    Icon(Icons.arrow_forward_ios_outlined),
                                onTap: () => Get.toNamed(Routes.USER_PROFILE,
                                    arguments: user.id),
                                title:
                                    Text(user.firstName + ' ' + user.lastName),
                                subtitle: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.phone,
                                      color: Colors.green,
                                      size: 10,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(user.phone),
                                  ],
                                ),
                                leading: user.picUrl == null
                                    ? null
                                    : CircleAvatar(
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                                user.picUrl)),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.blue),
                                    ),
                                    onPressed: () =>
                                        controller.toggleAdmin(index),
                                    child: GetBuilder<UsersController>(
                                      builder: (_) => Text(
                                          UserService.isAdmin(user)
                                              ? 'Delete from admins'
                                              : 'Add to admins'),
                                    ),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.blue),
                                    ),
                                    onPressed: () => controller.delete(index),
                                    child: GetBuilder<UsersController>(
                                      builder: (_) => Text('delete'),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                    ),
            ),
          ],
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    }));
  }
}
