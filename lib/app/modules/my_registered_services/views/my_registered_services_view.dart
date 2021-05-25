import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:inforamclub/app/core/models/service_model.dart';
import 'package:inforamclub/app/core/services/user.dart';
import 'package:inforamclub/app/core/widgets/service_tile.dart';
import 'package:inforamclub/app/modules/services_view/views/widgets/join_button_widget.dart';

import '../controllers/my_registered_services_controller.dart';
import 'package:inforamclub/app/core/app_localizatioan/localization.dart';

class MyRegisteredServicesView extends GetView<MyRegisteredServicesController> {
  @override
  Widget build(BuildContext context) {
    Get.put(MyRegisteredServicesController());

    final tr = Localization.of(context).languageCode;

    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
          stream: controller.registeredService,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final serviceModels = snapshot.data.docs
                  .map((e) => ServiceModel().fromDocumentSnapshot(e))
                  .where((element) {
                final subscribersIds = element.subscribersIds;

                return subscribersIds.indexWhere(
                        (element) => element.id == UserService.id) !=
                    -1;
              }).toList();

              return serviceModels.isEmpty
                  ? Column(
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        Center(
                          child: Image.asset(
                            'assets/images/empty.gif',
                            height: 200,
                            width: 200,
                          ),
                        ),
                        Text(
                          tr[28],
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    )
                  : ListView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      itemCount: serviceModels.length,
                      itemBuilder: (context, index) {
                        return ServiceTile(
                          index: index,
                          isDelete: false,
                          button: JoinButton(
                            service: serviceModels[index],
                          ),
                          serviceModel: serviceModels[index],
                        );
                      },
                    );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
