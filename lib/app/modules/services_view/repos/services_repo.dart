class ServicesRepo {
  static DateTime get afterSevenDays => recentSunDay.add(Duration(days: 6));

 static DateTime get recentSunDay {
    var today = new DateTime.now();

    while (today.weekday != 7) {
      today = today.subtract(new Duration(days: 1));
    }
    return today;
  }

 static List<DateTime> get weekDates {
    var initialDate = recentSunDay;

    final weekDates = [initialDate];
    for (var i = 0; i < 6; i++) {
      initialDate = initialDate.add(Duration(days: 1));
      weekDates.add(initialDate);
    }

    return weekDates;
  }
}
