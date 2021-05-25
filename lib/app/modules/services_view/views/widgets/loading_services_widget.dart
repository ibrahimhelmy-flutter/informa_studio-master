import 'package:flutter/material.dart';

class LoadingServices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            CircularProgressIndicator(),
            Text('loading'),
          ],
        ));
  }
}
