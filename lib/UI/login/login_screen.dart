import 'package:e_family_expenses/UI/login/login_button.dart';
import 'package:e_family_expenses/UI/main/main_screen.dart.dart';
import 'package:e_family_expenses/domain/models/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme.dart';
import 'login_controller.dart';
import 'login_textfield.dart';
import 'signup_screen.dart';

bool isChecked = true;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginCotroller = Get.put((LoginController()));

  final GlobalKey<FormState> _formKey = GlobalKey();

  final Map<String, String> _authData = {
    'user': '',
    'password': '',
  };
  Future<String?> submit() async {
    if (!_formKey.currentState!.validate()) {
      print('no valid');
      return null;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    print(_authData['user']);
    print(_authData['password']);
    return await loginCotroller.signin(LoginModel(
        id: '',
        userName: _authData['user']!,
        headFamilyId: '',
        password: _authData['password']!));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: offWhite,
          body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width / 15,
                vertical: size.height / 55,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 75),
                    //(size.height) / 5
                    SizedBox(
                      height: (size.height) / 5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          size.height / 8.5 < 60 ? 60 : size.height / 8.5,
                        ),
                        child: Image.asset(
                          'assets/images/logo1.jpg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    //90
                    SizedBox(
                      //  width: 275,
                      height: 90,
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
                    //90
                    SizedBox(
                      // width: 275,
                      height: 90,
                      child: Obx(() {
                        return LoginTextField(
                          suffixIcon: IconButton(
                            icon: (!loginCotroller.hidePassword.value)
                                ? const Icon(Icons.visibility)
                                : Icon(Icons.visibility_off, color: bluedeep1),
                            onPressed: () {
                              //   print(key.currentContext!.size!.height);
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
                          prefixIcon: Icon(
                            Icons.key_outlined,
                            color: bluedeep1,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    //45
                    SizedBox(
                      height: 45,
                      child: Row(
                        children: [
                          Obx(() {
                            return Checkbox(
                              value: loginCotroller.rememberMe.value,
                              onChanged: (newisChecked) {
                                loginCotroller.changerememberMeStatus();
                              },
                              checkColor: Colors.white,
                              activeColor: bluedeep1,
                            );
                          }),
                          Text(
                            'Remember me',
                            style: subTitleStyle,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 35),
                    //size.height / 12.7 < 50 ? 50 : size.height / 12.7>55?55:size.height / 12.7
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
                        name: 'LOG IN'),
                    // Container(
                    //   height: size.height / 12.7 < 50 ? 50 : size.height / 12.7,
                    //   margin: EdgeInsets.symmetric(horizontal: size.width / 10),
                    //   decoration: BoxDecoration(
                    //     gradient: const LinearGradient(
                    //       begin: Alignment.centerLeft,
                    //       end: Alignment.centerRight,
                    //       colors: [Colors.black87, Colors.blue],
                    //     ),
                    //     borderRadius: BorderRadius.circular(25),
                    //   ),
                    //   width: size.width * 11.5 / 12.5,
                    //   child: ElevatedButton(
                    //     style: ButtonStyle(
                    //       shape: MaterialStateProperty.all(
                    //           RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(25))),
                    //       backgroundColor: MaterialStateProperty.all(
                    //         Colors.transparent,
                    //       ),
                    //       shadowColor:
                    //           MaterialStateProperty.all(Colors.transparent),
                    //     ),
                    //     onPressed: () async {
                    //       await submit().then((value) {
                    //         if (value == null) {
                    //         } else if (value.isEmpty) {
                    //           Get.offAll(() => const MainScreen());
                    //         } else {
                    //           showMyDialog(context, value);
                    //         }
                    //       });
                    //     },
                    //     // child: Container(
                    //     //   alignment: Alignment.center,
                    //     //   height: double.infinity,
                    //     //   width: double.infinity,
                    //     //   decoration: BoxDecoration(
                    //     //     borderRadius: BorderRadius.circular(20),
                    //     //     gradient: const LinearGradient(
                    //     //       begin: Alignment.centerLeft,
                    //     //       end: Alignment.centerRight,
                    //     //       colors: [
                    //     //         Colors.black87,
                    //     //         Colors.blue
                    //     //         // const Color(0XFFE64B2D).withOpacity(0.9),
                    //     //         // const Color(0XFFF87600).withOpacity(0.9),
                    //     //       ],
                    //     //     ),
                    //     //   ),
                    //     child: Text(
                    //       'LOG IN',
                    //       style: subHeadingStyle,
                    //     ),
                    //   ),
                    // ),
                    Container(
                      constraints: const BoxConstraints(minHeight: 30),
                      height: size.height -
                          (2 * size.height / 55) -
                          (((size.height) / 5)) -
                          425 -
                          (size.height / 12.7 < 50
                              ? 50
                              : size.height / 12.7 > 55
                                  ? 55
                                  : size.height / 12.7) -
                          MediaQuery.of(context).padding.top,
                    ),
                    //45
                    SizedBox(
                      height: 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //const Text('Don\'t have an account?'),
                          TextButton(
                            onPressed: () {
                              Get.to(const SignUpScreen());
                            },
                            child: Text(
                              'Create new Family?',
                              style: subHeadingStyle.copyWith(
                                  color: bluedeep1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
        Obx(() {
          if (loginCotroller.sininIsloading.value) {
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
          if (loginCotroller.sininIsloading.value) {
            return const Center(
                child: CircularProgressIndicator(
                    //  color: bluedeep1,
                    ));
          } else {
            return Container(height: 0);
          }
        }),
      ],
    );
  }
}



// Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: const [
//                           BoxShadow(
//                               color: Colors.grey,
//                               offset: Offset(0, 2),
//                               blurRadius: 2.0)
//                         ],
//                         gradient: LinearGradient(
//                           begin: Alignment.centerLeft,
//                           end: Alignment.centerRight,
//                           colors: [
//                             const Color(0XFFE64B2D).withOpacity(0.9),
//                             const Color(0XFFF87600).withOpacity(0.9),
//                           ],
//                         )),
//                     height: size.height / 16 < 40 ? 40 : size.height / 16,
//                     margin: const EdgeInsets.only(bottom: 25),
//                     child: ElevatedButton(
//                       style: ButtonStyle(
//                         shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20))),
//                         backgroundColor: MaterialStateProperty.all(
//                           Colors.transparent,
//                         ),
//                         shadowColor:
//                             MaterialStateProperty.all(Colors.transparent),
//                       ),
//                       onPressed: () {},
//                       child: Container(
//                         padding: const EdgeInsets.only(bottom: 5),
//                         height: size.height / 16 < 40 ? 40 : size.height / 16,
//                         alignment: Alignment.center,
//                         width: size.width * 0.8,
//                         child: const Text(
//                           'save',
//                           style: TextStyle(
//                             fontSize: 22,
//                             color: Colors.white,
//                             //    backgroundColor: Colors.green,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),