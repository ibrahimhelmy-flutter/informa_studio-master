import 'package:get/get.dart';

import '../controllers/service_type_form_controller.dart';

class ServiceTypeFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceTypeFormController>(
      () => ServiceTypeFormController(),
    );
  }
}
