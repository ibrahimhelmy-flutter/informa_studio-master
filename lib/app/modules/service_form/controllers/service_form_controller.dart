import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/firestore_resources/services_firestore_resource.dart';
import 'package:inforamclub/app/core/models/service_model.dart';
import 'package:inforamclub/app/core/widgets/pop_up.dart';
import 'package:inforamclub/app/modules/services_view/controllers/services_view_controller.dart';

class ServiceFormController extends GetxController {
  Future future;
  final formKey = GlobalKey<FormBuilderState>();
  var isLoading = false.obs;


  Duration exerciseDuration = Duration(minutes: 60);

  Future<void> confirm() async {

    final formCurrentState = formKey.currentState;
    if (formCurrentState.validate()) {
      formCurrentState.save();
      final formValue = formCurrentState.value;
      DateTime startDate = formValue['date'];
      if (startDate.hour == 0 &&
          startDate.minute == 0 &&
          startDate.second == 0) {
        PopUp.showSnackBar('حدد وقت بداية التمرين');
        return ;
      }

      final endDate = (startDate.add(exerciseDuration));
      isLoading(true);

      final service = ServiceModel().fromMap({
        ...formValue,
        'end': endDate,
      });
      await ServicesFirestoreResource().add(service);
      isLoading(false);
    }
  }

  void onChangeDurationPicker(Duration duration) {
    exerciseDuration = duration;
  }

  FormBuilderState get formState => formKey.currentState;

  Map<String, dynamic> get formStateValue => formKey.currentState.value;
}
