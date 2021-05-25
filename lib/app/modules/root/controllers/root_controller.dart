import 'dart:io';

import 'package:drawerbehavior/drawer_scaffold.dart';
import 'package:drawerbehavior/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/services/user.dart';
import 'package:inforamclub/app/core/widgets/pop_up.dart';
import 'package:inforamclub/app/routes/app_pages.dart';

class RootController extends GetxController {
  int selectedMenuItemId = 0;

  DrawerScaffoldController drawerScaffoldController =
      DrawerScaffoldController();

  List<MenuItem> items;

  final pageController = PageController();

  Future<bool> onPop() async {
    if (drawerScaffoldController.isOpen()) {
      return true;
    }
    if (pageController.page == 0) {
      PopUp.showConfirmAlert(() {
        exit(0);
      });
    }
    selectedMenuItemId = 0;
    update();
    pageController.jumpToPage(0);

    return false;
  }

  void toggleDrawer() => drawerScaffoldController.toggle();

  void logout() {
    PopUp.showConfirmAlert(() async {
      Get.offAllNamed(Paths.LOGIN);
      UserService.logout();

    });
  }

  void onMenuItemSelected(itemId) {
    pageController.jumpToPage(itemId);
    selectedMenuItemId = itemId;
    update();
  }
}
