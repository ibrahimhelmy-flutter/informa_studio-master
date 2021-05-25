import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/modules/about_us/views/about_us_view.dart';
import 'package:inforamclub/app/modules/root/controllers/root_controller.dart';
import 'package:inforamclub/app/modules/my_registered_services/views/my_registered_services_view.dart';
import 'package:inforamclub/app/modules/profile/views/profile_view.dart';
import 'package:inforamclub/app/modules/service_type_form/views/service_type_form_view.dart';
import 'package:inforamclub/app/modules/services_view/views/services_view_view.dart';
import 'package:inforamclub/app/modules/users/views/users_view.dart';
import 'package:inforamclub/app/modules/identity_cards/views/identity_cards_view.dart';
import 'package:inforamclub/app/modules/slider_images/views/slider_images_view.dart';
import 'package:inforamclub/app/modules/send_notification/views/send_notification_view.dart';

class DrawerBody extends GetView<RootController> {
  List<Widget> get pages =>
       [
        ServicesViewView(),
        MyRegisteredServicesView(),
        MyProfileView(),
        ServiceTypeFormView(),
        UsersView(),
        SendNotificationView(),
        IdentityCardsView(),
        SliderImagesView(),
        AboutUsView()
      ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: controller.pageController,
          children: pages,
          physics: NeverScrollableScrollPhysics(),
        ),
        GetBuilder<RootController>(
          builder: (snapshot) {
            return Visibility(
              visible: controller.drawerScaffoldController.isOpen(),
              child: GestureDetector(
                onTap: () {
                  controller.drawerScaffoldController.closeDrawer();
                },
                child: Container(
                  width: Get.width,
                  height: Get.height,
                  color: Colors.transparent,
                ),
              ),
            );
          }
        )

      ],
    );
  }
}
