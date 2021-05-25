import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inforamclub/app/core/models/identity_card.dart';

import 'firestore_resource.dart';

class IdentityCardFirestoreResource
    extends FirestoreResource<IdentityCardModel> {
  IdentityCardFirestoreResource()
      : super('IDENTITY_CARDS', IdentityCardModel());

  Future<bool> isValid(String id) async {
    final result =
        await collectionReference.where('cardNumber', isEqualTo: id).get();

    return result.docs.isNotEmpty;
  }

  @override
  Future<DocumentReference> add(IdentityCardModel model) async {
    final x = await collectionReference
        .where('cardNumber', isEqualTo: model.cardNumber)
        .get();
    if (x.docs.isNotEmpty) {
      throw Exception();
    } else {
      return super.add(model);
    }
  }
}
