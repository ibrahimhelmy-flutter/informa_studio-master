import 'package:get/get.dart';

import '../controllers/identity_cards_controller.dart';

class IdentityCardsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IdentityCardsController>(
      () => IdentityCardsController(),
    );
  }
}
