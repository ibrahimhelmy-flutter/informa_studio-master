import 'package:get/get.dart';
import 'package:inforamclub/app/core/firestore_resources/users_firestore_resource.dart';
import 'package:inforamclub/app/core/models/user_model.dart';
import 'package:inforamclub/app/core/services/user.dart';
import 'package:inforamclub/app/core/widgets/pop_up.dart';

class UsersController extends GetxController {
  List<UserModel> searchResult;

  List<UserModel> users;

  List<UserModel> displayedList;

  void _listenToUsers() {
    UserFirestoreResource().listenToCollection().listen((event) {
      this.users =
          event.docs.map((e) => UserModel().fromDocumentSnapshot(e)).toList();
      displayedList = users;
      update();
    });
  }

  void delete(int index) {
    PopUp.showConfirmAlert(() {
      UserFirestoreResource().delete(users[index].id);
    });
  }

  Future<void> toggleAdmin(int index) async {
    final userModel = users[index];

    await UserFirestoreResource()
        .update(userModel.toggleAdmin(userModel), userModel.id);
  }

  @override
  void onInit() {
    super.onInit();
    _listenToUsers();
  }

  void onChanged(String value) {
    if (value.isEmpty) {
      displayedList = users;
    } else {
      searchResult = users
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()) ||
              element.email.toLowerCase().contains(value.toLowerCase()))
          .toList();
      displayedList = searchResult;
    }

    update();
  }
}
