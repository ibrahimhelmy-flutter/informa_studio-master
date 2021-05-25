import 'package:get/get.dart';
import 'package:inforamclub/app/core/firestore_resources/users_firestore_resource.dart';

class UserProfileController extends GetxController {
  Future future;

  @override
  void onReady() {
    super.onReady();
    future = UserFirestoreResource().get(Get.arguments);
    future.then((value) {
      update();
    });
  }
}
