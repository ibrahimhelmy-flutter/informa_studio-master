import 'package:get/get.dart';

import '../controllers/my_registered_services_controller.dart';

class MyRegisteredServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyRegisteredServicesController>(
      () => MyRegisteredServicesController(),
    );
  }
}
