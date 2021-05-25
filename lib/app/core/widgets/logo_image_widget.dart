import 'package:flutter/material.dart';
class LogoImage extends StatelessWidget {
  final double height, width;

  const LogoImage({Key key, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      width: width ?? 500,
      fit: BoxFit.cover,
      height: height ?? 200,
    );
  }
}
