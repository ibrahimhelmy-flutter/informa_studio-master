import 'package:flutter/material.dart';
import '../calender_week_view/utils/compare_date.dart';
import 'package:rxdart/rxdart.dart';

 
class DateItem extends StatefulWidget {
  /// Today
  final DateTime today;

  /// Date of item
  final DateTime date;

  /// Style of [date]
  final TextStyle dateStyle;

  /// Style of day after pressed
  final TextStyle pressedDateStyle;

  /// Background
  final Color backgroundColor;

  /// Specify a background if [date] is [today]
  final Color todayBackgroundColor;

  /// Specify a background after pressed
  final Color pressedBackgroundColor;

  /// Alignment a decoration
  final Alignment decorationAlignment;

  /// Specify a shape
  final ShapeBorder dayShapeBorder;

  /// [Callback] function for press event
  final void Function(DateTime) onDatePressed;

  /// [Callback] function for long press event
  final void Function(DateTime) onDateLongPressed;

  /// Decoration widget
  final Widget decoration;

  /// [BehaviorSubject] for emit, listen last date pressed
  final BehaviorSubject<DateTime> subject;

  DateItem({
    @required this.today,
    @required this.date,
    @required this.subject,
    this.dateStyle,
    this.pressedDateStyle,
    this.backgroundColor = Colors.transparent,
    this.todayBackgroundColor = Colors.orangeAccent,
    this.pressedBackgroundColor,
    this.decorationAlignment = FractionalOffset.center,
    this.dayShapeBorder,
    this.onDatePressed,
    this.onDateLongPressed,
    this.decoration,
  });

  @override
  __DateItemState createState() => __DateItemState();
}

class __DateItemState extends State<DateItem> {
  /// Default background
  Color _defaultBackgroundColor;

  /// Default style
  TextStyle _defaultTextStyle;

  @override
  Widget build(BuildContext context) => widget.date != null
      ? StreamBuilder(
          stream: widget.subject,
          builder: (_, data) {
            /// Set default each [builder] is called 
            _defaultBackgroundColor = widget.backgroundColor;

            /// Set default style each [builder] is called 
            _defaultTextStyle = widget.dateStyle;

            /// Check and set [Background] of today
            if (compareDate(widget.date, widget.today)) {
              _defaultBackgroundColor = widget.todayBackgroundColor;
            } else if (data != null && !data.hasError && data.hasData) {
              final DateTime dateSelected = data.data;
              if (compareDate(widget.date, dateSelected)) {
                _defaultBackgroundColor = widget.pressedBackgroundColor;
                _defaultTextStyle = widget.pressedDateStyle;
              }
            }
            return _body();
          },
        )
      : Container(
          width: 50,
          height: 50,
        );

  /// Body layout
  Widget _body() => Container(
        width: 50,
        height: 50,
        alignment: FractionalOffset.center,
        child: GestureDetector(
          onLongPress: _onLongPressed,
          child: FlatButton(
              padding: EdgeInsets.all(5),
              onPressed: _onPressed,
              color: _defaultBackgroundColor,
              shape: widget.dayShapeBorder,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${widget.date.day}',
                        style: _defaultTextStyle,
                      ),
                    ),
                  ),
                  _decoration()
                ],
              )),
        ),
      );

  /// Decoration layout
  Widget _decoration() => Positioned(
        top: 28,
        left: 0,
        right: 0,
        child: Container(
            width: 50,
            height: 12,
            alignment: widget.decorationAlignment,
            child: widget.decoration != null
                ? FittedBox(
                    fit: BoxFit.scaleDown,
                    child: widget.decoration,
                  )
                : Container()),
      );

  /// Handler press event
  void _onPressed() {
    widget.subject.add(widget.date);
    widget.onDatePressed(widget.date);
  }

  /// Handler long press event
  void _onLongPressed() {
    widget.subject.add(widget.date);
    widget.onDateLongPressed(widget.date);
  }
}
