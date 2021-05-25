import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:inforamclub/app/core/binding/initial_binding.dart';
import 'package:inforamclub/app/core/services/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'app/core/app_localizatioan/delegate.dart';
import 'app/routes/app_pages.dart';

var isTranslationLoading = true.obs;
Box box;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await getExternalStorageDirectory();
  Hive.init(dir.path);
  await Hive.openBox('box');
  box = Hive.box('box');
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  if (box.get('languageCode') == null)
    await box.put('languageCode', Get.deviceLocale.languageCode);

  await Firebase.initializeApp();

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: Colors.purple),
              color: Colors.white,
              elevation: 0),
          fontFamily: GoogleFonts.cairo().fontFamily),
      builder: (context, widget) => ResponsiveWrapper.builder(
        SafeArea(
          child: widget,
        ),
        defaultScaleFactor: 1.2,
        defaultScale: true,
      ),
      localizationsDelegates: [
        const LocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale(
          'en',
        ),
        const Locale(
          'ar',
        ),
        const Locale(
          'he',
        ),
      ],

      title: "Informa Studio",
      locale: Locale(box.get('languageCode')),
      getPages: AppPages.routes,

      initialRoute: !UserService.isIamLoggedIn
          ? AppPages.LOGIN_ROUTE
          : AppPages.HOME_ROUTE,
      // home: Test(),
    );
  }
}
class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container();
  }
}

