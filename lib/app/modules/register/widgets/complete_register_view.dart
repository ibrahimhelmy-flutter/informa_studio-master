import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:inforamclub/app/core/widgets/custom_slider.dart';
import 'package:inforamclub/app/core/widgets/gender_card_widget.dart';
import 'package:inforamclub/app/modules/register/controllers/register_controller.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:inforamclub/app/core/app_localizatioan/localization.dart';

class CompleteRegisterView<T> extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {

    final tr = Localization.of(context).languageCode;

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.register,
        child: Icon(Icons.check),
      ),
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: controller.isLoading.value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   tr[41],
                //   style: TextStyle(
                //       fontFamily: GoogleFonts.cairo().fontFamily,
                //       fontSize: 23,
                //       fontWeight: FontWeight.bold),
                // ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => GenderCard(
                          onTap: () => controller.selectGender('Male'),
                          isSelected:
                              controller.gender.value == 'Male' ,
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
            ),
          ),
        ),
      ),
    );
  }
}
