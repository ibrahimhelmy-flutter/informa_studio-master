import 'package:flutter/material.dart';

class ProfileInfoTile extends StatelessWidget {

  final Icon icon;
final String title,subTitle;

  const ProfileInfoTile({Key key, this.icon, this.title, this.subTitle}) : super(key: key);
  @override
  Widget build(BuildContext context) {


    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        icon,
        SizedBox(width: 20.0,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
              style: TextStyle(
                fontSize: 15.0,
              ),),
            Text(subTitle,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey[400],
              ),)
          ],
        )

      ],
    );


  }
}
