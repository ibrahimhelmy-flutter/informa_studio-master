import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  final String title, trailing;
  final Icon icon;

  const InfoTile({Key key, this.title, this.trailing, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
        title: Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        trailing: Text(trailing));
    ;
  }
}
