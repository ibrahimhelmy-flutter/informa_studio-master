import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/controllers/controller.dart';
import 'package:inforamclub/app/core/models/service_model.dart';
import 'package:inforamclub/app/core/services/user.dart';
import 'package:inforamclub/app/modules/root/controllers/root_controller.dart';
import 'package:inforamclub/app/modules/services_view/controllers/services_view_controller.dart';
import 'package:inforamclub/app/routes/app_pages.dart';

class ServiceTile extends GetView<ServicesViewController> {
  final Widget button;
  final int index;
  final bool isDelete;
  final ServiceModel serviceModel;
  final String id;

  const ServiceTile(
      {Key key,
      this.id,
      this.isDelete = true,
      this.serviceModel,
      this.button,
      this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        Paths.SERVICE_DETAILS,
        arguments: serviceModel.id, /*'snapshot':*/
      ),
      child: ListTileTheme(
        tileColor: Colors.white,
        child: Stack(
          children: [
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //   width: 20,
                        // ),
                        Hero(
                          tag: 'image${serviceModel.id}',
                          child: CachedNetworkImage(
                            imageUrl:
                                '${serviceModel.serviceType?.image ?? ''}',
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                '${serviceModel.serviceType?.name ?? ''}',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.clock,
                                      color: Colors.orange,
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '${serviceModel.getStartTime} - ${serviceModel.getEndTime}',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(right: 10, top: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      if (Get.find<CoreController>()
                                              .currentLoggedUser
                                              .isAdmin &&
                                          this.isDelete)
                                        SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: FloatingActionButton(
                                            backgroundColor: Colors.red,
                                            onPressed: () => controller.delete(
                                                serviceModel.id, index),
                                            child: Icon(Icons.delete),
                                          ),
                                        ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      button,
                                    ],
                                  ),
                                ),
                              ),
                              // Text(serviceModel.serviceStatusToString)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            GetBuilder<ServicesViewController>(
              builder: (_) => Align(
                alignment: Get.locale.languageCode == 'en'
                    ? Alignment.topRight
                    : Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      '${serviceModel.subscribersCount}/${serviceModel.maxSubscribers}'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
