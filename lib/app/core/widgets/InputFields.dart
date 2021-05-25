import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inforamclub/app/core/app_localizatioan/localization.dart';
import 'package:reactive_forms/reactive_forms.dart';

class InputFieldArea extends StatelessWidget {
  final String hint, formControlName;
  final bool obscure;
  final IconData icon;

  final int maxLength;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType textInputType;
  final Map<String, String> validationMessages;

  InputFieldArea(
      {this.hint,
      this.obscure = false,
      this.icon,
      this.formControlName,
      this.maxLength,
      this.textInputType,
      this.inputFormatters,
      this.validationMessages =const{}});

  @override
  Widget build(BuildContext context) {
    final tr = Localization.of(context).languageCode;

    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
              color: Color(0xffEAEFFB),
            )),
            child: (new ReactiveTextField(
              validationMessages: (control) {
                return {
                  'required': tr[10],
                  ...validationMessages
                };
              },
              keyboardType: textInputType,
              maxLength: maxLength,
              inputFormatters: inputFormatters,
              formControlName: this.formControlName,
              obscureText: obscure,
              style: const TextStyle(
                  ),
              decoration: new InputDecoration(
                prefixIcon: Icon(
                  icon,
                ),
                disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                focusedErrorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                enabledBorder: InputBorder.none,

                border: InputBorder.none,
                hintText: hint,
                hintStyle: const TextStyle(fontSize: 15.0),
              ),
            )),
          ),
        ),
      ],
    );
  }
}

