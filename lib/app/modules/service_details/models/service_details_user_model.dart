import 'package:flutter/foundation.dart';
import 'package:inforamclub/app/core/models/user_model.dart';

class ServiceDetailsUserModel {
  final DateTime at;

  final UserModel userModel;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const ServiceDetailsUserModel({
    @required this.at,
    @required this.userModel,
  });

  ServiceDetailsUserModel copyWith({
    DateTime at,
    UserModel userModel,
  }) {
    if ((at == null || identical(at, this.at)) &&
        (userModel == null || identical(userModel, this.userModel))) {
      return this;
    }

    return new ServiceDetailsUserModel(
      at: at ?? this.at,
      userModel: userModel ?? this.userModel,
    );
  }

  @override
  String toString() {
    return 'ServiceDetailsUserModel{at: $at, userModel: $userModel}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServiceDetailsUserModel &&
          runtimeType == other.runtimeType &&
          at == other.at &&
          userModel == other.userModel);

  @override
  int get hashCode => at.hashCode ^ userModel.hashCode;

  factory ServiceDetailsUserModel.fromMap(Map<String, dynamic> map) {
    return new ServiceDetailsUserModel(
      at: map['at'] as DateTime,
      userModel: map['userModel'] as UserModel,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'at': this.at,
      'userModel': this.userModel,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
