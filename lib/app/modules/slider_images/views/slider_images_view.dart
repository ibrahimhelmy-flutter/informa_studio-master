import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:inforamclub/app/core/controllers/controller.dart';
import 'package:inforamclub/app/core/widgets/add_floating_button_widget.dart';

import '../slider_image_card_widget.dart';

class SliderImagesView extends GetView<CoreController> {
  @override
  Widget build(BuildContext context) {
    final images = controller.sliderImages;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          floatingActionButton: AddFloatingButton(
            onPressed: controller.addSliderImage,
          ),
          body: GetBuilder<CoreController>(builder: (_) {
            return images.length == 0
                ? Center(
              child: Text('empty'),
            )
                : ListView.builder(
              padding: EdgeInsets.only(
                bottom: 100,
              ),
              itemCount: images.length,
              itemBuilder: (BuildContext context, int index) {
                return SliderImageCard(index);
              },
            );
          })
      ),
    );
  }
}
