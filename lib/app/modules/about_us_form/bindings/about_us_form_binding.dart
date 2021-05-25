import 'package:get/get.dart';
import 'package:inforamclub/app/modules/about_us_form/controllers/about_us_form_controller.dart';


class AboutUsFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutUsFormController>(
      () => AboutUsFormController(),
    );
  }
}
