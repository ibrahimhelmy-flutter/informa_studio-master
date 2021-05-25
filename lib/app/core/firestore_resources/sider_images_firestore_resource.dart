import 'package:inforamclub/app/core/models/slider_image_model.dart';

import 'firestore_resource.dart';
class SliderImagesFirestoreResource extends FirestoreResource<SliderImageModel> {
  SliderImagesFirestoreResource() : super('SLIDER_IMAGES', SliderImageModel());

}