import 'package:get/get.dart';

import '../controllers/slider_images_controller.dart';

class SliderImagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SliderImagesController>(
      () => SliderImagesController(),
    );
  }
}
