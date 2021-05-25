import 'package:flutter/material.dart';

class DetailsCard extends StatelessWidget {
  final Color color;
  final Widget icon;
  final String title,text;

  const DetailsCard({Key key, this.color, this.icon, this.text, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.all(Radius.circular(10))),
      height: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon,
            SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
            Center(
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
