import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/app_localizatioan/localization.dart';
import 'package:inforamclub/app/modules/services_view/controllers/services_view_controller.dart';

import 'calender_week_view/calendar_week.dart';

class MyCalenderWeek extends GetView<ServicesViewController> {
  @override
  Widget build(BuildContext context) {
    final tr = Localization.of(context).languageCode;
    final controller = Get.find<ServicesViewController>();

    return CalendarWeek(
      month: [
        tr[43],
        tr[44],
        tr[45],
        tr[46],
        tr[47],
        tr[48],
        tr[49],
        tr[50],
        tr[51],
        tr[52],
        tr[53],
        tr[54],
      ],
      dayOfWeek: [
        tr[55],
        tr[56],
        tr[57],
        tr[58],
        tr[59],
        tr[60],
        tr[61],

      ],
      controller: controller.controller,
      showMonth: true,
      minDate: controller.minDate,
      maxDate: controller.maxDate,
      onDatePressed: controller.onSelectDate,
      onDateLongPressed: (DateTime datetime) {},
      todayBackgroundColor: Colors.black.withOpacity(0.2),
      dateBackgroundColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      pressedDateBackgroundColor: Colors.green,
      weekendsIndexes: [],
      weekendsStyle: TextStyle(),
      dateStyle: TextStyle(),
    );
  }
}
