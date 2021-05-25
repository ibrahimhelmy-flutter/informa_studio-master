import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/modules/service_details/controllers/service_details_controller.dart';

import 'service_details_grid_widget.dart';

class ServiceDetailsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceDetailsController>(builder: (controller) {
      if (controller.service != null) {
        final serviceModel = controller.service;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomScrollView(
            slivers: [
              SliverPadding(padding: EdgeInsets.only(top: 20)),
              SliverToBoxAdapter(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: serviceModel.serviceType.image,
                    height: 200,
                  ),
                ),
              ),
              /*   SliverPadding(
                                    padding: const EdgeInsets.symmetric(vertical: 20),
                                    sliver: SliverToBoxAdapter(
                                      child: Row(
                                        children: [
                                          BackButton(),
                                          Text(
                                            'Exercise details',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),*/
              SliverPadding(
                padding: const EdgeInsets.only(top: 20, bottom: 12),
                sliver: SliverToBoxAdapter(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      serviceModel.serviceType.name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    Text(serviceModel.durationToString)
                  ],
                )),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
                ),
              ),
              ServiceDetailsGrid(
                serviceModel: serviceModel,
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 200,
                ),
              ),
            ],
          ),
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    });
  }
}
