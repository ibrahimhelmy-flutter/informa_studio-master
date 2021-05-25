import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawerbehavior/drawer_scaffold.dart';
import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:inforamclub/app/core/app_localizatioan/localization.dart';
import 'package:inforamclub/app/core/controllers/controller.dart';
import 'package:inforamclub/app/core/firestore_resources/users_firestore_resource.dart';
import 'package:inforamclub/app/core/models/user_model.dart';
import 'package:inforamclub/app/core/services/user.dart';
import 'package:inforamclub/app/modules/root/widgets/drawer_body_widget.dart';
import 'package:inforamclub/app/modules/root/widgets/drawer_footer_widget.dart';
import 'package:inforamclub/app/routes/app_pages.dart';

import '../controllers/root_controller.dart';

class RootView extends GetView<RootController> {
  @override
  Widget build(BuildContext context) {
    Get.put(RootController());
    final tr = Localization.of(context).languageCode;

    final coreController = Get.find<CoreController>();
    return GetBuilder<CoreController>(builder: (_) {
      if (coreController.currentLoggedUser == null)
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      return GetBuilder<RootController>(
        builder: (_) => WillPopScope(
          onWillPop: controller.onPop,
          child: DrawerScaffold(
              onOpened: (x) {
                controller.update();
              },
              controller: controller.drawerScaffoldController,
              drawers: [
                SideDrawer(
                    duration: Duration(milliseconds: 200),
                    footerView: Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: DrawerFooter(),
                    ),
                    percentage: 0.9,
                    menu: Menu(items: [
                      MenuItem<int>(
                        id: 0,
                        title: tr[19],
                      ),
                      MenuItem<int>(
                        id: 1,
                        title: tr[20],
                      ),
                      MenuItem<int>(
                        id: 2,
                        title: tr[21],
                      ),
                      if (UserService.isAdmin(
                          coreController.currentLoggedUser)) ...[
                        MenuItem<int>(
                          id: 3,
                          title: tr[22],
                        ),
                        MenuItem<int>(
                          id: 4,
                          title: tr[23],
                        ),
                        MenuItem<int>(
                          id: 5,
                          title: tr[24],
                        ),
                        MenuItem<int>(
                          id: 6,
                          title: tr[25],
                        ),
                        MenuItem<int>(
                          id: 7,
                          title: tr[26],
                        ),
                      ],
                      MenuItem<int>(
                        id: 8,
                        title: tr[27],
                      ),
                    ]),
                    direction: Direction.left,
                    animation: false,
                    drawerWidth: 200,
                    degree: 1,
                    cornerRadius: 20,
                    color: Colors.white,
                    selectedItemId: controller.selectedMenuItemId,
                    onMenuItemSelected: controller.onMenuItemSelected)
              ],
              builder: (context, id) => Column(
                    children: [
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: AppBar(
                          leading: IconButton(
                            onPressed: controller.toggleDrawer,
                            icon: Icon(Icons.menu),
                          ),
                          backgroundColor: Colors.white,
                          elevation: 0,
                          // actions: [
                          //   if (Get.find<RootController>().user.isAdmin)
                          //     IconButton(
                          //         icon: Icon(Icons.add),
                          //         onPressed: () =>
                          //
                          // ],
                          iconTheme: IconThemeData(color: Colors.purple),
                        ),
                      ),
                      Expanded(child: DrawerBody()),
                    ],
                  )),
        ),
      );
    });
  }
}
