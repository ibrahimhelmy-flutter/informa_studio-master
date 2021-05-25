import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/app_localizatioan/language_model_data.dart';
import 'package:inforamclub/app/modules/profile/controllers/profile_controller.dart';
import 'package:inforamclub/app/core/app_localizatioan/localization.dart';
import 'package:inforamclub/main.dart';

import 'language_selector_botton_sheet_widget.dart';

class LanguageTile extends GetView<MyProfileController> {
  @override
  Widget build(BuildContext context) {
    final tr = Localization.of(context).languageCode;

    return ListTile(
      trailing: Icon(
        Icons.arrow_forward_ios_outlined,
        size: 17,
      ),
      /*     trailing: DropdownButton(
          icon: Icon(Icons.more_horiz),
          onTap: () {},
          onChanged: controller.changeLanguage,
          items: supportedLanguages
              .map((e) => DropdownMenuItem(
                  value: e.code,
                  child: Text(
                    e.name,
                  )))
              .toList()),*/
      onTap: () => showModalBottomSheet(
          context: context, builder: (_) => LanguageSelectorBottomSheet()),
      title: Text(tr[40]),
      subtitle: Text(supportedLanguages
          .where((element) => element.code == box.get('languageCode'))
          .first
          .name),
      leading: Icon(
        FontAwesomeIcons.language,
        color: Colors.purple,
        size: 35,
      ),
    );
  }
}
