import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inforamclub/app/core/models/service_model.dart';
import 'package:inforamclub/app/core/models/service_type.dart';
import 'firestore_resource.dart';
import 'services_firestore_resource.dart';

class ServiceTypeFirestoreResource extends FirestoreResource<ServiceTypeModel> {
  ServiceTypeFirestoreResource() : super('SERVICE_TYPES', ServiceTypeModel());

  @override
  Future<void> delete(String id) async {
    await ServicesFirestoreResource().deleteServicesFromServiceId(id);
    super.delete(id);
  }
}
