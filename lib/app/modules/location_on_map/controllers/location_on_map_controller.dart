import 'dart:async';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inforamclub/app/core/controllers/controller.dart';

class LocationOnMapController extends GetxController {
  Completer<GoogleMapController> googleMapController = Completer();
  Rx<MapType> mapType = MapType.normal.obs;
  LatLng location;

  @override
  void onInit() {
    super.onInit();
    final waze = Get.find<CoreController>().aboutUs.waze;
    location = LatLng(waze.latitude, waze.longitude);
  }

  double get middleX {
    double screenWidth = Get.width * Get.pixelRatio;

    return screenWidth / 2;
  }

  double get middleY {
    double screenHeight = Get.height * Get.pixelRatio;
    return screenHeight / 2;
  }

  void toggleMapType() {
    if (mapType.value == MapType.normal) {
      mapType.value = MapType.hybrid;
    } else {
      mapType.value = MapType.normal;
    }
  }

  Future<void> submit() async {
    final controller = await googleMapController.future;
    final latLng = await controller
        .getLatLng(ScreenCoordinate(x: middleX.round(), y: middleY.round()));
    Get.back(result:  latLng);
  }


}
