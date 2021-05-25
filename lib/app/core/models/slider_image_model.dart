import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inforamclub/app/core/models/firestore_data_model.dart';

class SliderImageModel extends FirestoreModel {
  final String id, url;

  SliderImageModel({this.id, this.url});

  factory SliderImageModel.fromFireStore(
      QueryDocumentSnapshot queryDocumentSnapshot) {
    return new SliderImageModel(
      id: queryDocumentSnapshot.id,
      url: queryDocumentSnapshot.data()['url'] as String,
    );
  }

  Map<String, dynamic> get toMap => {
        'url': this.url,
      };

  @override
  FirestoreModel fromDocumentSnapshot(DocumentSnapshot documentSnapshot) =>
      SliderImageModel(
        id: documentSnapshot.id,
        url: documentSnapshot.data()['url'] as String,
      );

  @override
  FirestoreModel fromMap(Map<String, dynamic> map) {}
}
