import 'package:get/get.dart';

import '../controllers/services_view_controller.dart';

class ServicesViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServicesViewController>(
      () => ServicesViewController(),
    );
  }
}
