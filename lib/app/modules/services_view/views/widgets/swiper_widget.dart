import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/controllers/controller.dart';
import 'package:inforamclub/app/modules/services_view/controllers/services_view_controller.dart';

class MySlider extends GetView<ServicesViewController> {
  @override
  Widget build(BuildContext context) {
    final images = Get.find<CoreController>().sliderImages;
    return Swiper(

      autoplay: true,
      viewportFraction: 1,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            child: new CachedNetworkImage(
              imageUrl: images[index].url,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      itemCount: images.length,
      pagination: new SwiperPagination(),
    );
  }
}
