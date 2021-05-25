import 'package:inforamclub/main.dart';
import '../models/notification_model.dart';

class SendNotificationLocalData {

 static Future<void> saveNotification(NotificationModel notificationModel) async =>
       box.put('notification', notificationModel.toMap());

}