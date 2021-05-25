import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/app_localizatioan/localization.dart';
import 'package:inforamclub/app/core/models/service_model.dart';
import 'package:inforamclub/app/core/widgets/pop_up.dart';
import 'package:inforamclub/app/modules/services_view/controllers/services_view_controller.dart';
import 'package:progress_state_button/progress_button.dart';

class JoinButton extends GetView<ServicesViewController> {
  final ServiceModel service;
  final double width, height;

  JoinButton({this.service, this.width = 100, this.height = 40});

  String get text {
    final tr = Localization.of(Get.context).languageCode;
    if (service.isEnded) {
      // return 'Ended';
      return tr[66];
    }
    if (service.isStarted) {
      // return 'Started';
      return tr[65];
    }

    if (service.isSubscribed) {
      return tr[68];

      return "Leave";
    }

    if (service.isFull) {
      return tr[69];

      return 'Full';
      if (service.isJoinedToWaitingRoom) {
        return 'leave waiting room';
      } else {
        return 'join waiting room';
      }
    }
    return tr[67];
    return 'Join';
  }

  Function get onPressed {
    if (service.isSubscribed)
      return () => PopUp.showConfirmAlert(() {
            controller.toggleJoin(service);
          });

    if (service.isStarted || service.isEnded || service.isFull) {
      return () {};
    }

    return () => controller.toggleJoin(service);
  }

  Color get color {
    if (service.isStarted || service.isEnded) {
      return Colors.grey;
    }

    if (service.isSubscribed) return Colors.red;

    if (service.isFull) return Colors.grey;

    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    // final service = controller.selectedServices[index];
    return SizedBox(
      width: width,
      child: ProgressButton(
        maxWidth: width,
        height: height,
        stateWidgets: {
          ButtonState.idle: Text(
            "Full",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          ButtonState.loading: Text(
            "Loading",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          ButtonState.fail: Text(
            "Leave",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          ButtonState.success: Text(
            text,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          )
        },
        stateColors: {
          ButtonState.idle: Colors.grey.shade400,
          ButtonState.loading: Colors.blue.shade300,
          ButtonState.fail: Colors.red,
          ButtonState.success: color,
        },
        onPressed: onPressed,
        state: ButtonState.success,
      ),
    );
  }
}
