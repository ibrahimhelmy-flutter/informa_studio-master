import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/controllers/controller.dart';

class SliderImageCard extends GetView<CoreController> {
 final int index;

  SliderImageCard(this.index);
  @override
  Widget build(BuildContext context) {
    final images = controller.sliderImages;

    return Card(
      margin: EdgeInsets.all(20),
      child: Stack(
        children: [
          CachedNetworkImage(
           imageUrl :  images[index].url,
            height: 200,
            width: Get.width,
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  child: Icon(Icons.remove),
                  onPressed: () => controller.deleteSliderImage(
                      images[index].id, index)),
            ),
          )
        ],
      ),
    );
  }
}
