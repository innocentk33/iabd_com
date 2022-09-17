import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controller/splash_screen_controller.dart';
import 'controller/user_controller.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FFAppState(); // Initialize FFAppState
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //INitialisation du stockage
  await GetStorage.init();
  Get.put(UserController());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = ThemeMode.system;
  SplashScreenController controller = Get.put(SplashScreenController());
  bool displaySplashImage = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(
        Duration(seconds: 1), () => setState(() => displaySplashImage = false));
    _getUserLogin();
  }

  void setLocale(String language) =>
      setState(() => _locale = createLocale(language));
  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'iabd-com',
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('fr'),
      ],
      theme: ThemeData(brightness: Brightness.light),
      themeMode: _themeMode,
      home: displaySplashImage
          ? Container(
              color: FlutterFlowTheme.of(context).primaryBtnText,
              child: Builder(
                builder: (context) => Image.asset(
                  'assets/images/signature-mail-IABD-Sarl.png',
                  fit: BoxFit.none,
                ),
              ),
            )
          : CircularProgressIndicator(),
    );
  }

  _getUserLogin() async {
    String? login = await controller.getUserLogin();
    Get.offAll((login != null ) ? const CommercialHomeWidget() : const LoginWidget());
  }
}
