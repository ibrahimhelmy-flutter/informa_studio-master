import 'package:inforamclub/app/core/models/service_model.dart';

class ServicesWithLoadingModel {
  bool isLoading;

  List<ServiceModel> services;

  ServicesWithLoadingModel({this.isLoading, this.services});
}
