import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:inforamclub/app/core/app_localizatioan/localization.dart';
import 'package:inforamclub/app/core/widgets/language_tile.dart';
import 'package:inforamclub/app/core/widgets/logo_image_widget.dart';
import 'package:inforamclub/app/modules/login/widgets/Form.dart';
import 'package:inforamclub/app/modules/login/widgets/SignUpLink.dart';

import '../controllers/login_controller.dart';
import 'widgets/flutter_rounded_loading_button-master/lib/rounded_loading_button.dart';

class LoginView extends GetView<LoginController> {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final tr = Localization.of(context).languageCode;
    return new Scaffold(
      key: scaffoldKey,

      body: new Container(
          child: new ListView(
        padding: const EdgeInsets.all(0.0),
        children: <Widget>[
          FlatButton(onPressed: controller.fillForm, child: Text('fill')),
          Hero(tag: 'logo', child: LogoImage()),
          new LoginForm(),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: LanguageTile(),
          ),
          GetBuilder<LoginController>(
            builder: (_) => RoundedLoadingButton(
              borderRadius: ((6)),

              color: Colors.orange,
              child: Text(tr[17], style: TextStyle(color: Colors.white)),
              controller: controller.loadingButtonController,
              onPressed: controller.form.valid ? controller.login : null,
              // animateOnTap:false ,
            ),
          ),
          SignUp(),
        ],
      )),
    );
  }
}
