import 'package:flutter/material.dart';

class DeleteFloatingButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DeleteFloatingButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
padding: EdgeInsets.only(right: 20,bottom: 10),
        icon: Icon(
          Icons.cancel,
          color: Colors.red,
        ),
        onPressed: onPressed);
  }
}
