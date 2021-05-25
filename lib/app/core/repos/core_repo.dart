import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:inforamclub/app/core/firestore_resources/sider_images_firestore_resource.dart';
import 'package:inforamclub/app/core/firestore_resources/users_firestore_resource.dart';
import 'package:inforamclub/app/core/models/slider_image_model.dart';
import 'package:inforamclub/app/core/services/fire_storage_service.dart';
import 'package:inforamclub/app/core/widgets/pop_up.dart';
import 'package:url_launcher/url_launcher.dart';

class CoreRepo {
  Future<SliderImageModel> addSliderImage() async {
    final pickedImage = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);
    final pickedImagePath = pickedImage.paths.first;

    final uploadedImageUrl =
        await FireStorageService.uploadFile('SLIDER_IMAGES', pickedImagePath);

    final documentRef = await SliderImagesFirestoreResource()
        .add(SliderImageModel(url: uploadedImageUrl));
    return SliderImageModel(url: uploadedImageUrl, id: documentRef.id);
  }

  void launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch ';

  void launchWaze(GeoPoint waze) async {
    final lat = waze.latitude;
    final lng = waze.longitude;
    var url = 'waze://?ll=${lat.toString()},${lng.toString()}';
    var fallbackUrl =
        'https://waze.com/ul?ll=${lat.toString()},${lng.toString()}&navigate=yes';
    try {
      bool launched =
          await launch(url, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }

  void launchWhatsapp(String number) =>
      launchURL('whatsapp://send?phone=+972$number}');

  void updateToken(String token) {
    UserFirestoreResource().updateToken(token);
  }

  Future<void> initFirebaseMessaging() async {
    final firebaseMessagingInstance = FirebaseMessaging.instance;

    updateToken(await firebaseMessagingInstance.getToken());

    firebaseMessagingInstance.onTokenRefresh.listen((event) {
      updateToken(event);
    });

    FirebaseMessaging.onMessage.listen(firebaseMessagingBackgroundHandler);
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  PopUp.showSnackBar(message.notification.body);
}
