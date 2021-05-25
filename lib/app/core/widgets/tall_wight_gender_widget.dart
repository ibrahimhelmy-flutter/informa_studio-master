import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/app_localizatioan/localization.dart';
import 'package:inforamclub/app/core/controllers/test.dart';

import 'custom_slider.dart';
import 'gender_card_widget.dart';

class TallWeightGender<T extends WeightHeightGenderController> extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller =Get.find<T>();
    final tr = Localization.of(context).languageCode;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Obx(
                () => GenderCard(
                  onTap: () => controller.selectGender('Male'),
                  isSelected: controller.gender.value == 'Male',
                  iconData: FontAwesomeIcons.male,
                  text: tr[8],
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Obx(
                () => GenderCard(
                  onTap: () => controller.selectGender('Female'),
                  isSelected: controller.gender.value == 'Female',
                  iconData: FontAwesomeIcons.female,
                  text: tr[9],
                ),
              ),
            ),
          ],
        ),
        Obx(
          () => CustomSlider(
            title: tr[41],
            min: 30.0,
            max: 300,
            label: controller.height.value.toStringAsFixed(2),
            onChanged: controller.onChangedHeight,
            value: controller.height.value,
          ),
        ),
        Obx(
          () => CustomSlider(
            title: tr[42],
            min: 20.0,
            max: 200,
            label: controller.weight.value.toStringAsFixed(2),
            onChanged: controller.onChangedWeight,
            value: controller.weight.value,
          ),
        ),
      ],
    );
  }
}
