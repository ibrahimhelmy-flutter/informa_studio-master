import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inforamclub/app/core/models/user_model.dart';
import 'package:inforamclub/app/core/services/user.dart';

import 'firestore_resource.dart';

class UserFirestoreResource extends FirestoreResource<UserModel> {
  UserFirestoreResource() : super('USERS', UserModel());

  Stream<UserModel> listenToCurrentLoggedUser() {
    return super.listenToDocument(UserService.id);
  }

  Future<bool> isValidEmail(String email) async {
    final result =
        await collectionReference.where('email', isEqualTo: email).get();
    return result.docs.isEmpty;
  }

  Future<void> updateToken(String token) async => await collectionReference
      .doc(UserService.id)
      .update({'notificationToken': token});

  Future<UserModel> login(String email, String password) async {
    final result = await collectionReference
        .where(
          'email',
          isEqualTo: email,
        )
        .where('password', isEqualTo: password)
        .get();

    if (result.size != 1) {
      throw Exception();
    }

    return UserModel().fromDocumentSnapshot(result.docs[0]);
  }
}
