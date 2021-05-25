import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/app_localizatioan/localization.dart';
import 'package:inforamclub/app/core/models/user_model.dart';
import 'package:inforamclub/app/modules/profile/controllers/profile_controller.dart';

class Profile extends GetView<MyProfileController> {
  final UserModel data;
  final Widget profilePic;
  final Widget languageTile;
  final bool isMyProfile;

  const Profile(
      {this.isMyProfile = true,
      this.languageTile = const SizedBox.shrink(),
      this.profilePic = const SizedBox.shrink(),
      Key key,
      this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tr = Localization.of(context).languageCode;
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.deepPurple[800],
                          Colors.deepPurpleAccent
                        ],
                      ),
                    ),
                    child: Column(children: [
                      SizedBox(
                        height: 40.0,
                      ),
                      profilePic,
                      SizedBox(
                        height: 10.0,
                      ),
                      Text('${data.firstName} ${data.lastName}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          )),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        data.phone ?? '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      )
                    ]),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 7,
                child: Container(
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      languageTile,
                      ListTile(
                        title: Text(tr[2]),
                        subtitle: Text(data.email),
                        leading: Icon(
                          FontAwesomeIcons.mailBulk,
                          color: Colors.blueAccent[400],
                          size: 35,
                        ),
                      ),
                      ListTile(
                        title: Text(tr[7]),
                        subtitle: Text(data.gender ?? ''),
                        leading: Icon(
                          FontAwesomeIcons.transgender,
                          color: Colors.green,
                          size: 35,
                        ),
                      ),
                      Visibility(
                        visible: isMyProfile,
                        child: ListTile(
                          title: Text(tr[4]),
                          subtitle: Text(data.password),
                          leading: Icon(
                            FontAwesomeIcons.lock,
                            color: Colors.red,
                            size: 35,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                  color: Colors.white,
                )),
          ],
        ),
        Positioned.fill(
          bottom: 60,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.weightHanging,
                        color: Colors.purple,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${data.weight}',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 24,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  VerticalDivider(
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.child,
                        color: Colors.purple,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${data.height}',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 24,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
              width: 350,
              height: 80,
              decoration: BoxDecoration(
                  boxShadow: [BoxShadow(spreadRadius: 2, blurRadius: 5)],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
        )
      ],
    );
  }
}
/*
                    Expanded(
                      flex: 6,
                      child: Container(
                        color: Colors.grey[200],
                        child: Card(
                            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: Container(
                                width: 310.0,
                                height: 290.0,
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Information",
                                        style: TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey[300],
                                      ),
                                      ProfileInfoTile(
                                        icon: Icon(
                                          FontAwesomeIcons.mailBulk,
                                          color: Colors.blueAccent[400],
                                          size: 35,
                                        ),
                                        title: 'Email',
                                        subTitle: 'test@test.com',
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),

                                      ProfileInfoTile(
                                        icon: Icon(
                                          FontAwesomeIcons.transgender,
                                          color: Colors.deepOrangeAccent,
                                          size: 35,
                                        ),
                                        title: 'Gender',
                                        subTitle: 'male',
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),


                                      ProfileInfoTile(
                                        icon: Icon(
                                          FontAwesomeIcons.lock,
                                          color: Colors.red,
                                          size: 35,
                                        ),
                                        title: 'Password',
                                        subTitle: '**********',
                                      ),                                    SizedBox(
                                        height: 20.0,
                                      ),
                                    ],
                                  ),
                                ))),
                      ),
                    ),
*/

/*
                Positioned(
                    top:MediaQuery.of(context).size.height*0.45,
                    left: 20.0,
                    right: 20.0,
                    child: Card(
                        child: Padding(
                          padding:EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  child:Column(
                                    children: [
                                      Text('Battles',
                                        style: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 14.0
                                        ),),
                                      SizedBox(height: 5.0,),
                                      Text("$counter",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),)
                                    ],
                                  )
                              ),

                              Container(
                                child: Column(
                                    children: [
                                      Text('Birthday',
                                        style: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 14.0
                                        ),),
                                      SizedBox(height: 5.0,),
                                      Text('April 7th',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),)
                                    ]),
                              ),

                              Container(
                                  child:Column(
                                    children: [
                                      Text('Age',
                                        style: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 14.0
                                        ),),
                                      SizedBox(height: 5.0,),
                                      Text('19 yrs',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),)
                                    ],
                                  )
                              ),
                            ],
                          ),
                        )
                    )
                )
*/
