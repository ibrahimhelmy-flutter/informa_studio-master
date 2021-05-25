import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_data_model.dart';

class ServiceTypeModel extends FirestoreModel {
  final String name, image, id;
  bool isSelected = false;

  ServiceTypeModel({this.id, this.name, this.image});

  Map<String, dynamic> get toMap => {
        'name': this.name,
        'image': this.image,
      };

  @override
  ServiceTypeModel fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data();
    final id = documentSnapshot.id;
    return ServiceTypeModel(
      name: data['name'] as String,
      image: data['image'] as String,
      id: id,
    );
  }

  @override
  ServiceTypeModel fromMap(Map<String, dynamic> map) => ServiceTypeModel(
        name: map['name'] as String,
        image: map['image'] as String,
        id: map['id'] as String,
      );

}
