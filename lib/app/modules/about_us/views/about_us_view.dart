import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inforamclub/app/core/app_localizatioan/localization.dart';
import 'package:inforamclub/app/core/controllers/controller.dart';
import 'package:inforamclub/app/core/services/user.dart';
import 'package:inforamclub/app/modules/root/controllers/root_controller.dart';
import 'package:inforamclub/app/routes/app_pages.dart';
import 'package:inforamclub/app/core/helpers/extensions.dart';
import '../controllers/about_us_controller.dart';
import 'package:inforamclub/app/core/widgets/sites_icons.dart';

class AboutUsView extends GetView<AboutUsController> {
  @override
  Widget build(BuildContext context) {
    Get.put(AboutUsController());
    final tr = Localization.of(context).languageCode;
    return Scaffold(
        floatingActionButton: Visibility(
          visible: (Get.find<CoreController>().currentLoggedUser.isAdmin),
          child: FloatingActionButton(
            onPressed: () => Get.toNamed(Routes.ABOUT),
            child: Icon(Icons.edit),
          ),
        ),
        body: GetBuilder<CoreController>(
          builder: (_) {
            final data = Get.find<CoreController>().aboutUs;

            return ListView(
              padding: EdgeInsets.only(bottom: 120),
              children: [
                SizedBox(
                  height: 220,
                  child: GoogleMap(
                    markers: {
                      Marker(
                          markerId: MarkerId('1'),
                          position: controller.position.toLatLng)
                    },
                    initialCameraPosition: CameraPosition(
                        zoom: 10, target: controller.position.toLatLng),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text('عرض فى شاشة كاملة'),
                // ),
                SizedBox(
                  height: 20,
                ),

                Center(
                    child: SitesIcon(
                  size: Size(50, 50),
                  mainAxisAlignment: MainAxisAlignment.center,
                )),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Obx(
                    () => Text(
                      controller.isTextExpand.value
                          ? data.text
                          : data.subStringText,
                      // textAlign: TextAlign.justify,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: GestureDetector(
                    onTap: controller.toggleExpand,
                    child: Obx(
                      () => Text(
                        controller.isTextExpand.value ? tr[81] : tr[80],
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        ));
  }
}
