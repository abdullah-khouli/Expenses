import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme.dart';
import 'login_button.dart';
import 'login_controller.dart';
import 'login_textfield.dart';
import 'signup_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final LoginController loginCotroller = Get.put((LoginController()));
  final Map<String, String> passwords = {'old': '', 'new': ''};

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
    return await loginCotroller.changePassword(
        oldPass: passwords['old']!, newPass: passwords['new']!);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.white,
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
        title: Text(
          'Change Password',
          // style: titleStyle,
        ),
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
            icon: Icon(
              Icons.arrow_back_ios,
              // size: size.height / 40 < 16 ? 16 : size.height / 40,
              // color: Colors.black,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Form(
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
                        'Change Your Password',
                        style: headingStyle,
                      ),
                    ),
                    SizedBox(
                      height: 18,
                      child: Text(
                        'Please enter your new password',
                        style: body2Style,
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 80,
                      child: LoginTextField(
                        save: (oldpassword) {
                          passwords['old'] = oldpassword!.trim();
                        },
                        hint: 'Old Password',
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
                            icon: (!loginCotroller.hidePassword.value)
                                ? const Icon(Icons.visibility)
                                : Icon(Icons.visibility_off, color: bluedeep1),
                            onPressed: () {
                              loginCotroller.changeHidePasswordStatus();
                            },
                          ),
                          hidePass: loginCotroller.hidePassword.value,
                          save: (newPassword) {
                            passwords['new'] = newPassword!.trim();
                          },
                          valid: (password) {
                            if (password!.trim().isEmpty ||
                                password.trim().length < 5) {
                              return 'password must be at least 5 characters';
                            }
                            return null;
                          },
                          hint: 'New Password',
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
                            icon: (!loginCotroller.hidePassword.value)
                                ? const Icon(Icons.visibility)
                                : Icon(Icons.visibility_off, color: bluedeep1),
                            onPressed: () {
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
                          hint: 'Confirm New Password',
                          prefixIcon:
                              Icon(Icons.key_outlined, color: bluedeep1),
                        );
                      }),
                    ),
                    const SizedBox(height: 30),
                    LoginButton(
                        fun: () async {
                          await submit().then((value) {
                            if (value == null) {
                            } else if (value.isEmpty) {
                              Get.back();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Duration(seconds: 2),
                                  content: Text(
                                      'Password has been chganged successfully'),
                                ),
                              );
                            } else {
                              showMyDialog(context, value);
                            }
                          });
                        },
                        name: 'Save'),
                    // SizedBox(
                    //   width: size.width * 11.5 / 12.5,
                    //   height: size.height / 12.7 < 50 ? 50 : size.height / 12.7,
                    //   child: ElevatedButton(
                    //       style: ButtonStyle(
                    //         backgroundColor:
                    //             MaterialStateProperty.all<Color>(blueDark),
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
                    //             Get.back();
                    //             ScaffoldMessenger.of(context).showSnackBar(
                    //               const SnackBar(
                    //                 duration: Duration(seconds: 2),
                    //                 content: Text(
                    //                     'Password has been chganged successfully'),
                    //               ),
                    //             );
                    //           } else {
                    //             showMyDialog(context, value);
                    //           }
                    //         });
                    //       },
                    //       child: Text('Save', style: subHeadingStyle)),
                    // ),

                    const SizedBox(height: 15)
                  ],
                ),
              ),
            ),
          ),
          Obx(() {
            if (loginCotroller.changePassIsloading.value) {
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
            if (loginCotroller.changePassIsloading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Container(height: 0);
            }
          }),
        ],
      ),
    );
  }
}
