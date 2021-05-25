import 'package:get/get.dart';

class WeightHeightGenderController extends GetxController {
  var weight = 20.0.obs;

  var height = 30.0.obs;

  var gender = 'Male'.obs;

  void selectGender(String selectedGender) => gender(selectedGender);

  void onChangedHeight(double value) => this.height(value);

  void onChangedWeight(double value) => this.weight(value);
}
