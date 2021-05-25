import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/modules/register/controllers/register_controller.dart';

class GenderCard extends GetView<RegisterController> {
  final IconData iconData;
  final String text;
  final bool isSelected;
  final GestureTapCallback onTap;

  GenderCard({this.onTap, this.iconData, this.isSelected = false, this.text});

  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color:!isSelected ? Colors.transparent : Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Icon(
                  iconData,
                  size: 100,
                ),
                height: 150,
                width: 200,
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment(0.90, -0.90),
                  child: Container(
                      decoration: BoxDecoration(
                          color:  Colors.black,
                          shape: BoxShape.circle),
                      child: Visibility(
                        visible: isSelected,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          text,
        ),
      ],
    );
  }
}
