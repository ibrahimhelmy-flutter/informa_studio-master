

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/app_localizatioan/language_model_data.dart';
import 'package:inforamclub/app/modules/profile/controllers/profile_controller.dart';
import 'package:inforamclub/main.dart';

class LanguageSelectorBottomSheet extends GetView<MyProfileController> {
  const LanguageSelectorBottomSheet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...supportedLanguages
              .map((e) => Column(
                    children: [
                      ListTile(
                        onTap: () async {
                          final languageCode = e.code;
                          await box.put('languageCode', languageCode);
                          Get.updateLocale(Locale(languageCode));
                          Navigator.pop(context);
                        },
                        trailing: Icon(
                          Icons.check_circle_rounded,
                          color: LanguageUtility.currentLanguage == e
                              ? Colors.green
                              : Colors.grey,
                        ),
                        title: Text(e.name),
                      ),
                      Divider()
                    ],
                  ))
              .toList()
        ],
      ),
    );
  }
}
