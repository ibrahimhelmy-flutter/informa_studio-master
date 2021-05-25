import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inforamclub/app/core/app_localizatioan/localization.dart';

import 'InputFields.dart';

Widget get space => SizedBox(
      height: 20,
    );

int i = 0;

class RegisterForm extends StatelessWidget {
  final bool isEdit;

  const RegisterForm({Key key, this.isEdit=false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final tr = Localization.of(context).languageCode;

    return Column(
      children: [
        InputFieldArea(
          icon: Icons.person,
          hint: tr[0],
          validationMessages: {'minLength': tr[11]},
          textInputType: TextInputType.name,
          inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\d'))],
          formControlName: 'firstName',
        ),
        space,
        InputFieldArea(
          icon: Icons.person,
          hint: tr[1],
          validationMessages: {'minLength': tr[11]},
          inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\d'))],
          formControlName: 'lastName',
        ),
        if(!this.isEdit)...[
        space,
        InputFieldArea(
          icon: Icons.email,
          hint: tr[2],
          validationMessages: {'email': ''},
          formControlName: 'email',
        ),
        space,
        InputFieldArea(
          maxLength: 9,
          icon: Icons.insert_drive_file,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          textInputType: TextInputType.number,
          hint: tr[3],
          formControlName: 'identityCard',
        ),
        ],
        space,
        InputFieldArea(
          icon: Icons.lock,
          hint: tr[4],
          obscure: true,
          formControlName: 'password',
        ),
        space,
        InputFieldArea(
          icon: Icons.lock,
          hint: tr[5],
          obscure: true,
          formControlName: 'passwordConfirmation',
        ),
        space,
        InputFieldArea(
          icon: Icons.phone,
          hint: tr[6],
          formControlName: 'phone',
        ),
        space,
/*
        ReactiveDropdownField(
            validationMessages: (_) => {
                  'required': tr[10],
                },
            hint: Text(tr[7]),
            formControlName: 'gender',
            items: ['Male', 'Female']
                .map((e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    ))
                .toList()),
*/
        SizedBox(
          height: 120,
        )
      ],
    );
  }
}

