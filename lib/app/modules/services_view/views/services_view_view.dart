import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/controllers/controller.dart';
import 'package:inforamclub/app/core/widgets/add_floating_button_widget.dart';
import 'package:inforamclub/app/core/widgets/service_tile.dart';
import 'package:inforamclub/app/modules/services_view/views/widgets/join_button_widget.dart';
import 'package:inforamclub/app/modules/services_view/views/widgets/slider_shimmer_widget.dart';
import 'package:inforamclub/app/modules/services_view/views/widgets/swiper_widget.dart';
import 'package:inforamclub/app/routes/app_pages.dart';
import '../controllers/services_view_controller.dart';
import 'widgets/calender_week_widget.dart';
import 'widgets/empty_services_widget.dart';

class ServicesViewView extends GetView<ServicesViewController> {
  @override
  Widget build(BuildContext context) {
    var coreController = Get.find<CoreController>();
    return Scaffold(
      floatingActionButton: GetBuilder<CoreController>(
        builder: (_) => Visibility(
          visible: Get.find<CoreController>().currentLoggedUser.isAdmin,
          child: AddFloatingButton(
            onPressed: () => Get.toNamed(Routes.SERVICE_FORM),
          ),
        ),
      ),
      body: Obx(() {
        if (coreController.isServiceTypesLoading.value)
          return Center(
            child: CircularProgressIndicator(),
          );
        else {
          Get.put(ServicesViewController());

          return ListView(
            padding: EdgeInsets.only(bottom: 30),
            children: [
              SizedBox.fromSize(
                size: Size.fromHeight(200),
                child: Obx(() => coreController.isSliderLoading.value
                    ? SliderShimmer()
                    : GetBuilder<CoreController>(builder: (_) {
                        return MySlider();
                      })),
              ),
              SizedBox(
                height: 140,
                child: MyCalenderWeek(),  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
              ),
              GetBuilder<ServicesViewController>(
                builder: (_) => controller.thisDayServices == null
                    ? Center(
                        child: Padding(
                        padding: const EdgeInsets.only(top: 80),
                        child: CircularProgressIndicator(),
                      ))
                    : GetBuilder<ServicesViewController>(builder: (_) {
                        if (controller.thisDayServices.isEmpty ||
                            controller.thisDayServices.every(
                                (element) => element.isEndedFromFiveMinutes))
                          return EmptyServices();
                        else
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (int i = 0;
                                  i < controller.thisDayServices.length;
                                  i++)
                                GetBuilder<ServicesViewController>(
                                  // id: '$i$j delete',
                                  builder: (_) => Visibility(
                                    visible: !controller.thisDayServices[i]
                                        .isEndedFromFiveMinutes,
                                    child: ServiceTile(
                                        index: i,
                                        serviceModel:
                                            controller.thisDayServices[i],
                                        // button: SizedBox(),
                                        button:
                                            GetBuilder<ServicesViewController>(
                                          // id: '$i$j',
                                          builder: (_) => JoinButton(
                                            width: 140,
                                            service:
                                                controller.thisDayServices[i],
                                          ),
                                        )),
                                  ),
                                ),
                            ],
                          );
                      }),
              ),
              SizedBox(
                height: 120,
              )
            ],
          );
        }
      }),
    );
  }
}
