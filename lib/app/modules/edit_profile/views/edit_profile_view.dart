import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:inforamclub/app/core/app_localizatioan/localization.dart';
import 'package:inforamclub/app/core/services/user.dart';
import 'package:inforamclub/app/core/widgets/register_form.dart';
import 'package:inforamclub/app/core/widgets/tall_wight_gender_widget.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  @override
  Widget build(BuildContext context) {
    final tr = Localization.of(context).languageCode;

    print(UserService.id);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  tr[78],
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  tr[79],
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(icon: Icon(Icons.check), onPressed: controller.confirm)
          ],
        ),
        body: Obx(
          () => ModalProgressHUD(
            inAsyncCall: controller.isLoading.value,
            child: TabBarView(
              children: [
                ReactiveForm(
                  formGroup: controller.form,
                  child: ListView(
                    padding: EdgeInsets.all(20),
                    children: [
                      RegisterForm(
                        isEdit: true,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TallWeightGender<EditProfileController>(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
