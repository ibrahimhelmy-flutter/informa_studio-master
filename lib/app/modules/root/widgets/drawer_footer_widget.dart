import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/app_localizatioan/localization.dart';
import 'package:inforamclub/app/core/controllers/controller.dart';
import 'package:inforamclub/app/core/widgets/site_icon_widget.dart';
import 'package:inforamclub/app/modules/root/controllers/root_controller.dart';

class DrawerFooter extends GetView<RootController> {
  @override
  Widget build(BuildContext context) {
    final tr = Localization.of(Get.context).languageCode;
    final coreController =Get.find<CoreController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 40,
            ),
            SiteIcon(
              onTap: coreController.launchWhatsapp,
              assetPath: 'assets/images/whatsapp.svg',
            ),
            SizedBox(
              width: 10,
            ),
            SiteIcon(
              onTap: coreController.launchInstagram,
              assetPath: 'assets/images/instagram.svg',
            ),
            SizedBox(
              width: 10,
            ),
            SiteIcon(
              onTap: coreController.launchWaze,
              assetPath: 'assets/images/waze.svg',
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.only(right: 150, top: 30,),
          child: GlowButton(
            width: 140,
              child: Text(
                tr[70],
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red,
              onPressed: controller.logout),
        ),
      ],
    );
  }
}
