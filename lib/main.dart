import 'package:flutter/material.dart';
import 'screens/water.dart';
import 'package:provider/provider.dart';
import 'package:aquaman/models/generalData.dart';
import 'models/generalData.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:aquaman/translations/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en'),
        Locale('de'),
        Locale('zh'),
        Locale('pl'),
      ],
      path:
          'assets/translations', // <-- change the path of the translation files
      assetLoader: CodegenLoader(),
      fallbackLocale: Locale('en'),
      useOnlyLangCode: true,

      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ChangeNotifierProvider(
      create: (context) => GeneralData(),
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          // systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: MaterialApp(
          // theme: ThemeData.light(),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: WaterScreen(),
        ),
      ),
    );
  }
}
