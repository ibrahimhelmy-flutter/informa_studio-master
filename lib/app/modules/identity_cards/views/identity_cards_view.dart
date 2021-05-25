import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';

import '../controllers/identity_cards_controller.dart';

class IdentityCardsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    final controller = Get.put(IdentityCardsController());
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: controller.add,
          child: Icon(Icons.add),
        ),
        body: Column(
          children: [
            FlatButton(
                onPressed: () {
                  controller.formKey.currentState
                      .patchValue({'cardNumber': '123456789'});
                },
                child: Text('fill')),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: FormBuilder(
                key: controller.formKey,
                child: FormBuilderTextField(
                  maxLength: 9,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.minLength(context, 9, errorText: '9'),
                  ]),
                  name: 'cardNumber',
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: controller.future,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return GetBuilder<IdentityCardsController>(
                        builder: (_) => ListView.builder(
                            itemCount: controller.ids.length,
                            itemBuilder: (context, index) {
                              final identityCard = controller.ids[index];

                              return ListTile(
                                trailing: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: FloatingActionButton(
                                    child: Icon(Icons.remove),
                                    backgroundColor: Colors.red,
                                    onPressed: () =>
                                        controller.delete(identityCard.id, index),
                                  ),
                                ),
                                title: Text(identityCard.cardNumber),
                              );
                            }),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
            ),
          ],
        ));
  }
}
