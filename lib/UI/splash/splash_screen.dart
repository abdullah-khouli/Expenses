import 'package:e_family_expenses/UI/login/logo.dart';
import 'package:e_family_expenses/UI/main/main_screen.dart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants.dart';
import '../login/login_screen.dart';
import '../theme.dart';
import '../users/users_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    isUserDeleted();
    super.initState();
  }

  final userControler = Get.put(UsersController());
  isUserDeleted() async {
    //here i am sure the user is logged in but i am checking if the user has deleted
    await userControler
        .getUser(GetStorage().read(Constants.id) ?? '')
        .then((value) {
      if (value.isEmpty) {
        Get.off(() => const MainScreen());
      } else if (value.toLowerCase().contains('not found')) {
        Get.off(() => const LoginScreen());
      } else {
        splashShowMyDialog(context, 'some thing went wrong')
            .then((value) => Get.back());
      }
    }).onError((error, stackTrace) =>
            splashShowMyDialog(context, 'some thing went wrong').then((value) {
              Get.back();
            }));
  }

  Future splashShowMyDialog(BuildContext context, String message) async {
    var alertDialog = AlertDialog(
      title: Text(
        'Error',
        style: subHeadingStyle.copyWith(fontSize: 25, color: test),
      ),
      content: Text(
        message,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            'Ok',
            style: body2Style.copyWith(color: Colors.black, fontSize: 16),
          ),
        ),
      ],
    );
    await showDialog(
      context: context,
      builder: (ctx) => alertDialog,
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Logo(),
        SizedBox(height: 25),
        Center(child: CircularProgressIndicator())
      ],
    ));
  }
}
