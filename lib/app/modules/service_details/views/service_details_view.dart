import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/app_localizatioan/localization.dart';
import 'package:inforamclub/app/core/firestore_resources/services_firestore_resource.dart';
import 'package:inforamclub/app/core/firestore_resources/users_firestore_resource.dart';
import 'package:inforamclub/app/core/models/service_model.dart';
import 'package:inforamclub/app/core/services/user.dart';
import '../controllers/service_details_controller.dart';
import 'widgets/service_details_grid_widget.dart';
import 'widgets/service_details_tab.dart';
import 'widgets/service_details_users_tab.dart';
import 'widgets/service_detials_app_bar_widget.dart';

class ServiceDetailsView extends StatelessWidget {
  final appBarHeight = 120.0;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ServiceDetailsController>();

    return GetBuilder<ServiceDetailsController>(
      builder: (_) => controller.service == null
          ? Scaffold(
              appBar: AppBar(),
              body: Center(child: CircularProgressIndicator()))
          : UserService.isIamAdmin
              ? DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    appBar: PreferredSize(
                        preferredSize: Size.fromHeight(appBarHeight),
                        child: ServiceDetailsAppBar()),
                    body: Column(
                      children: [
                        Expanded(
                          child: TabBarView(
                            children: [
                              ServiceDetailsTab(),
                              ServiceDetailsUsers(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Scaffold(
                  appBar: PreferredSize(
                      preferredSize: Size.fromHeight(kToolbarHeight),
                      child: ServiceDetailsAppBar()),
                  body: ServiceDetailsTab(),
                ),
    );
  }
}
/*
                              SliverToBoxAdapter(
                                child: FutureBuilder<ScheduleNotificationModel>(
                                    future: controller.future,
                                    builder: (BuildContext context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        final data = snapshot.data;
                                        print(data);
                                        return GetBuilder<ServiceDetailsController>(
                                          builder: (_) => Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SwitchListTile.adaptive(
                                                  title: Text('Hello'),
                                                  value:
                                                      controller.notificationModel !=
                                                          null,
                                                  onChanged: (x) {
                                                    controller.onToggleNotification();
                                                  }),
                                              Visibility(
                                                visible:
                                                    controller.notificationModel !=
                                                        null,
                                                child: DurationPicker(
                                                    onChange:
                                                        controller.onChangeDuration,
                                                    duration: controller.duration),
                                              ),
                                              TextFormField(
                                                initialValue: 'hello',
                                              ),
                                              FlatButton(
                                                onPressed: () {
                                                  controller
                                                      .saveScheduleNotification();
                                                },
                                                child: Text('save'),
                                              )
                                            ],
                                          ),
                                        );
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    }),
                              ),
                                                  SliverAppBar(
                      pinned: true,
                      leading: Container(),
                      expandedHeight: 250,
                      bottom: TabBar(tabs: [
                        Tab(
                          text: 'Details',
                        ),
                        Tab(
                          text: 'Users',
                        )
                      ]),
                      flexibleSpace: FlexibleSpaceBar(
                        background: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: serviceModel.serviceType.image,
                              height: 200,
                            ),
                          ),
                        ),
                      ),
                    )


*/
