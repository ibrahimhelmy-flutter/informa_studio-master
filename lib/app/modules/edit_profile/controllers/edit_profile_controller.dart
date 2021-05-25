import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/controllers/controller.dart';
import 'package:inforamclub/app/core/controllers/test.dart';
import 'package:inforamclub/app/core/firestore_resources/users_firestore_resource.dart';
import 'package:inforamclub/app/core/helpers/helper.dart';
import 'package:inforamclub/app/core/models/user_model.dart';
import 'package:inforamclub/app/core/services/user.dart';
import 'package:inforamclub/app/modules/profile/controllers/profile_controller.dart';
import 'package:inforamclub/app/modules/root/controllers/root_controller.dart';

class EditProfileController extends WeightHeightGenderController {
  final form = Helper.form;
  var isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    UserModel userModel = Get.arguments;

    height = userModel.height.obs;
    weight = userModel.weight.obs;
    gender = userModel.gender.obs;

    form.patchValue(
        {...userModel.toMap, 'passwordConfirmation': userModel.password});
  }

  Future<void> confirm() async {
    if (form.valid) {
      isLoading(true);
      final result = await UserFirestoreResource()
          .collectionReference
          .doc(UserService.id)
          .update({
        ...form.value,
        'height': num.parse(height.value.toStringAsFixed(2)),
        'weight': num.parse(weight.value.toStringAsFixed(2)),
        'gender': gender.value,
      });
      Get.find<MyProfileController>().update();
      Get.find<RootController>().update();
      isLoading(false);
    } else {
      form.markAllAsTouched();
    }
  }
}
