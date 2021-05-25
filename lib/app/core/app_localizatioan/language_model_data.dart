import 'package:inforamclub/main.dart';

class LanguageModel {
  final String name, code;

  LanguageModel(this.name, this.code);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          code == other.code;

  @override
  int get hashCode => name.hashCode ^ code.hashCode;
}

class LanguageUtility {
  static LanguageModel get currentLanguage => supportedLanguages
      .where((element) => element.code == box.get('languageCode'))
      .first;
}

final supportedLanguages = [
  LanguageModel('English', 'en'),
  LanguageModel('العربية', 'ar'),
  LanguageModel('עברית', 'iw'),
];
