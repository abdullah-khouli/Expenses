import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../materials_outlays/outlays/outlay_controller.dart';
import '../materials_outlays/outlays/outlay_widget.dart';
import '../theme.dart';

class YearlyReportsScreen extends StatefulWidget {
  const YearlyReportsScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);
  final String userId;
  @override
  State<YearlyReportsScreen> createState() => _YearlyReportsScreenState();
}

class _YearlyReportsScreenState extends State<YearlyReportsScreen> {
  final outlayController = Get.put((OutlayController()));
  final yearList = List.generate(10, (index) => DateTime.now().year - index);

  @override
  void initState() {
    print(outlayController.selectedYear.value);
    Future.delayed(Duration.zero, () {
      outlayController
          .getYearlyEspensesByUserId(
              widget.userId, outlayController.selectedYear.value)
          .then((value) {
        print('then');
        if (value.isNotEmpty) {
          print('object');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value),
            duration: const Duration(seconds: 2),
          ));
        }
      });
    });

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
              '  Yearly Reports',
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
            //  leadingWidth: size.width * 0.3 > 135 ? 135 : size.width * 0.3,
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
                await outlayController
                    .getYearlyEspensesByUserId(
                        widget.userId, outlayController.selectedYear.value)
                    .then((value) {
                  print('then');
                  if (value.isNotEmpty) {
                    print('object');
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(value),
                      duration: const Duration(seconds: 2),
                    ));
                  }
                });
              },
              child: ListView(
                padding: const EdgeInsets.all(15),
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    width: size.width - 30,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          child: chooseYearButton1(size),
                        ),
                        const SizedBox(width: 15),
                        SizedBox(
                          width: (size.width - 145),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 75,
                                child: Text(
                                  'Total: ',
                                  style: headingStyle.copyWith(fontSize: 25),
                                ),
                              ),
                              SizedBox(
                                width: (size.width - 220),
                                child: Obx(() {
                                  return Text(
                                    outlayController.aYearExpenses.value
                                        .toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: bodyStyle.copyWith(fontSize: 20),
                                  );
                                }),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(() {
                    return outlayController.outlaysYearly.isEmpty
                        ? SizedBox(
                            height: size.height -
                                102 -
                                MediaQuery.of(context).padding.top,
                            child: const Center(
                              child: Text('No Reports to show'),
                            ),
                          )
                        : Column(
                            children: List.generate(
                                outlayController.outlaysYearly.length, (index) {
                              return OutlayWidget(
                                  outlayController.outlaysYearly[index]);
                            }),
                          );
                  }),
                ],
              ),
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
    );
  }

  chooseYearButton1(Size size) {
    return TextButton.icon(
      onPressed: () {
        Get.bottomSheet(
          Container(
            padding: const EdgeInsets.only(top: 4),
            width: size.width,
            color: offWhite,
            child: SingleChildScrollView(
              child: Column(
                  children: List.generate(
                10,
                (index) => TextButton(
                  onPressed: () async {
                    outlayController.selectedYear.value = yearList[index];
                    Get.back();
                    await outlayController
                        .getYearlyEspensesByUserId(
                            widget.userId, outlayController.selectedYear.value)
                        .then((value) {
                      print('then');
                      if (value.isNotEmpty) {
                        print('object');
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(value),
                          duration: const Duration(seconds: 2),
                        ));
                      }
                    });
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.grey.withOpacity(0.15)),
                  ),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            (DateTime.now().year - index).toString(),
                            overflow: TextOverflow.ellipsis,
                            style: outlayController.selectedYear.value ==
                                    yearList[index]
                                ? subTitleStyle.copyWith(
                                    color: bluedeep1,
                                    fontWeight: FontWeight.w500,
                                  )
                                : subTitleStyle,
                          ),
                        ),
                        if (outlayController.selectedYear.value ==
                            yearList[index])
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Icon(
                              Icons.done,
                              color: bluedeep1,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              )),
            ),
          ),
        );
      },
      label: Icon(
        Icons.arrow_drop_down,
        color: bluedeep1,
      ),
      icon: Obx(
        () => Text(
          outlayController.selectedYear.value.toString(),
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: bluedeep1),
        ),
      ),
    );
  }
}
