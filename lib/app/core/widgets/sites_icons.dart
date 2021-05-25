import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/controllers/controller.dart';
import 'package:inforamclub/app/core/widgets/site_icon_widget.dart';
import 'package:inforamclub/app/modules/root/controllers/root_controller.dart';

class SitesIcon extends GetView<CoreController> {
  final MainAxisAlignment mainAxisAlignment;
  final Size size;

  SitesIcon({this.size, this.mainAxisAlignment = MainAxisAlignment.start});

  @override
  Widget build(BuildContext context) {
    Get.put(RootController());

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        SiteIcon(
          size: size,
          onTap: controller.launchWhatsapp,
          assetPath: 'assets/images/whatsapp.svg',
        ),
        SizedBox(
          width: 10,
        ),
        SiteIcon(
          size: size,
          onTap: controller.launchInstagram,
          assetPath: 'assets/images/instagram.svg',
        ),
        SizedBox(
          width: 10,
        ),
        SiteIcon(
          size: size,
          onTap: controller.launchWaze,
          assetPath: 'assets/images/waze.svg',
        ),
      ],
    );
  }
}
