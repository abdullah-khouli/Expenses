import 'package:e_family_expenses/UI/login/login_button.dart';
import 'package:e_family_expenses/UI/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:e_family_expenses/UI/users/users_controller.dart';

import '../../domain/models/login.dart';
import '../login/login_textfield.dart';
import '../login/signup_screen.dart';
import '../materials_outlays/my_dialog.dart';
import '../theme.dart';

class EditUserScreen extends StatefulWidget {
  final String id;
  final String username;
  final bool istheLoggedUser;

  const EditUserScreen({
    Key? key,
    required this.id,
    required this.istheLoggedUser,
    required this.username,
  }) : super(key: key);

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _box = GetStorage();

  final usersCotroller = Get.put((UsersController()));

  final userController = TextEditingController();

  @override
  void dispose() {
    userController.dispose();
    super.dispose();
  }

  Future<String?> submit() async {
    if (!_formKey.currentState!.validate()) {
      return null;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    print(widget.id);
    return await usersCotroller.editUser(
        LoginModel(id: widget.id, userName: userController.text),
        widget.istheLoggedUser);
  }

  @override
  void initState() {
    userController.text = widget.username;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          // backgroundColor: Colors.white,
          appBar: AppBar(
            /*  bottom: const PreferredSize(
              preferredSize: Size.fromHeight(0.1),
              child: SizedBox(
                //  padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 0.1,
                child: Divider(
                  color: Colors.grey,
                ),
              ),
            ),
            centerTitle: true,
            title: Text('Create User', style: titleStyle),*/
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
                icon: const Icon(
                  Icons.arrow_back_ios,
                  //size: size.height / 40 < 16 ? 16 : size.height / 40,
                  // color: Colors.black,
                ),
              ),
            ),
            actions: [
              //if (widget.isRemovable)
              Container(
                padding: EdgeInsets.only(right: size.width * 0.02),
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () async {
                    myMaterialDialog(context, 'Delete the User?', () async {
                      Get.back();
                      await usersCotroller
                          .deleteUser(widget.id)
                          .then((value) async {
                        if (value.isEmpty) {
                          print(_box.read('id') == widget.id);
                          if (_box.read('id') == widget.id) {
                            await _box.erase();
                            Get.offAll(const LoginScreen());
                          } else {
                            Get.back();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('USer deleted successfully')));
                          }
                        } else {
                          showMyDialog(context, value);
                        }
                      });
                    });
                  },
                  icon: const Icon(
                    Icons.delete,
                    // size: size.height / 40 < 16 ? 16 : size.height / 40,
                    color: test,
                  ),
                ),
              ),
            ],
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width / 25),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 35,
                      child: Text(
                        'Edit User',
                        style: headingStyle,
                      ),
                    ),
                    SizedBox(
                      height: 18,
                      child: Text(
                        'Please enter info ',
                        style: body2Style,
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 80,
                      child: LoginTextField(
                        controller: userController,
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
                    const SizedBox(height: 30),
                    LoginButton(
                        fun: () async {
                          await submit().then((value) {
                            if (value == null) {
                            } else if (value.isEmpty) {
                              print('empty');
                              Get.back();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('User edited successfully')));
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
                    //             print('empty');
                    //             Get.back();
                    //             ScaffoldMessenger.of(context).showSnackBar(
                    //                 const SnackBar(
                    //                     content:
                    //                         Text('User edited successfully')));
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
        ),
        Obx(() {
          if (usersCotroller.editUserIsLoading.value) {
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
          if (usersCotroller.editUserIsLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Container(height: 0);
          }
        }),
      ],
    );
  }
}
