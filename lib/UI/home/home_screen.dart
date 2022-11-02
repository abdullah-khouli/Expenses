import 'package:e_family_expenses/UI/constants.dart';
import 'package:e_family_expenses/UI/materials_outlays/outlays/add_outlays_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../materials_outlays/outlays/outlay_controller.dart';
import '../reports/family/family_reports_screen.dart';
import '../reports/monthly_reports_screen.dart';
import '../reports/yearly_reports_screen.dart';
import '../theme.dart';
import 'widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final outlayController = Get.put(OutlayController()
      //, permanent: true
      );

  final _box = GetStorage();

  @override
  void initState() {
    outlayController.getStoredExpenses();
    outlayController.getExpensesNewValue(_box.read(Constants.id));

    super.initState();
  }

  final _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    print(DateFormat('y-M-d').format(DateTime.now()));

    //print(DateFormat.yMEd().format(DateTime.now()));
    final size = MediaQuery.of(context).size;
    print(size.height);
    print(size.width);
    print('objectobject');
    return SafeArea(
      child: Scaffold(
          backgroundColor: offWhite,
          body: Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  outlayController.getExpensesNewValue(_box.read(Constants.id));
                  //to do get the new vale of this and last month and year from the API
                },
                child: Container(
                  //  color: Colors.green,
                  child: ListView(
                    padding: const EdgeInsets.all(25),
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        //key: _key,
                        // width: size.width,
                        height: ((size.height / 18.3 < 25
                                    ? 25
                                    : size.height / 18.3 > 40
                                        ? 40
                                        : size.height / 18.3) +
                                (size.height / 32 < 15
                                    ? 15
                                    : size.height / 32 > 25
                                        ? 25
                                        : size.height / 32)) *
                            1.5,
                        child: SizedBox(
                          width: size.width - 130,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: size.width - 130,
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // color: Colors.yellow,
                                      child: Text(
                                        'Hello',
                                        style: subTitleStyle.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: size.height / 32 < 15
                                                ? 15
                                                : size.height / 32 > 25
                                                    ? 25
                                                    : size.height / 32,
                                            color: Colors.grey),
                                      ),
                                    ),
                                    Container(
                                      //  key: _key,
                                      //   color: Colors.brown,
                                      width: size.width,
                                      child: Text(
                                        _box
                                            .read(Constants.userName)
                                            .toString()
                                            .toUpperCase(),
                                        style: subTitleStyle.copyWith(
                                            fontSize: size.height / 18.3 < 25
                                                ? 25
                                                : size.height / 18.3 > 40
                                                    ? 40
                                                    : size.height / 18.3),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 30),
                              addIcon(),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      homeWidget(size),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        width: size.width,
                        height: 30,
                        color: blueoffwhite,
                        child: Text(
                          'Reports',
                          style: subTitleStyle.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: size.width - 60,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyWidget(
                                  name: 'Monthly',
                                  fun: () {
                                    Get.to(MonthlyReportsScreen(
                                        userId: _box.read(
                                      Constants.id,
                                    )));
                                    print('object');
                                  }),
                              MyWidget(
                                  name: 'Yearly',
                                  fun: () {
                                    Get.to(YearlyReportsScreen(
                                      userId: _box.read(
                                        Constants.id,
                                      ),
                                    ));
                                    print('object');
                                  }),
                            ]),
                      ),
                      const SizedBox(height: 20),
                      if (GetStorage().read(Constants.isHeadFamily) ?? false)
                        MyWidget(
                            name: 'Family',
                            fun: () {
                              Get.to(const FamilyReportsScreen());
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
          )),
    );
  }

  // homeWidget(Size size) {
  //   print(size.width);
  //   return Container(
  //     padding: const EdgeInsets.all(20),
  //     // constraints: const BoxConstraints(
  //     //     minHeight: 230, maxHeight: 350, minWidth: 150, maxWidth: 350),
  //     height: 225.5,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(20),
  //       gradient: LinearGradient(
  //         begin: Alignment.topLeft,
  //         end: Alignment.bottomRight,
  //         colors: [Colors.black87.withOpacity(0.9), Colors.blue],
  //       ),
  //     ),
  //     // height: size.height / 5,
  //     //width: size.width,
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         //h=30
  //         SizedBox(
  //           height: 30,
  //           child: Text(
  //             //formatDate(DateTime.now(), [mm])

  //             '${DateFormat.MMMM().format(DateTime.now())} : Total Expenses',
  //             style: subHeadingStyle.copyWith(
  //               fontSize: 20,
  //             ),
  //           ),
  //         ),
  //         const SizedBox(height: 10),
  //         //h=60
  //         Obx(() {
  //           return SizedBox(
  //             width: size.width - 100,
  //             height: 60,
  //             child: Text(
  //               '${outlayController.thisMonthExpenses.value.toInt()} SYP',
  //               maxLines: 1,
  //               textAlign: TextAlign.center,
  //               style: headingStyle.copyWith(color: Colors.white, fontSize: 40),
  //             ),
  //           );
  //         }),
  //         const SizedBox(height: 10),
  //         //h=70.5
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             Column(
  //               children: [
  //                 SizedBox(
  //                   height: 17 * 1.5,
  //                   child: Text(
  //                     'Last Month',
  //                     style: subHeadingStyle.copyWith(
  //                       fontSize: 17,
  //                     ),
  //                   ),
  //                 ),
  //                 // const SizedBox(height: 10),
  //                 Obx(() {
  //                   return SizedBox(
  //                     height: 45,
  //                     width: (size.width - 100) / 2,
  //                     child: Text(
  //                       '${outlayController.lastMonthExpenses.toInt()}',
  //                       maxLines: 1,
  //                       textAlign: TextAlign.center,
  //                       style: headingStyle.copyWith(
  //                           color: Colors.white, fontSize: 30),
  //                     ),
  //                   );
  //                 }),
  //               ],
  //             ),
  //             Column(
  //               children: [
  //                 SizedBox(
  //                   height: 17 * 1.5,
  //                   child: Text(
  //                     'This Year',
  //                     style: subHeadingStyle.copyWith(
  //                       fontSize: 17,
  //                     ),
  //                   ),
  //                 ),
  //                 // const SizedBox(height: 10),
  //                 Obx(() {
  //                   return SizedBox(
  //                     height: 45,
  //                     width: (size.width - 100) / 2,
  //                     child: Text(
  //                       '${outlayController.thisYearExpenses.toInt()}  SYP',
  //                       maxLines: 1,
  //                       textAlign: TextAlign.center,
  //                       style: headingStyle.copyWith(
  //                           color: Colors.white, fontSize: 30),
  //                     ),
  //                   );
  //                 }),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

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

  addIcon() {
    return GestureDetector(
      onTap: (() {
        Get.to(const AddOutlayScreen());
      }),
      child: Container(
        key: _key,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          //    color: Colors.blue,
          color: blueoffwhite,
        ),
        height: 50,
        width: 50,
        child: Icon(
          Icons.add,
          size: 40,
          color: bluedeep1,
        ),
      ),
    );
  }
}
