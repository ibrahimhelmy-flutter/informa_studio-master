import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final String title;

  final double min, max, value;
  final String label;

  final ValueChanged<double> onChanged;

  const CustomSlider(
      {Key key,
      this.title,
      this.min,
      this.max,
      this.value,
      this.onChanged,
      this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(min.toString()), Text(max.toString())],
        ),
        Stack(
          children: [
            // Icon(FontAwesomeIcons.)
            SliderTheme(
              data: SliderThemeData(
                  thumbColor: Colors.green,
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 10,
                  )),
              child: Slider(
                divisions: max.toInt(),
                value: value,
                min: min,
                max: max,
                label: label,
                activeColor: Colors.black,
                inactiveColor: Color(0xffA1A1A1),
                onChanged: this.onChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class RoundSliderThumbShape extends SliderComponentShape {
  const RoundSliderThumbShape({
    this.enabledThumbRadius = 10.0,
    this.disabledThumbRadius,
  });

  final double enabledThumbRadius;

  final double disabledThumbRadius;

  double get _disabledThumbRadius => disabledThumbRadius ?? enabledThumbRadius;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(
        isEnabled == true ? enabledThumbRadius : _disabledThumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {Animation<double> activationAnimation,
      Animation<double> enableAnimation,
      bool isDiscrete,
      TextPainter labelPainter,
      RenderBox parentBox,
      SliderThemeData sliderTheme,
      TextDirection textDirection,
      double value,
      double textScaleFactor,
      Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;

    // canvas.drawCircle(center, 10, Paint()..color = Colors.green..stro,
    Paint paintCircle = Paint()..color = Colors.white;
    Paint paintBorder = Paint()
      ..color = Colors.black
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, 15, paintCircle);
    canvas.drawCircle(center, 15, paintBorder);
  }
}
