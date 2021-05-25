import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreModel {
  FirestoreModel fromMap(Map<String, dynamic> map);

  FirestoreModel fromDocumentSnapshot(DocumentSnapshot documentSnapshot);

  Map<String, dynamic> get toMap;
}
