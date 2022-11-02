import 'package:e_family_expenses/UI/materials_outlays/outlays/outays_screen.dart';
import 'package:e_family_expenses/domain/models/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

import '../../home/widget.dart';
import '../../materials_outlays/outlays/outlay_controller.dart';
import '../../theme.dart';
import '../monthly_reports_screen.dart';
import '../yearly_reports_screen.dart';

class FamilyMemberReportsScreen extends StatefulWidget {
  const FamilyMemberReportsScreen({
    Key? key,
    required this.user,
  }) : super(key: key);
  final LoginModel user;
  @override
  State<FamilyMemberReportsScreen> createState() =>
      _FamilyMemberReportsScreenState();
}

class _FamilyMemberReportsScreenState extends State<FamilyMemberReportsScreen> {
  final outlayController = Get.put(OutlayController()
      //, permanent: true
      );

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      outlayController.getExpensesNewValue(widget.user.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        //  backgroundColor: blueoffwhite,
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
          title: Text(
            widget.user.userName,
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
              icon: const Icon(
                Icons.arrow_back_ios,
                //  size: size.height / 40 < 16 ? 16 : size.height / 40,
                //  color: orangeDeep,
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                top: 30,
                right: 30,
              ),
              child: RefreshIndicator(
                onRefresh: () async {
                  await outlayController.getExpensesNewValue(widget.user.id);
                  //to do get the new vale of this and last month and year from the API
                },
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 25),
                    homeWidget(size),
                    const SizedBox(height: 20),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyWidget(
                              name: 'Monthly',
                              fun: () {
                                Get.to(MonthlyReportsScreen(
                                    userId: widget.user.id));
                                print('object');
                              }),
                          MyWidget(
                              name: 'Yearly',
                              fun: () {
                                Get.to(YearlyReportsScreen(
                                    userId: widget.user.id));
                                print('object');
                              }),
                        ]),
                    const SizedBox(height: 20),
                    MyWidget(
                        name: 'All Expenses',
                        fun: () {
                          print(widget.user.id);
                          Get.to(OutlaysScreen(userId: widget.user.id));
                          print('object');
                        }),
                  ],
                ),
              ),
            ),
            Obx(() {
              if (outlayController.outlayIsLoading.value) {
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
              if (outlayController.outlayIsLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Container(height: 0);
              }
            }),
          ],
        ));
  }

  homeWidget(Size size) {
    print(size.width);
    return Container(
      padding: const EdgeInsets.all(20),
      // constraints: const BoxConstraints(
      //     minHeight: 230, maxHeight: 350, minWidth: 150, maxWidth: 350),
      height: 225.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.black87.withOpacity(0.9), Colors.blue],
        ),
      ),
      // height: size.height / 5,
      //width: size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //h=30
          SizedBox(
            height: 30,
            child: Text(
              //formatDate(DateTime.now(), [mm])

              '${DateFormat.MMMM().format(DateTime.now())} : Total Expenses',
              style: subHeadingStyle.copyWith(
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 10),
          //h=60
          Obx(() {
            return SizedBox(
              width: size.width - 100,
              height: 60,
              child:
                  // Text(
                  //   '${outlayController.thisMonthExpenses.value.toInt()} SYP',
                  //   maxLines: 1,
                  //   textAlign: TextAlign.center,
                  //   style: headingStyle.copyWith(color: Colors.white, fontSize: 40),
                  // ),
                  RichText(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.center,
                text: TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent

                  style:
                      headingStyle.copyWith(color: Colors.white, fontSize: 40),
                  children: <TextSpan>[
                    TextSpan(
                        text:
                            '${outlayController.thisMonthExpenses.value.toInt()}'),
                    TextSpan(
                        text: '  SYP',
                        style: headingStyle.copyWith(
                            color: Colors.white, fontSize: 20)),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 10),
          //h=70.5
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 17 * 1.5,
                    child: Text(
                      'Last Month',
                      style: subHeadingStyle.copyWith(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  // const SizedBox(height: 10),
                  Obx(() {
                    return SizedBox(
                      height: 45,
                      width: (size.width - 100) / 2,
                      child:
                          // Text(
                          //   '${outlayController.lastMonthExpenses.toInt()}',
                          //   maxLines: 1,
                          //   textAlign: TextAlign.center,
                          //   style: headingStyle.copyWith(
                          //       color: Colors.white, fontSize: 30),
                          // ),
                          RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent

                          style: headingStyle.copyWith(
                              color: Colors.white, fontSize: 30),
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    '${outlayController.lastMonthExpenses.toInt()}'),
                            TextSpan(
                                text: '  SYP',
                                style: headingStyle.copyWith(
                                    color: Colors.white, fontSize: 15)),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 17 * 1.5,
                    child: Text(
                      'This Year',
                      style: subHeadingStyle.copyWith(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  // const SizedBox(height: 10),
                  Obx(() {
                    return SizedBox(
                      height: 45,
                      width: (size.width - 100) / 2,
                      child:
                          // Text(
                          //   '${outlayController.thisYearExpenses.toInt()}  SYP',
                          //   maxLines: 1,
                          //   textAlign: TextAlign.center,
                          //   style: headingStyle.copyWith(
                          //       color: Colors.white, fontSize: 30),
                          // ),
                          RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent

                          style: headingStyle.copyWith(
                              color: Colors.white, fontSize: 30),
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    '${outlayController.thisYearExpenses.toInt()}'),
                            TextSpan(
                                text: '  SYP',
                                style: headingStyle.copyWith(
                                    color: Colors.white, fontSize: 15)),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
