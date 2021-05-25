import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inforamclub/app/core/models/firestore_data_model.dart';

class IdentityCardModel extends FirestoreModel {
  final String id, cardNumber;

  IdentityCardModel({this.id, this.cardNumber});

  Map<String, dynamic> get toMap => {
        'id': this.id,
        'cardNumber': this.cardNumber,
      };

  @override
  FirestoreModel fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data();
    final id = documentSnapshot.id;
    return new IdentityCardModel(
      id: id,
      cardNumber: data['cardNumber'] as String,
    );
  }

  @override
  IdentityCardModel fromMap(Map<String, dynamic> map) {
    return IdentityCardModel(
      id: id,
      cardNumber: map['cardNumber'] as String,
    );
  }
}
