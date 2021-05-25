import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/controllers/controller.dart';
import 'package:inforamclub/app/core/models/service_type.dart';
import 'package:inforamclub/app/core/services/user.dart';
import 'package:intl/intl.dart';
import 'firestore_data_model.dart';
import 'service_subscriber_model.dart';

class ServiceModel extends FirestoreModel {
  ServiceModel(
      {this.id,
      this.end,
      this.serviceType,
      this.serviceTypeId,
      this.gender,
      this.maxSubscribers,
      this.waitingRoomIds = const [],
      this.subscribersIds = const [],
      this.start});

  ServiceTypeModel serviceType;
  String serviceTypeId, id;
  String gender;
  int maxSubscribers;
  List<ServiceSubscriber> subscribersIds;
  List<ServiceSubscriber> waitingRoomIds;
  final DateTime end, start;

  ServiceModel copyWith({
    ServiceTypeModel serviceType,
    String serviceTypeId,
    String id,
    String gender,
    int maxSubscribers,
    List<ServiceSubscriber> subscribersIds,
    List<ServiceSubscriber> waitingRoomIds,
    DateTime end,
    DateTime start,
  }) {
    return new ServiceModel(
      serviceType: serviceType ?? this.serviceType,
      serviceTypeId: serviceTypeId ?? this.serviceTypeId,
      id: id ?? this.id,
      gender: gender ?? this.gender,
      maxSubscribers: maxSubscribers ?? this.maxSubscribers,
      subscribersIds: subscribersIds ?? this.subscribersIds,
      waitingRoomIds: waitingRoomIds ?? this.waitingRoomIds,
      end: end ?? this.end,
      start: start ?? this.start,
    );
  }

  String get durationToString {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitsHours =
        twoDigits(duration.inHours.remainder(Duration.hoursPerDay));

    String twoDigitMinutes =
        twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour));
    return "$twoDigitsHours:$twoDigitMinutes";
  }

  DateFormat get dateFormat => DateFormat('HH:mm');

  String get getStartTime => dateFormat.format(start);

  String get getEndTime => dateFormat.format(end);

  String get date => DateFormat('yyyy-MM-dd').format(start);

  bool get isEnded {
    return end.isBefore(DateTime.now());
  }

  bool get isStarted {
    return start.isBefore(DateTime.now());
  }

  bool get isEndedFromFiveMinutes =>
      end.add(Duration(minutes: 5)).isBefore(DateTime.now());

  Duration get duration {
    return end.difference(start);
  }

  bool get isFull => maxSubscribers == subscribersCount;

  bool get isSubscribed =>
      subscribersIds.indexWhere((element) => element.id == UserService.id) !=
      -1;

  bool get isJoinedToWaitingRoom =>
      waitingRoomIds.indexWhere((element) => element.id == UserService.id) !=
      -1;

  void unSubscribe() =>
      subscribersIds.removeWhere((element) => element.id == UserService.id);

  void joinWaitingRoom() => waitingRoomIds
      .add(ServiceSubscriber(id: UserService.id, at: DateTime.now()));

  void leaveWaitingRoom() =>
      waitingRoomIds.removeWhere((element) => element.id == UserService.id);

  int get subscribersCount => subscribersIds.length;

  @override
  Map<String, dynamic> get toMap => {
        'isEnded': isEnded,
        'start': Timestamp.fromDate(this.start),
        'end': Timestamp.fromDate(this.end),
        'serviceTypeId': this.serviceTypeId,
        'gender': this.gender,
        'maxSubscribers': this.maxSubscribers,
        'subscribersIds': this.subscribersIds,
      };

  @override
  ServiceModel fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data();
    return new ServiceModel(
      id: documentSnapshot.id,
      serviceType: Get.find<CoreController>()
          .serviceTypes
          .where((element) => element.id == data['serviceTypeId'])
          .first,
      end: (data['end'] as Timestamp).toDate(),
      serviceTypeId: data['serviceTypeId'] as String,
      waitingRoomIds: [],
      gender: data['gender'] as String,
      maxSubscribers: data['maxSubscribers'] as int,
      subscribersIds: (data['subscribersIds'] as List)
          .map((e) => ServiceSubscriber.fromMap(e))
          .toList(),
      start: (data['start'] as Timestamp).toDate(),
    );
  }

  @override
  ServiceModel fromMap(
    Map<String, dynamic> map,
  ) =>
      ServiceModel(
        waitingRoomIds: ([]).cast<ServiceSubscriber>(),
        serviceTypeId: map['serviceTypeId'] as String,
        gender: map['gender'] as String,
        end: map['end'] as DateTime,
        maxSubscribers: map['maxSubscribers'] as int,
        subscribersIds: map['subscribersIds'] == null
            ? []
            : (map['subscribersIds'] as List)
                .map((e) => ServiceSubscriber.fromMap(e))
                .toList(),
        start: map['date'] as DateTime,
      );
}
