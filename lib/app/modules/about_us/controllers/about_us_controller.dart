import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inforamclub/app/core/controllers/controller.dart';

class AboutUsController extends GetxController {
  GeoPoint position ;
  var isTextExpand = false.obs;

  void toggleExpand() => isTextExpand.toggle();
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    position = Get.find<CoreController>().aboutUs.waze;
  }

}