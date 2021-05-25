import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:inforamclub/app/core/widgets/pop_up.dart';
import '../local_data/send_notification_local_data.dart';
import '../models/notification_model.dart';

class SendNotificationController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();

  Future<void> send() async {
    final formState = formKey.currentState;

    if (formState.validate()) {
      formState.save();

      final formStateValue = formState.value;

      final notification = NotificationModel.fromMap(formStateValue);
      final notificationData = {
        "notification": {
          'title': notification.title,
          'body': notification.body
        },
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
        },
        "to": "/topics/${notification.gender}"
      };
      try {
        await Dio().post('https://fcm.googleapis.com/fcm/send',
            data: notificationData,
            options: Options(contentType: 'application/json', headers: {
              'Authorization':
                  'Bearer AAAAQhbIzbQ:APA91bHIAGAVp_l111WeGM5oqZbHV22rXcLKBKpewViabCa9KvMnUYen0qCkfsxDf6HC3PaPjKxb5lXbnnshPOlAzDaljblQhozkEhxFuikCRxaSPpaCeZrs1lThv5K0XhjWU8pRp1F2'
            }));
        SendNotificationLocalData.saveNotification(notification);

        PopUp.showSnackBar('Success Send');
      } catch (e) {
        PopUp.showSnackBar('Error happens');
        throw e;
      }
    }
  }
}
