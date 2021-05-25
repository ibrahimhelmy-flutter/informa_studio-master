import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/routes/app_pages.dart';
import 'package:inforamclub/app/core/app_localizatioan/localization.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final tr = Localization.of(context).languageCode;

    return (new FlatButton(
      padding: const EdgeInsets.only(
        top: 10.0,
      ),
      onPressed: ()=>Get.toNamed(Paths.REGISTER),
      child: new Text(
        tr[18],
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        style: new TextStyle(
            fontWeight: FontWeight.w300,
            letterSpacing: 0.5,
            color: Colors.black,
            fontSize: 15.0),
      ),
    ));
  }
}
