import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ServiceSubscriber {
  final String id;
  final DateTime at;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const ServiceSubscriber({
    @required this.id,
    @required this.at,
  });

  ServiceSubscriber copyWith({
    String id,
    DateTime at,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (at == null || identical(at, this.at))) {
      return this;
    }

    return new ServiceSubscriber(
      id: id ?? this.id,
      at: at ?? this.at,
    );
  }

  @override
  String toString() {
    return 'ServiceSubscriber{id: $id, at: $at}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServiceSubscriber &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          at == other.at);

  @override
  int get hashCode => id.hashCode ^ at.hashCode;

  factory ServiceSubscriber.fromMap(Map<String, dynamic> map) {
    return new ServiceSubscriber(
      id: map['id'] as String,
      at: (map['at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'at': Timestamp.now(),
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
