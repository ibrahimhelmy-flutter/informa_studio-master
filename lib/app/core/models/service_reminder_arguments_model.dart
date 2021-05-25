import 'package:inforamclub/app/core/models/schedule_notification_model.dart';
import 'package:inforamclub/app/core/models/service_model.dart';

class ServiceReminderArgumentModel {
final ScheduleNotificationModel scheduleNotificationModel ;
 final DateTime start;

  ServiceReminderArgumentModel(this.scheduleNotificationModel, this.start);
}