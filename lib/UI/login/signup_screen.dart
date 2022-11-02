import 'package:e_family_expenses/UI/login/login_button.dart';
import 'package:e_family_expenses/UI/random_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/models/login.dart';
import '../main/main_screen.dart.dart';
import '../theme.dart';
import 'login_controller.dart';
import 'login_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final LoginController loginCotroller = Get.put((LoginController()));
  final Map<String, String> _authData = {'user': '', 'password': ''};

  final passwordController = TextEditingController();
  @override
  void dispose() {
    passwordController.dispose();

    super.dispose();
  }

  Future<String?> submit() async {
    if (!_formKey.currentState!.validate()) {
      return null;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    return await loginCotroller.signUp(LoginModel(
        id: generateRandomString(10),
        userName: _authData['user']!,
        headFamilyId: "",
        password: _authData['password']!));
  }

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey();
    final size = MediaQuery.of(context).size;
    final top = MediaQuery.of(context).padding.top;
    print(top);
    print(size.height -
        533 -
        (size.height / 12.7 < 50 ? 50 : size.height / 12.7) -
        top);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: offWhite,
          //  appBar: AppBar(toolbarHeight: 0),
          //appBar: _abbBar(size, context),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width / 25),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 95),
                    //h=35
                    SizedBox(
                      height: 35,
                      child: Text(
                        'Create Your Acount',
                        style: headingStyle.copyWith(
                            color: bluedeep1, fontSize: 30),
                      ),
                    ),
                    const SizedBox(height: 25),
                    //h=18
                    SizedBox(
                      height: 18,
                      child: Text(
                        'Please enter info to create account',
                        style: subHeadingStyle.copyWith(color: Colors.black87),
                      ),
                    ),
                    const SizedBox(height: 30),
                    //h=80
                    SizedBox(
                      height: 80,
                      child: LoginTextField(
                        save: (user) {
                          _authData['user'] = user!.trim();
                        },
                        valid: (user) {
                          if (user!.trim().isEmpty || user.length < 2) {
                            return 'Invalid user';
                          }
                          return null;
                        },
                        hint: 'User Name',
                        prefixIcon: Icon(
                          Icons.person_outlined,
                          color: bluedeep1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    //  h=80
                    SizedBox(
                      height: 80,
                      child: Obx(() {
                        return LoginTextField(
                          suffixIcon: IconButton(
                            icon: (!loginCotroller.hidePassword.value)
                                ? const Icon(Icons.visibility)
                                : Icon(Icons.visibility_off, color: bluedeep1),
                            onPressed: () {
                              loginCotroller.changeHidePasswordStatus();
                            },
                          ),
                          hidePass: loginCotroller.hidePassword.value,
                          save: (password) {
                            _authData['password'] = password!.trim();
                          },
                          valid: (password) {
                            if (password!.trim().isEmpty ||
                                password.trim().length < 5) {
                              return 'password must be at least 5 characters';
                            }
                            return null;
                          },
                          hint: 'Password',
                          controller: passwordController,
                          prefixIcon: Icon(
                            Icons.key_outlined,
                            color: bluedeep1,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 10),
                    // const SizedBox(height: 50),
                    //h=80
                    SizedBox(
                      height: 80,
                      child: Obx(() {
                        return LoginTextField(
                          suffixIcon: IconButton(
                            icon: (!loginCotroller.hidePassword.value)
                                ? const Icon(Icons.visibility)
                                : Icon(Icons.visibility_off, color: bluedeep1),
                            onPressed: () {
                              print(key.currentContext!.size!.height);
                              loginCotroller.changeHidePasswordStatus();
                            },
                          ),
                          hidePass: loginCotroller.hidePassword.value,
                          valid: (val) {
                            if (val != passwordController.text) {
                              return 'password do not match!';
                            }
                            return null;
                          },
                          hint: 'Confirm Password',
                          prefixIcon: Icon(
                            Icons.key_outlined,
                            color: bluedeep1,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 30),
                    //h=size.height / 12.7 < 50 ? 50 : size.height / 12.7>55?55:size.height / 12.7
                    LoginButton(
                      fun: () async {
                        await submit().then((value) {
                          if (value == null) {
                          } else if (value.isEmpty) {
                            Get.offAll(() => const MainScreen());
                          } else {
                            showMyDialog(context, value);
                          }
                        });
                      },
                      name: 'SIGN UP',
                    ),
                    // Container(
                    //   margin:
                    //       EdgeInsets.symmetric(horizontal: size.width / 10),
                    //   width: size.width * 11.5 / 12.5,
                    //   height:
                    //       size.height / 12.7 < 50 ? 50 : size.height / 12.7,
                    //   decoration: BoxDecoration(
                    //     gradient: const LinearGradient(
                    //       begin: Alignment.centerLeft,
                    //       end: Alignment.centerRight,
                    //       colors: [Colors.black87, Colors.blue],
                    //     ),
                    //     borderRadius: BorderRadius.circular(25),
                    //   ),
                    //   child: ElevatedButton(
                    //       style: ButtonStyle(
                    //         backgroundColor: MaterialStateProperty.all<Color>(
                    //             Colors.transparent),
                    //         shadowColor:
                    //             MaterialStateProperty.all(Colors.transparent),
                    //         shape: MaterialStateProperty.all<
                    //             RoundedRectangleBorder>(
                    //           RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(25.0),
                    //           ),
                    //         ),
                    //       ),
                    //       onPressed: () async {
                    //         await submit().then((value) {
                    //           if (value == null) {
                    //           } else if (value.isEmpty) {
                    //             Get.offAll(() => const MainScreen());
                    //           } else {
                    //             showMyDialog(context, value);
                    //           }
                    //         });
                    //       },
                    //       child: Text('SIGN UP', style: subHeadingStyle)),
                    // ),

                    Container(
                      constraints: const BoxConstraints(minHeight: 30),
                      height: size.height -
                          533 -
                          (size.height / 12.7 < 50
                              ? 50
                              : size.height / 12.7 > 55
                                  ? 55
                                  : size.height / 12.7) -
                          MediaQuery.of(context).padding.top,
                      // -
                      // (size.height / 16 < 40 ? 40 : size.height / 16),
                    ),
                    //h=45
                    SizedBox(
                      height: 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account?'),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'LOG IN',
                              style: subHeadingStyle.copyWith(
                                  color: bluedeep1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15)
                  ],
                ),
              ),
            ),
          ),
        ),
        Obx(() {
          if (loginCotroller.sinupIsloading.value) {
            return ModalBarrier(
              color: Colors.black.withOpacity(0.3),
              dismissible: false,
              barrierSemanticsDismissible: false,
            );
          } else {
            return Container(height: 0);
          }
        }),
        Obx(() {
          if (loginCotroller.sinupIsloading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Container(height: 0);
          }
        }),
      ],
    );
  }

  AppBar _abbBar(Size size, BuildContext context) {
    return AppBar(
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(0.1),
        child: SizedBox(
          height: 0.1,
          child: Divider(
            color: Colors.grey,
          ),
        ),
      ),
      // centerTitle: true,
      title: const Text(
        'Sign Up',
        // style: titleStyle.copyWith(color: bluedeep1),
      ),
      // toolbarHeight: size.height / 16 < 40 ? 40 : size.height / 16,
      // backgroundColor: Colors.white,
      // elevation: 0,
      //leadingWidth: size.width * 0.3 > 135 ? 135 : size.width * 0.3,
      leading: Container(
        padding: EdgeInsets.only(left: size.width * 0.02),
        alignment: Alignment.centerLeft,
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: size.height / 40 < 16 ? 16 : size.height / 40,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

void showMyDialog(BuildContext context, String message) {
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
  showDialog(context: context, builder: (ctx) => alertDialog);
}
