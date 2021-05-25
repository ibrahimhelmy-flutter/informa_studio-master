import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FireStorageService {

  static Reference firebaseReference(String ref, String imagePath) {
    return FirebaseStorage.instance
        .ref('$ref/${Uuid().v4()}${path.extension(imagePath)}');
  }

  static Future<String> uploadFile(String ref, String imagePath) async {
    final reference = firebaseReference(ref, imagePath);
    final putFileResult = await reference.putFile(File(imagePath));
    return putFileResult.ref.getDownloadURL();
  }

  static Future<String> uploadUint8List(String ref,String imagePath, Uint8List image) async {
    final reference = firebaseReference(ref, imagePath);
    final putFileResult = await reference.putData(image);
    return putFileResult.ref.getDownloadURL();
  }

}
