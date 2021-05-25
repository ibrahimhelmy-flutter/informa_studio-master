import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class Clock extends StatefulWidget {
  final DateTime dateTime ;
  Clock({Key key, this.dateTime}) : super(key: key);

  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  Timer _timer;
  DateTime dateTime;

  @override
  void initState() {
    super.initState();

    dateTime = widget.dateTime ;
    _timer = Timer.periodic(const Duration(seconds: 1), setTime);
  }

  void setTime(Timer timer) {
    if(dateTime.second==0){
      _timer.cancel();
      return;
    }
    setState(() {
      dateTime = widget.dateTime.subtract(Duration(seconds: 1));
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return ClockWidget(
      dateTime: dateTime,
    );
  }
}




class ClockWidget extends StatelessWidget {
  final DateTime dateTime;

  const ClockWidget({Key key, this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var seconds = dateTime.second.toDouble();
    var minutes = dateTime.minute.toDouble();
    var hours = dateTime.hour.toDouble();
    return SleekCircularSlider(
      appearance: appearance01,
      min: 0,
      max: 59,
      initialValue: seconds,
      innerWidget: (double value) {
        return Align(
          alignment: Alignment.center,
          child: SleekCircularSlider(
            appearance: appearance02,
            min: 0,
            max: 59,
            initialValue: minutes,
            innerWidget: (double value) {
              return Align(
                alignment: Alignment.center,
                child: SleekCircularSlider(
                  appearance: appearance03,
                  min: 0,
                  max: 11,
                  initialValue: hours % 12,
                  innerWidget: (double value) {
                    final h = hours.toInt() < 12
                        ? 'AM ${hours.toInt() % 12}'
                        : 'PM ${hours.toInt() % 12}';
                    final m = minutes.toInt() < 10
                        ? '0${minutes.toInt()}'
                        : minutes.toInt().toString();
                    final s = seconds.toInt() < 10
                        ? '0${seconds.toInt()}'
                        : seconds.toInt().toString();
                    return Center(
                        child: Text(
                      '${hours.toInt() % 12} : $m : $s',
                      style: TextStyle(
                          color: HexColor('#A177B0'),
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ));
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

final customWidth01 =
    CustomSliderWidths(trackWidth: 2, progressBarWidth: 10, shadowWidth: 20);
final customColors01 = CustomSliderColors(
    dotColor: Colors.white.withOpacity(0.8),
    trackColor: HexColor('#FFD4BE').withOpacity(0.4),
    progressBarColor: HexColor('#F6A881'),
    shadowColor: HexColor('#FFD4BE'),
    shadowStep: 10.0,
    shadowMaxOpacity: 0.6);

final CircularSliderAppearance appearance01 = CircularSliderAppearance(
    customWidths: customWidth01,
    customColors: customColors01,
    startAngle: 270,
    angleRange: 360,
    size: 350.0,
    animationEnabled: false);

final customWidth02 =
    CustomSliderWidths(trackWidth: 5, progressBarWidth: 15, shadowWidth: 30);
final customColors02 = CustomSliderColors(
    dotColor: Colors.white.withOpacity(0.8),
    trackColor: HexColor('#98DBFC').withOpacity(0.3),
    progressBarColor: HexColor('#6DCFFF'),
    shadowColor: HexColor('#98DBFC'),
    shadowStep: 15.0,
    shadowMaxOpacity: 0.3);

final CircularSliderAppearance appearance02 = CircularSliderAppearance(
    customWidths: customWidth02,
    customColors: customColors02,
    startAngle: 270,
    angleRange: 360,
    size: 290.0,
    animationEnabled: false);

final customWidth03 =
    CustomSliderWidths(trackWidth: 8, progressBarWidth: 20, shadowWidth: 40);
final customColors03 = CustomSliderColors(
    dotColor: Colors.white.withOpacity(0.8),
    trackColor: HexColor('#EFC8FC').withOpacity(0.3),
    progressBarColor: HexColor('#A177B0'),
    shadowColor: HexColor('#EFC8FC'),
    shadowStep: 20.0,
    shadowMaxOpacity: 0.3);

final CircularSliderAppearance appearance03 = CircularSliderAppearance(
    customWidths: customWidth03,
    customColors: customColors03,
    startAngle: 270,
    angleRange: 360,
    size: 210.0,
    animationEnabled: false);

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
String durationToString(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  String twoDigitMinutes =
  twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour));
  String twoDigitSeconds =
  twoDigits(duration.inSeconds.remainder(Duration.secondsPerMinute));
  return "$twoDigitMinutes:$twoDigitSeconds";
}
