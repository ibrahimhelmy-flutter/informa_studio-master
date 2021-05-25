import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:inforamclub/app/core/firestore_resources/about_us_firestore_resource.dart';
import 'package:inforamclub/app/core/firestore_resources/service_types_firestore_resource.dart';
import 'package:inforamclub/app/core/firestore_resources/sider_images_firestore_resource.dart';
import 'package:inforamclub/app/core/firestore_resources/users_firestore_resource.dart';
import 'package:inforamclub/app/core/models/about_us.dart';
import 'package:inforamclub/app/core/models/service_type.dart';
import 'package:inforamclub/app/core/models/slider_image_model.dart';
import 'package:inforamclub/app/core/models/user_model.dart';
import 'package:inforamclub/app/core/repos/core_repo.dart';
import 'package:inforamclub/app/core/services/user.dart';
import 'package:inforamclub/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart';

class CoreController extends GetxController {
  final _coreRepo = CoreRepo();
  var isSliderLoading = true.obs;
  var isAboutUsLoading = true.obs;
  var isServiceTypesLoading = true.obs;
  final _firebaseMessagingInstance = FirebaseMessaging.instance;
  UserModel currentLoggedUser;
  List<SliderImageModel> sliderImages;
  List<ServiceTypeModel> serviceTypes;
  AboutUsModel aboutUs;

  Future<void> _fetchAboutUs() async {
    this.aboutUs = await AboutUsFirestoreResource().get();
    isAboutUsLoading(false);
  }

  Future<void> _fetchSliderImages() async {
    sliderImages = await SliderImagesFirestoreResource().getAll;
    isSliderLoading(false);
  }

  Future<void> deleteSliderImage(String id, int index) async {
    sliderImages.removeAt(index);
    update();
    await SliderImagesFirestoreResource().delete(id);
  }


  Future<void> deleteServiceType(String id, int index) async {
    serviceTypes.removeAt(index);
    update();
    ServiceTypeFirestoreResource().delete(id);
  }

  Future<void> addSliderImage() async {
    final sliderImage = await _coreRepo.addSliderImage();
    sliderImages.add(sliderImage);
    update();
  }

  Future<void> _fetchServiceTypes() async {
    this.serviceTypes = await ServiceTypeFirestoreResource().getAll;
    isServiceTypesLoading(false);
  }

  void _onCurrentLoggedUserDeleted() {
    _firebaseMessagingInstance.unsubscribeFromTopic(UserService.gender);
    Get.offAllNamed(Routes.LOGIN);
  }

  void _fetchUser() {
    UserFirestoreResource()
        .listenToCurrentLoggedUser()
        .listen((updatedCurrentLoggedUser) async {
      if (updatedCurrentLoggedUser == null) {
        _onCurrentLoggedUserDeleted();
        return;
      }

      this.currentLoggedUser = updatedCurrentLoggedUser;
      update();

      bool genderIsChanged = this.currentLoggedUser != null &&
          updatedCurrentLoggedUser.gender != this.currentLoggedUser.gender;
      if (genderIsChanged) {
        await _firebaseMessagingInstance
            .subscribeToTopic(updatedCurrentLoggedUser.gender);
      }
    });
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    _fetchUser();
    _fetchSliderImages();
    _fetchServiceTypes();
    _fetchAboutUs();
    _coreRepo.initFirebaseMessaging();
  }

  void launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch ';

  void launchWaze() async => _coreRepo.launchWaze(aboutUs.waze);

  void launchWhatsapp() async => _coreRepo.launchWhatsapp(aboutUs.whatsApp);

  void launchInstagram() async => _coreRepo.launchURL(aboutUs.instagram);
}
