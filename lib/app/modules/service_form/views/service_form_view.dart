import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/controllers/controller.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../controllers/service_form_controller.dart';
import 'widgets/flutter_duration_picker-master/lib/flutter_duration_picker.dart';
import 'package:inforamclub/app/core/app_localizatioan/localization.dart';

class ServiceFormView extends GetView<ServiceFormController> {
  @override
  Widget build(BuildContext context) {
    final tr = Localization.of(context).languageCode;

    final serviceTypes = Get.find<CoreController>().serviceTypes;
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: controller.confirm),
      appBar: AppBar(),
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: controller.isLoading.value,
          child: GetBuilder<CoreController>(
            builder:(_) => serviceTypes==null
                ? Center(child: CircularProgressIndicator())
                : FormBuilder(
                    key: controller.formKey,
                    child: ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      children: [
                        FormBuilderDropdown(
                          name: 'serviceTypeId',
                          decoration: InputDecoration(
                            labelText: tr[39],
                          ),
                          initialValue: serviceTypes[0].id,
                          hint: Text(tr[35]),
                          validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required(context)]),
                          items: serviceTypes
                              .map((serviceType) => DropdownMenuItem(
                                    value: serviceType.id,
                                    child: Text('${serviceType.name}'),
                                  ))
                              .toList(),
                        ),
                        FormBuilderTextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          name: 'maxSubscribers',
                          valueTransformer: (value) => int.parse(value),
                          decoration: InputDecoration(
                            labelText: tr[33],
                          ),
                          validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required(context)]),
                          initialValue: '20',
                        ),
                        FormBuilderDateTimePicker(
                          inputType: InputType.both,
                          format: DateFormat('yyyy-MM-dd HH:mm:ss'),
                          name: 'date',
                          initialDate: DateTime.now(),
                          initialTime: TimeOfDay.now(),
                          initialValue: DateTime.now(),
                          decoration: InputDecoration(
                            labelText: tr[34],
                          ),
                          validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required(context)]),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        DurationPicker(
                          onChange: controller.onChangeDurationPicker,
                          width: 200,
                          height: 200,
                          duration: Duration(seconds:5),
                        ),
                        FormBuilderDropdown(
                          name: 'gender',
                          decoration: InputDecoration(
                            labelText: tr[7],
                          ),
                          initialValue: 'Male',
                          hint: Text('Select Gender'),
                          validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required(context)]),
                          items: ['Male', 'Female']
                              .map((gender) => DropdownMenuItem(
                                    value: gender,
                                    child: Text('$gender'),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
