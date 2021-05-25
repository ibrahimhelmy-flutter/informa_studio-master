import 'package:inforamclub/app/core/models/about_us.dart';

import 'firestore_resource.dart';

class AboutUsFirestoreResource extends FirestoreResource<AboutUsModel> {
  AboutUsFirestoreResource() : super('ABOUT_US', AboutUsModel());

  String docId = 'q8oV2cVEf8Q2jBmiu768';

  Future<AboutUsModel> get([String id]) async => super.get(docId);

  @override
  Future<void> update(AboutUsModel model, [String id]) {
    return super.update(model, docId);
  }
}
