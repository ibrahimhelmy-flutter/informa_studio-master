import 'dart:async';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/firestore_resources/services_firestore_resource.dart';
import 'package:inforamclub/app/core/models/service_model.dart';
import 'package:inforamclub/app/core/widgets/pop_up.dart';
import 'package:inforamclub/app/modules/services_view/repos/services_repo.dart';
import 'package:inforamclub/app/modules/services_view/views/widgets/calender_week_view/calendar_week.dart';

class ServicesViewController extends GetxController {
  CalendarWeekController controller = CalendarWeekController();

  List<ServiceModel> _thisWeekServices;

  List<DateTime> weekDates = ServicesRepo.weekDates;
  List<ServiceModel> thisDayServices;

  void _assignServices(List<ServiceModel> thisWeekServices) {
    _thisWeekServices = thisWeekServices;
    thisDayServices = getThisDayServices;
    update();
  }

  Future<void> listenToServices() async {
    final thisWeekServices =
        ServicesFirestoreResource().getThisWeekServices(minDate);

    thisWeekServices.listen((event) {

      _assignServices(event.docs
          .map((e) => ServiceModel().fromDocumentSnapshot(e))
          .toList());
    });
  }

  List<ServiceModel> get getThisDayServices => _thisWeekServices
      .where((element) => element.start.day == controller.selectedDate.day)
      .toList();

  DateTime get maxDate => ServicesRepo.afterSevenDays;

  DateTime get minDate => ServicesRepo.recentSunDay;

  void checkStartAndEnd() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      update();
      // for (var i = 0; i < thisDayServices.length; i++) {
      //   final service = serviceModel[i].services[i];
      //   if (service.isEnded && !service.markAsEnded) {
      //     serviceModel[i].services[i].markAsEnded = true;
      //     update(['$i$i']);
      //   } else if (service.isStarted && !service.markAsStarted) {
      //     serviceModel[i].services[i].markAsStarted = true;
      //     update(['$i$i']);
      //   } else if (service.isEndedFromFiveMinutes &&
      //       !service.markAsEndedFromFiveMinutes) {
      //     serviceModel[i].services[i].markAsEndedFromFiveMinutes = true;
      //     update();
      //   }
      // }
    });
  }

  Future<void> onSelectDate(DateTime selectedDate) async {
    thisDayServices = getThisDayServices;
    update();
  }

  Future<void> delete(String id, int index) async {
    PopUp.showConfirmAlert(() {
      ServicesFirestoreResource().delete(id);
    });
  }

  Future<void> toggleJoin(ServiceModel service) async {
    ServicesFirestoreResource().toggleJoin(service);
  }

  Future<void> toggleJoinToWaitingRoom(ServiceModel service) async {
    ServicesFirestoreResource().toggleJoinToWaitingRoom(service);
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    listenToServices();
    checkStartAndEnd();
  }
}
