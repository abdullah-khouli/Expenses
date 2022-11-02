import 'package:e_family_expenses/UI/home/widget.dart';
import 'package:e_family_expenses/UI/login/change_password_screen.dart';
import 'package:e_family_expenses/UI/login/login_button.dart';
import 'package:e_family_expenses/UI/theme.dart';
import 'package:e_family_expenses/UI/users/create_user_screen.dart';
import 'package:e_family_expenses/UI/users/edit_user_screen.dart';
import 'package:e_family_expenses/UI/users/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants.dart';
import '../login/login_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final userController = Get.put(UsersController());

  final loginController = Get.put(LoginController());
  final _box = GetStorage();

  @override
  void dispose() {
    print('dispose');
    // userController.dispose();
    //loginController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    userController.userName.value = _box.read(Constants.userName);
    if (_box.read(Constants.isHeadFamily) ?? false) {
      userController.getUsersById().then((value) {
        if (value.isNotEmpty) {
          print('object');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value),
            duration: const Duration(seconds: 2),
          ));
        }
      }).onError((error, stackTrace) => null);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: offWhite,
          appBar: AppBar(
            // toolbarHeight: 50,
            // backgroundColor: offWhite,
            // elevation: 0,
            title: const Text(
              '  Settings',
              // style: TextStyle(
              //   color: Colors.black,
              //   fontWeight: FontWeight.w600,
              //   fontSize: 18,
              // ),
            ),
            //centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(2),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 2,
                child: const Divider(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: _box.read(Constants.isHeadFamily)
                  ? () async {
                      await userController.getUsersById().then((value) {
                        if (value.isNotEmpty) {
                          print('object');
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(value),
                            duration: const Duration(seconds: 2),
                          ));
                        }
                      }).onError((error, stackTrace) => null);
                    }
                  : () async {},
              child: ListView(
                padding: const EdgeInsets.all(15),
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 100,
                    child: Image.asset('assets/images/logo1.jpg'),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    width: size.width,
                    height: 30,
                    color: blueoffwhite,
                    child: Text(
                      'My User',
                      style: subHeadingStyle.copyWith(color: Colors.black),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        alignment: Alignment.centerLeft,
                        height: 60,
                        child: Row(
                          children: [
                            const Icon(Icons.person),
                            const SizedBox(width: 7),
                            Obx(() {
                              return Text(
                                //GetStorage().read(Constants.userName) ?? '',
                                userController.userName.value,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              );
                            }),
                            const Spacer(),
                            //   if (_box.read(Constants.isHeadFamily))
                            IconButton(
                              onPressed: () {
                                Get.to(() => EditUserScreen(
                                      id: GetStorage().read(Constants.id),
                                      username:
                                          GetStorage().read(Constants.userName),
                                      istheLoggedUser: true,
                                      // isRemovable: !GetStorage()
                                      //     .read(Constanst.isHeadFamily),
                                    ));
                              },
                              icon: const Icon(
                                Icons.edit,
                                //color: orangeNew,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        alignment: Alignment.centerLeft,
                        height: 60,
                        child: Row(
                          children: [
                            const Icon(Icons.password),
                            const SizedBox(width: 7),
                            const Text(
                              'change Password',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  Get.to(const ChangePasswordScreen());
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  // color: orangeDeep,
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                  if (_box.read(Constants.isHeadFamily) ?? false)
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      width: size.width,
                      height: 30,
                      color: blueoffwhite,
                      child: Text(
                        'Family Members',
                        style: subHeadingStyle.copyWith(color: Colors.black),
                      ),
                    ),
                  if (_box.read(Constants.isHeadFamily) ?? false)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        Obx(() {
                          return Column(
                            children: List.generate(userController.users.length,
                                (index) {
                              return userView(
                                  userController.users[index].userName,
                                  userController.users[index].id);
                            }),
                          );
                        }),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          alignment: Alignment.centerLeft,
                          height: 60,
                          child: Row(
                            children: [
                              const Icon(Icons.person),
                              const SizedBox(width: 7),
                              const Text(
                                'Create new member',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    Get.to(const CreateUserScreen());
                                  },
                                  icon: const Icon(
                                    Icons.add_box,
                                    //color: orangeDeep,
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  Container(
                    width: size.width,
                    height: 25,
                    color: blueoffwhite,
                  ),
                  const SizedBox(height: 25),

                  LoginButton(
                      fun: () async {
                        await loginController.logout();
                      },
                      name: 'Log Out'),

                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: size.width / 6),
                  //   width: size.width / 2,
                  //   child: MyWidget(
                  //       name: 'Log Out',
                  //       fun: () async {
                  //         await loginController.logout();
                  //       }),
                  // ),
                  // InkWell(
                  //   splashColor: const Color(0xFFECEEF1),
                  //   onTap: () async {
                  //     await loginController.logout();
                  //   },
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       gradient: LinearGradient(
                  //         begin: Alignment.centerLeft,
                  //         end: Alignment.centerRight,
                  //         colors: [bluedeep1, Colors.blue],
                  //       ),
                  //       borderRadius: BorderRadius.circular(25),
                  //     ),
                  //     padding: const EdgeInsets.symmetric(horizontal: 15),
                  //     height: 60,
                  //     alignment: Alignment.center,
                  //     child: const Text(
                  //       'Log Out',
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 20,
                  //           color: offWhite),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
        Obx(() {
          if (userController.settingsIsLoading.value) {
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
          if (userController.settingsIsLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Container(height: 0);
          }
        }),
      ],
    );
  }
}

Container userView(String userName, String id) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    alignment: Alignment.centerLeft,
    height: 60,
    child: Row(
      children: [
        const Icon(Icons.person),
        const SizedBox(width: 7),
        Text(
          userName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        IconButton(
            onPressed: () {
              Get.to(EditUserScreen(
                id: id,
                username: userName,
                istheLoggedUser: false,
                //     true, //to do here i have to give true if the user is not a head family
              ));
            },
            icon: const Icon(
              Icons.edit,
              // color: orangeDeep,
            )),
      ],
    ),
  );
}
