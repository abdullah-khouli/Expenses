import 'package:e_family_expenses/UI/reports/family/family_member_reports_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/widget.dart';
import '../../theme.dart';
import '../../users/users_controller.dart';

class FamilyReportsScreen extends StatefulWidget {
  const FamilyReportsScreen({Key? key}) : super(key: key);

  @override
  State<FamilyReportsScreen> createState() => _FamilyReportsScreenState();
}

class _FamilyReportsScreenState extends State<FamilyReportsScreen> {
  final userController = Get.put((UsersController()));

  @override
  void initState() {
    userController.getUsersById().then((value) {
      print('then');
      if (value.isNotEmpty) {
        print('object');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(value),
          duration: const Duration(seconds: 2),
        ));
      }
    }).onError((error, stackTrace) => null);

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
            // actions: [
            //   if (GetStorage().read(Constanst.isHeadFamily) ?? false)
            //     SizedBox(
            //       width: 75,
            //       height: 50,
            //       child: IconButton(
            //           onPressed: () {
            //             Get.to(() => const AddMaterialScreen());
            //           },
            //           icon: const Icon(
            //             Icons.add,
            //             color: orangeDeep,
            //           )),
            //     )
            // ],
            // toolbarHeight: 50,
            // backgroundColor: offWhite,
            // elevation: 0,
            // centerTitle: true,
            title: const Text(
              '  Family Reports',
              // style: TextStyle(
              //   color: blueDark,
              //   fontWeight: FontWeight.w600,
              //   fontSize: 18,
              // ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(2),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 2,
                child: Divider(
                  color: blueDark,
                ),
              ),
            ),
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
                  size: size.height / 40 < 16 ? 16 : size.height / 40,
                  // color: orangeDeep,
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                await userController.getUsersById().then((value) {
                  print('then');
                  if (value.isNotEmpty) {
                    print('object');
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(value),
                      duration: const Duration(seconds: 2),
                    ));
                  }
                }).onError((error, stackTrace) => null);
              },
              child: Obx(() {
                return ListView(
                  padding: const EdgeInsets.all(30),
                  children: userController.users.isEmpty
                      ? [
                          const SizedBox(height: 10),
                          SizedBox(
                            height: size.height -
                                102 -
                                MediaQuery.of(context).padding.top,
                            child: const Center(
                              child: Text('No Family membrs to show'),
                            ),
                          )
                        ]
                      : List.generate(
                          userController.users.length,
                          (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: MyWidget(
                                name: userController.users[index].userName,
                                fun: () {
                                  Get.to(() => FamilyMemberReportsScreen(
                                      user: userController.users[index]));
                                },
                              ),
                            );
                          },
                        ),
                );
              }),
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
