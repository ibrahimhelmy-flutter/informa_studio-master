import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/app_localizatioan/localization.dart';
import 'package:inforamclub/app/core/models/service_model.dart';

import 'details_card_widget.dart';

class ServiceDetailsGrid extends StatelessWidget {
  final ServiceModel serviceModel;

  const ServiceDetailsGrid({Key key, this.serviceModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tr = Localization.of(context).languageCode;

    return SliverGrid(
      delegate: SliverChildListDelegate(
        [
          DetailsCard(
            text: serviceModel.maxSubscribers.toString(),
            title:tr[73],
            icon: Icon(
              FontAwesomeIcons.users,
              color: Colors.white,
              size: 40,
            ),
            color: Color(0xff0F7337),
          ),
          DetailsCard(
            text: serviceModel.date,
            title: tr[74],

            // text: 'hello',
            icon: Icon(
              FontAwesomeIcons.calendar,
              color: Colors.white,
              size: 40,
            ),
            color: Colors.blue,
          ),
          DetailsCard(
            text: serviceModel.getStartTime,
            title: tr[75],
            icon: Icon(
              FontAwesomeIcons.clock,
              color: Colors.white,
              size: 40,
            ),
            color: Color(0xff001959),
          ),
          DetailsCard(
            text: serviceModel.getEndTime,
            title: tr[76],
            icon: Icon(
              FontAwesomeIcons.clock,
              color: Colors.white,
              size: 40,
            ),
            color: Color(0xff1A1A1A),
          ),
        ],
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10,
          crossAxisSpacing: 14,
          childAspectRatio: (Get.width / 2) / 180,
          crossAxisCount: 2),
    );
  }
}
