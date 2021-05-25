import 'package:flutter/material.dart';

class EmptyServices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
            ),
            Icon(Icons.search),
            Text(
              'Empty Result',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ));
  }
}
