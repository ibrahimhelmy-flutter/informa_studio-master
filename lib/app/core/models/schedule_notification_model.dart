import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inforamclub/app/core/models/service_model.dart';
import 'package:inforamclub/app/core/services/user.dart';

import 'firestore_data_model.dart';

class ScheduleNotificationModel extends FirestoreModel {
  ScheduleNotificationModel(
      {this.whenToNotify, this.id, this.serviceId, this.body}) {
    isEnabled = id != null;
  }

  static String uid = UserService.id;

  DateTime whenToNotify;
  String serviceId, body;
  String id;
  bool isEnabled;

  void setWhenToNotify(Duration duration, DateTime start) {
    whenToNotify = start.subtract(duration);
  }

  void toggleEnabled() => isEnabled = !isEnabled;

  Duration alertBefore(DateTime start) =>
      start.difference(whenToNotify);

  ScheduleNotificationModel copyWith({
    DateTime whenToNotify,
    String serviceId,
    String body,
    String id,
  }) {
    return new ScheduleNotificationModel(
      whenToNotify: whenToNotify ?? this.whenToNotify,
      serviceId: serviceId ?? this.serviceId,
      body: body ?? this.body,
      id: id ?? this.id,
    );
  }

  @override
  ScheduleNotificationModel fromDocumentSnapshot(
      DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data();
    return ScheduleNotificationModel(
      body: data['body'],
      whenToNotify: (data['whenToNotify'] as Timestamp).toDate(),
      id: documentSnapshot.id,
      serviceId: data['serviceId'] as String,
    );
  }

  @override
  ScheduleNotificationModel fromMap(Map<String, dynamic> data) {}

  @override
  // TODO: implement toMap
  Map<String, dynamic> get toMap => {
        'whenToNotify': this.whenToNotify,
        'uid': uid,
        'serviceId': this.serviceId,
        'body': this.body
      };
}
