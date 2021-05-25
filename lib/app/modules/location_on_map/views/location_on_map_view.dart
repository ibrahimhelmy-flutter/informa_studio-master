import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/location_on_map_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationOnMapView extends GetView<LocationOnMapController> {
  @override
  Widget build(BuildContext context) {
    final position = controller.location;


    return Scaffold(
        body: Stack(children: <Widget>[
      GoogleMap(
          mapType: controller.mapType.value,
          onMapCreated: (GoogleMapController googleMapController) {
            controller.googleMapController.complete(googleMapController);
          },
          initialCameraPosition: CameraPosition(
              zoom: 15, target: LatLng(position.latitude, position.longitude))),
      Align(
        alignment: Alignment.centerLeft,
        child: Column(
          verticalDirection: VerticalDirection.up,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 40,
                height: 40,
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.map,
                    color: controller.mapType.value == MapType.normal
                        ? Colors.grey
                        : Colors.blue,
                  ),
                  onPressed: controller.toggleMapType,
                ),
              ),
            ),
          ],
        ),
      ),
      Center(
          child: Icon(
        Icons.location_on,
        color: Colors.red,
        size: 40,
      )),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 200,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10))),
          child: Column(
            textDirection: TextDirection.rtl,
            children: <Widget>[

              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: 300,
                    height: 50,
                    child: FlatButton(
                      color: Colors.green,
                      onPressed: controller.submit,
                      child: Text(
                        'هنا',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    ]));
  }
}
