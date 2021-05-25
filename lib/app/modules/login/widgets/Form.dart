import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/app_localizatioan/localization.dart';
import 'package:inforamclub/app/modules/login/controllers/login_controller.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../core/widgets/InputFields.dart';

class LoginForm extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {

    final tr = Localization.of(context).languageCode;

    return (new Container(
      margin: new EdgeInsets.symmetric(horizontal: 20.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new ReactiveForm(
              formGroup: controller.form,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new InputFieldArea(

                    formControlName: 'email',
                    hint: tr[2],
                    obscure: false,
                    icon: Icons.person_outline,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  new InputFieldArea(

                    formControlName: 'password',
                    hint: tr[4],
                    obscure: true,
                    icon: Icons.lock_outline,
                  ),
                ],
              )),
        ],
      ),
    ));
  }
}
