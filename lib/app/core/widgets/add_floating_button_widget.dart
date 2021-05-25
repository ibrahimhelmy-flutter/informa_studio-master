import 'package:flutter/material.dart';

class AddFloatingButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddFloatingButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      onPressed: onPressed, child: Icon(Icons.add),);
  }
}
