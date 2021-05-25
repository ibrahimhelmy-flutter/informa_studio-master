import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/helpers/helper.dart';
import 'package:inforamclub/app/core/widgets/logo_image_widget.dart';
import 'package:inforamclub/app/core/widgets/register_form.dart';
import 'package:inforamclub/app/modules/register/controllers/register_controller.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:inforamclub/app/core/app_localizatioan/localization.dart';

class RegisterView extends GetView<RegisterController> {
  Widget get space => SizedBox(
        height: 20,
      );

  @override
  Widget build(BuildContext context) {

    final tr = Localization.of(context).languageCode;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: controller.completeRegister,
        child: Icon(Icons.arrow_forward_ios_outlined),
      ),
      backgroundColor: Color(0xffF9FAFD),
      appBar: AppBar(
        backgroundColor: Color(0xffF9FAFD),
        elevation: 0,
      ),
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: controller.isLoading.value,
          child: ReactiveForm(
            formGroup: Helper.form,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              children: [
                FlatButton(
                    onPressed: controller.fillForm, child: Text('fill form')),

                Hero(
                    tag: 'logo',
                    child: LogoImage(
                      height: 100,
                      width: 200,
                    )),
                Center(
                    child: Text(
                  tr[16],
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                )),
                SizedBox(
                  height: 40,
                ),
                RegisterForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
