class NotificationModel {

  final String body, title ,gender;

  NotificationModel({this.body, this.title, this.gender});

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return new NotificationModel(
      body: map['body'] as String,
      title: map['title'] as String,
      gender: map['gender'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'body': this.body,
      'title': this.title,
      'gender': this.gender,
    } as Map<String, dynamic>;
  }
}