import 'package:reactive_forms/reactive_forms.dart';

class Helper {

  static final form = FormGroup({
    'firstName': FormControl<String>(validators: [
      Validators.required,
      Validators.minLength(2),
    ]),
    'lastName': FormControl<String>(validators: [
      Validators.required,
      Validators.minLength(2),
    ]),
    'identityCard': FormControl<String>(validators: [
      Validators.required,
      Validators.minLength(9),
    ]),
    // 'gender': FormControl<String>(validators: [
    //   Validators.required,
    // ]),
    'password': FormControl<String>(
        validators: [Validators.required, Validators.minLength(6)]),
    'passwordConfirmation': FormControl<String>(validators: [
      Validators.required,
      Validators.minLength(6),
    ]),
    'phone': FormControl<String>(validators: [
      Validators.required,

      Validators.minLength(9),
    ]),
    'email': FormControl<String>(validators: [
      Validators.required,
      Validators.email,
    ]),
  }, validators: [
    Validators.mustMatch('password', 'passwordConfirmation'),
  ]);

}