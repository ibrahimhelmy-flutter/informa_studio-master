import 'package:get/get.dart';
import 'package:inforamclub/app/core/firestore_resources/users_firestore_resource.dart';
import 'package:inforamclub/app/core/widgets/pop_up.dart';
import 'package:inforamclub/app/modules/login/views/widgets/flutter_rounded_loading_button-master/lib/rounded_loading_button.dart';
import 'package:inforamclub/app/routes/app_pages.dart';
import 'package:inforamclub/main.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginController extends GetxController {
  final loadingButtonController = RoundedLoadingButtonController();

  LoginController() {
    form.statusChanged.listen((event) {
      update();
    });
  }

  final form = FormGroup({
    'password': FormControl<String>(
        validators: [Validators.required, Validators.minLength(6)]),
    'email': FormControl<String>(validators: [
      Validators.required,
      Validators.email,
    ]),
  });

  void fillForm() {
    form.controls['email'].updateValue('mo4gaber@gmail.com');
    form.controls['password'].updateValue('123456');
  }

  Future<void> login() async {
    try {
      final formValue = form.value;
      final password = formValue['password'];
      final email = formValue['email'];
      final user = await UserFirestoreResource().login(email, password);
      await box.put('uid', user.id);

      loadingButtonController.success();
      Get.offAllNamed(Paths.ROOT);
    } catch (e) {
      loadingButtonController.stop();

      PopUp.showSnackBar('invalid combination of email and password');
      throw e;
    }
  }
}
