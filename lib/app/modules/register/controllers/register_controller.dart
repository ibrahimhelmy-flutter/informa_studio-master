import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/controllers/test.dart';
import 'package:inforamclub/app/core/firestore_resources/identity_cards_firestore_resource.dart';
import 'package:inforamclub/app/core/firestore_resources/users_firestore_resource.dart';
import 'package:inforamclub/app/core/helpers/helper.dart';
import 'package:inforamclub/app/core/models/user_model.dart';
import 'package:inforamclub/app/core/services/user.dart';
import 'package:inforamclub/app/core/widgets/pop_up.dart';
import 'package:inforamclub/app/routes/app_pages.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RegisterController extends WeightHeightGenderController {
  var isLoading = false.obs;

  void completeRegister() {
    if (form.valid) {
      Get.toNamed(Routes.COMPLETE_REGISTER);
    } else {
      form.markAllAsTouched();
    }
  }

  FormGroup form;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    form = Helper.form;
  }

  void fillForm() {
    form.control('firstName').updateValue('Mohamed');
    form.control('lastName').updateValue('Gaber');
    form.control('email').updateValue('mo4gaber@gmail.com');
    form.control('password').updateValue('123456');
    form.control('passwordConfirmation').updateValue('123456');
    form.control('identityCard').updateValue('987654321');
    form.control('phone').updateValue('1234567898');
  }

  void showError(String text) {
    PopUp.showSnackBar(text);
    Get.back();
    isLoading(false);
  }

  Future<void> register() async {
    final formValue = form.value;
    isLoading(true);

    try {
      if (!await IdentityCardFirestoreResource()
          .isValid(formValue['identityCard'])) {
        showError('invalid id card number');
        return;
      }

      final userFirestoreResource = UserFirestoreResource();
      if (!await userFirestoreResource.isValidEmail(formValue['email'])) {
        showError('email-already-in-use');
        return;
      }
      print(formValue);
      await userFirestoreResource.add(UserModel().fromMap({
        ...formValue,
        'notificationToken': await UserService.notificationToken,
        'height': num.parse(height.value.toStringAsFixed(2)),
        'weight': num.parse(weight.value.toStringAsFixed(2)),
        'gender': gender.value,
      }));

      isLoading(false);
      Get.toNamed(Paths.LOGIN);
    } catch (e) {
      showError('Try again');
      throw e;
    }
  }
}
