import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/app_localizatioan/localization.dart';

class PopUp {
  static void showSnackBar(String message, {String title}) {
    ScaffoldMessenger.of(Get.context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  static void showConfirmAlert(VoidCallback onConfirm) {
    final lng =Localization.of(Get.context).languageCode;
    CoolAlert.show(
        context: Get.context,
        confirmBtnText:lng[63] ,
        cancelBtnText: lng[64],
        title: lng[62],
        type: CoolAlertType.confirm,
        onConfirmBtnTap: () {
          onConfirm();
          Get.back();
        });
  }
}
