import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_data_model.dart';

class AboutUsModel extends FirestoreModel {
  final String instagram, whatsApp, text;
  GeoPoint waze;

  String get subStringText => String.fromCharCodes(text.runes,0, 200) + '....';

  AboutUsModel({this.waze, this.instagram, this.whatsApp, this.text});


  String get wazeToString => '${waze.latitude}-${waze.longitude}';

  @override
  Map<String, dynamic> get toMap => {
        'instagram': this.instagram,
        'whatsApp': this.whatsApp,
        'text': this.text,
        'waze': this.waze,
      };

  @override
  AboutUsModel fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data();
    return new AboutUsModel(
      instagram: data['instagram'] as String,
      whatsApp: data['whatsApp'] as String,
      text: data['text'] as String,
      waze: data['waze'] as GeoPoint,
    );
  }

  @override
  AboutUsModel fromMap(Map<String, dynamic> map) => AboutUsModel(
        instagram: map['instagram'] as String,
        whatsApp: map['whatsApp'] as String,
        text: map['text'] as String,
        waze: map['waze'] as GeoPoint,
      );
}
