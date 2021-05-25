import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/firestore_resources/identity_cards_firestore_resource.dart';
import 'package:inforamclub/app/core/models/identity_card.dart';
import 'package:inforamclub/app/core/widgets/pop_up.dart';

class IdentityCardsController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();
  List<IdentityCardModel> ids;
  Future future;
  IdentityCardFirestoreResource identityCardFirestoreResource =
      IdentityCardFirestoreResource();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    future = get();
  }

  Future<void> add() async {
    final formState = formKey.currentState;
    if (formState.saveAndValidate()) {
      final identityCard =
          IdentityCardModel().fromMap(formKey.currentState.value);

      try {
        final result = await identityCardFirestoreResource.add(identityCard);
        ids.add(IdentityCardModel(
            id: result.id, cardNumber: identityCard.cardNumber));
        formState.reset();
        update();
      } catch (e) {
        PopUp.showSnackBar('card number must be unique ');
      }
    }
  }

  Future<void> get() async {
    ids = await identityCardFirestoreResource.getAll;
  }

  Future<void> delete(String id, int index) async {
    PopUp.showConfirmAlert(() {
      identityCardFirestoreResource.delete(id);
      ids.removeAt(index);
      update();

    });

  }
}
