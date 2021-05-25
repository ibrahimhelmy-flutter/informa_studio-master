import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/controllers/controller.dart';
import 'package:inforamclub/app/core/widgets/add_floating_button_widget.dart';
import 'package:inforamclub/app/core/widgets/delete_floating_button_widget.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../controllers/service_type_form_controller.dart';
import 'widgets/form_builder_file_picker-master/lib/form_builder_file_picker.dart';

class ServiceTypeFormView extends GetView<ServiceTypeFormController> {
  @override
  Widget build(BuildContext context) {
    Get.put(ServiceTypeFormController());
    final coreController = Get.find<CoreController>();

    return Scaffold(
      floatingActionButton: AddFloatingButton(

        onPressed: controller.confirm,
      ),
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: controller.isLoading.value,
          child: FormBuilder(
            key: controller.formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  FormBuilderFilePicker(
                    name: "image",

                    decoration: InputDecoration(labelText: "Attachments"),
                    maxFiles: 1,
                    valueTransformer: (value) => value[0].path,
                    // allowedExtensions: ['.gif'],
                    // type: FileType.custom,
                    allowMultiple: false,
                    previewImages: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                    selector: Row(
                      children: <Widget>[
                        Icon(Icons.file_upload),
                        Text('Upload'),
                      ],
                    ),
                    onFileLoading: (val) {
                    },
                  ),
                  FormBuilderTextField(
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                    decoration: InputDecoration(labelText: 'name'),
                    name: 'name',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(child: GetBuilder<CoreController>(builder: (_) {
                    if (coreController.serviceTypes==null)
                      return Center(child: CircularProgressIndicator());

                    final serviceTypes = coreController.serviceTypes;

                    return GetBuilder<CoreController>(builder: (_) {
                      return GridView.builder(
                        padding: EdgeInsets.only(bottom: 50),
                        itemCount: serviceTypes.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 8,
                            childAspectRatio: (500) / 800),
                        itemBuilder: (BuildContext context, int index) {
                          final serviceType = serviceTypes[index];

                          return SizedBox(
                              child: Stack(
                            children: [
                              Card(
                                margin: EdgeInsets.all(0),
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: CachedNetworkImage(
                                      imageUrl: serviceType.image,
                                      width: Get.width,
                                      fit: BoxFit.cover,
                                    )),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          serviceType.name,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: DeleteFloatingButton(
                                  onPressed: () => coreController
                                      .deleteServiceType(serviceType.id, index),
                                ),
                              )
                            ],
                          ));
                        },
                      );
                    });
                  })),
                  SizedBox(
                    height: 40,
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
