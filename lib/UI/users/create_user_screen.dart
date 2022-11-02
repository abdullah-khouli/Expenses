import 'package:e_family_expenses/UI/login/login_button.dart';
import 'package:e_family_expenses/UI/users/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../domain/models/login.dart';
import '../login/login_textfield.dart';
import '../login/signup_screen.dart';
import '../random_string.dart';
import '../theme.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({Key? key}) : super(key: key);

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _box = GetStorage();

  final UsersController usersCotroller = Get.put((UsersController()));

  final Map<String, String> _authData = {'user': '', 'password': ''};

  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
  }

  Future<String?> submit() async {
    if (!_formKey.currentState!.validate()) {
      return null;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    print(_box.read('id'));
    return await usersCotroller.createUser(LoginModel(
        id: generateRandomString(10),
        userName: _authData['user']!,
        headFamilyId: _box.read('id'),
        password: _authData['password']!));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          //backgroundColor: Colors.white,
          appBar: AppBar(
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(0.1),
              child: SizedBox(
                //  padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 0.1,
                child: Divider(
                  color: Colors.grey,
                ),
              ),
            ),
            // centerTitle: true,
            title: const Text('Create User'),
            // toolbarHeight: size.height / 16 < 40 ? 40 : size.height / 16,
            // backgroundColor: Colors.white,
            // elevation: 0,
            // leadingWidth: size.width * 0.3 > 135 ? 135 : size.width * 0.3,
            leading: Container(
              padding: EdgeInsets.only(left: size.width * 0.02),
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  //  size: size.height / 40 < 16 ? 16 : size.height / 40,
                  // color: Colors.black,
                ),
              ),
            ),
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width / 25),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 35,
                      child: Text(
                        'Crate New User',
                        style: headingStyle,
                      ),
                    ),
                    SizedBox(
                      height: 18,
                      child: Text(
                        'Please enter info to create new member',
                        style: body2Style,
                      ),
                    ),
                    const SizedBox(height: 30),
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
                    SizedBox(
                      height: 80,
                      child: Obx(() {
                        return LoginTextField(
                          suffixIcon: IconButton(
                            icon: (!usersCotroller.hidePassword.value)
                                ? const Icon(Icons.visibility)
                                : Icon(
                                    Icons.visibility_off,
                                    color: bluedeep1,
                                  ),
                            onPressed: () {
                              usersCotroller.changeHidePasswordStatus();
                            },
                          ),
                          hidePass: usersCotroller.hidePassword.value,
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
                    SizedBox(
                      height: 80,
                      child: Obx(() {
                        return LoginTextField(
                          suffixIcon: IconButton(
                            icon: (!usersCotroller.hidePassword.value)
                                ? const Icon(Icons.visibility)
                                : Icon(
                                    Icons.visibility_off,
                                    color: bluedeep1,
                                  ),
                            onPressed: () {
                              usersCotroller.changeHidePasswordStatus();
                            },
                          ),
                          hidePass: usersCotroller.hidePassword.value,
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

                    LoginButton(
                        fun: () async {
                          await submit().then((value) {
                            if (value == null) {
                            } else if (value.isEmpty) {
                              // Get.snackbar(
                              //     'Create User', 'user created successfully');
                              Get.back();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Duration(seconds: 2),
                                  content: Text(
                                      'The user has been created successfully'),
                                ),
                              );
                            } else {
                              showMyDialog(context, value);
                            }
                          });
                        },
                        name: 'Create'),
                    // SizedBox(
                    //     width: size.width * 11.5 / 12.5,
                    //     height: size.height / 12.7 < 50 ? 50 : size.height / 12.7,
                    //     child: ElevatedButton(
                    //         style: ButtonStyle(
                    //           backgroundColor:
                    //               MaterialStateProperty.all<Color>(blueDark),
                    //           shape: MaterialStateProperty.all<
                    //               RoundedRectangleBorder>(
                    //             RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(25.0),
                    //             ),
                    //           ),
                    //         ),
                    //         onPressed: () async {
                    //           await submit().then((value) {
                    //             if (value == null) {
                    //             } else if (value.isEmpty) {
                    //               // Get.snackbar(
                    //               //     'Create User', 'user created successfully');
                    //               Get.back();
                    //               ScaffoldMessenger.of(context).showSnackBar(
                    //                 const SnackBar(
                    //                   duration: Duration(seconds: 2),
                    //                   content: Text(
                    //                       'The user has been created successfully'),
                    //                 ),
                    //               );
                    //             } else {
                    //               showMyDialog(context, value);
                    //             }
                    //           });
                    //         },
                    //         child: Text('Create', style: subHeadingStyle)),
                    //   ),
                    const SizedBox(height: 15)
                  ],
                ),
              ),
            ),
          ),
        ),
        Obx(() {
          if (usersCotroller.createUserIsLoading.value) {
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
          if (usersCotroller.createUserIsLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Container(height: 0);
          }
        }),
      ],
    );
  }
}
