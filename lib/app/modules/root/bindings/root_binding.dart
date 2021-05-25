import 'package:get/get.dart';
import 'package:inforamclub/app/core/controllers/controller.dart';
import '../controllers/root_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoreController>(
          () => CoreController(),
    );


  }
}
