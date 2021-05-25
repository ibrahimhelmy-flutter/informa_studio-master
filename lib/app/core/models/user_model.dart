import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:inforamclub/app/core/models/firestore_data_model.dart';

enum UserType { admin, user }

class UserModel extends FirestoreModel {
  final String firstName,
      lastName,
      email,
      picUrl,
      phone,
      gender,
      id,
      notificationToken,
      identityCard,
      password;
  final UserType type;

  final double height, weight;

  UserModel({
    this.firstName,
    this.height,
    this.type,
    this.notificationToken,
    this.weight,
    this.identityCard,
    this.email,
    this.id,
    this.picUrl,
    this.phone,
    this.password,
    this.gender,
    this.lastName,
  });

  bool get isAdmin => type == UserType.admin;

  UserModel toAdmin(UserModel userModel) =>
      userModel.copyWith(type: UserType.admin);

  UserModel toUser(UserModel userModel) =>
      userModel.copyWith(type: UserType.user);

  UserModel toggleAdmin(UserModel userModel) =>
      userModel.isAdmin ? toUser(userModel) : toAdmin(userModel);

  String get name => '$firstName $lastName';

  UserModel copyWith({
    String firstName,
    String lastName,
    String email,
    String picUrl,
    String phone,
    String gender,
    String id,
    String notificationToken,
    String identityCard,
    String password,
    UserType type,
    double height,
    double weight,
  }) {
    if ((firstName == null || identical(firstName, this.firstName)) &&
        (lastName == null || identical(lastName, this.lastName)) &&
        (email == null || identical(email, this.email)) &&
        (picUrl == null || identical(picUrl, this.picUrl)) &&
        (phone == null || identical(phone, this.phone)) &&
        (gender == null || identical(gender, this.gender)) &&
        (id == null || identical(id, this.id)) &&
        (notificationToken == null ||
            identical(notificationToken, this.notificationToken)) &&
        (identityCard == null || identical(identityCard, this.identityCard)) &&
        (password == null || identical(password, this.password)) &&
        (type == null || identical(type, this.type)) &&
        (height == null || identical(height, this.height)) &&
        (weight == null || identical(weight, this.weight))) {
      return this;
    }

    return new UserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      picUrl: picUrl ?? this.picUrl,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      id: id ?? this.id,
      notificationToken: notificationToken ?? this.notificationToken,
      identityCard: identityCard ?? this.identityCard,
      password: password ?? this.password,
      type: type ?? this.type,
      height: height ?? this.height,
      weight: weight ?? this.weight,
    );
  }

  @override
  UserModel fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    if (documentSnapshot == null) {
      return null;
    }
    final data = documentSnapshot.data();
    return UserModel(
      notificationToken: data['notificationToken'] as String,
      firstName: data['firstName'] as String,
      lastName: data['lastName'] as String,
      email: data['email'] as String,
      picUrl: data['picUrl'] as String,
      phone: data['phone'] as String,
      height: data['height'] as num,
      weight: data['weight'] as num,
      gender: data['gender'] as String,
      id: documentSnapshot.id,
      identityCard: data['identityCard'] as String,
      type: EnumToString.fromString(UserType.values, data['type']),
      password: data['password'] as String,
    );
  }

  @override
  UserModel fromMap(Map<String, dynamic> map) {
    return new UserModel(
      id: map['id'],
      type: map['type'] == null
          ? UserType.user
          : EnumToString.fromString(UserType.values, map['type']),
      notificationToken: map['notificationToken'],
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      picUrl: map['picUrl'] as String,
      phone: map['phone'] as String,
      gender: map['gender'] as String,
      identityCard: map['identityCard'] as String,
      password: map['password'] as String,
      height: map['height'] as num,
      weight: map['weight'] as num,
    );
  }

  @override
  // TODO: implement toMap
  Map<String, dynamic> get toMap => {
        'id': this.id,
        'firstName': this.firstName,
        'lastName': this.lastName,
        'email': this.email,
        'picUrl': this.picUrl,
        'phone': this.phone,
        'gender': this.gender,
        'notificationToken': this.notificationToken,
        'identityCard': this.identityCard,
        'type': EnumToString.convertToString(this.type),
        'password': this.password,
        'height': this.height,
        'weight': this.weight,
      };
}
