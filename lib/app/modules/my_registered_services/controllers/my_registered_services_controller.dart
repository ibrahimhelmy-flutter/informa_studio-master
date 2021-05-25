import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/models/service_model.dart';
import 'package:inforamclub/app/core/services/user.dart';

class MyRegisteredServicesController extends GetxController {

  List<ServiceModel> services;


  Stream<QuerySnapshot> get registeredService  {
    return FirebaseFirestore.instance
        .collection('SERVICES')
        .where('gender', isEqualTo: UserService.gender)
        .where('start', isGreaterThanOrEqualTo: DateTime.now())
        .orderBy('start')
        .snapshots();
  }


}
