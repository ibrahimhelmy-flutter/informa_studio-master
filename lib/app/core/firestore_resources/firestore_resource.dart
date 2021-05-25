import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inforamclub/app/core/models/firestore_data_model.dart';

abstract class FirestoreResource<T extends FirestoreModel> {
  final String collectionName;
  final T basicModel;

  // BasicModel basicModel ;

  FirestoreResource(this.collectionName, this.basicModel);

  CollectionReference get collectionReference =>
      FirebaseFirestore.instance.collection(collectionName);

  Stream<QuerySnapshot> listenToCollection() =>
      collectionReference.snapshots();/*.map((event) =>
          event.docs.map((e) => basicModel.fromDocumentSnapshot(e)).toList())*/

  Stream<T> listenToDocument(String docName) => collectionReference
      .doc(docName)
      .snapshots()
      .map((event) => basicModel.fromDocumentSnapshot(event));

  Future<List<T>> get getAll async {
    final collection = await collectionReference.get();

    return collection.docs
        .map((e) => (basicModel.fromDocumentSnapshot(e)) as T)
        .toList();
  }

  Future<T> get([String id]) async {
    final document = await collectionReference.doc(id).get();
    return (basicModel.fromDocumentSnapshot(document)) as T;
  }

  Future<void> delete(String id) async =>
      await collectionReference.doc(id).delete();

  Future<void> update(T model, String id) async =>
      await collectionReference.doc(id).update(model.toMap);

  // Stream<QuerySnapshot> get snapshots {
  //   return collectionReference.snapshots();
  // }

  Future<DocumentReference> add(T model) async =>
      await collectionReference.add(model.toMap);
}
