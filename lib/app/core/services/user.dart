import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/controllers/controller.dart';
import 'package:inforamclub/app/core/models/user_model.dart';
import 'package:inforamclub/app/modules/root/controllers/root_controller.dart';
import 'package:inforamclub/main.dart';

class UserService {
  static UserModel get logInUser =>
      Get.find<CoreController>().currentLoggedUser;
static Future<void> logout(){
  box.put('uid', null);
  print('logout called');
}
  static String get gender => logInUser.gender;

  static String get id => box.get('uid');

  static Future<String> get notificationToken async =>
      await FirebaseMessaging.instance.getToken();

  static bool isAdmin(UserModel userModel) => userModel.type == UserType.admin;

  static bool get  isIamAdmin =>(logInUser).isAdmin;
  static bool get isIamLoggedIn => box.get('uid')!=null;


}
