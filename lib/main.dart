import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'UI/login/login_screen.dart';
import 'UI/splash/splash_screen.dart';
import 'UI/theme.dart';

void main() async {
  print('main');
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: color,
      100: color,
      200: color,
      300: color,
      400: color,
      500: color,
      600: color,
      700: color,
      800: color,
      900: color,
    });
  }

  @override
  Widget build(BuildContext context) {
    print(GetStorage().read('isLoggedin'));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
          TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: bluedeep1),
        ))),
        scaffoldBackgroundColor: offWhite,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: bluedeep1),
          backgroundColor: offWhite,
          centerTitle: true,
          toolbarHeight: 50,
          elevation: 0,
          //  color: blueDark,
          titleTextStyle: TextStyle(
            color: blueDark,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        iconTheme: IconThemeData(color: bluedeep1),
        primaryIconTheme: IconThemeData(color: bluedeep1),
        primarySwatch: generateMaterialColor(Colors.grey),
      ),
      home: GetStorage().read('isLoggedin') ?? false == true
          ? const SplashScreen()
          : const LoginScreen(),
    );
  }
}
