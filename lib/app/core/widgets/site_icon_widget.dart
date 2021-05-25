import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/modules/root/controllers/root_controller.dart';

class SiteIcon extends GetView<RootController> {
  final String assetPath;
  final GestureTapCallback onTap;
  final Size size;

  const SiteIcon(
      {Key key, this.size = const Size(40, 40), this.assetPath, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        assetPath,
        width: size.width,
        height: size.height,
      ),
    );
  }
}
