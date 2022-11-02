import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:e_family_expenses/UI/materials_outlays/materials/add_material_screen.dart';
import 'package:e_family_expenses/UI/materials_outlays/materials/material_widget.dart';

import '../../constants.dart';
import '../../theme.dart';
import 'add_outlays_screen.dart';
import 'input_field.dart';
import 'outlay_controller.dart';
import 'outlay_widget.dart';

class OutlaysScreen extends StatefulWidget {
  const OutlaysScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);
  final String userId;
  @override
  State<OutlaysScreen> createState() => _OutlaysScreenState();
}

class _OutlaysScreenState extends State<OutlaysScreen> {
  final OutlayController outlayController = Get.put((OutlayController()));

  final box = GetStorage();

  @override
  void initState() {
    // Future.delayed(Duration.zero, () {
    //   outlayController.getExspensesByUserId(widget.userId).then((value) {
    //     print('then');
    //     if (value.isNotEmpty) {
    //       print('object');
    //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //         content: Text(value),
    //         duration: const Duration(seconds: 2),
    //       ));
    //     }
    //   });
    // });
    Future.delayed(Duration.zero, () {
      submit(outlayController.selectedIsService.value);
    });

    super.initState();
  }

  submit(String myIsService) async {
    if (myIsService != 'All') {
      await outlayController
          .getEspensesByUserIdAndIsService(
              widget.userId, myIsService == 'Service' ? true : false)
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
    } else {
      await outlayController.getExspensesByUserId(widget.userId).then((value) {
        print('then');
        if (value.isNotEmpty) {
          print('object');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value),
            duration: const Duration(seconds: 2),
          ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          //  backgroundColor: offWhite,
          appBar: AppBar(
            actions: [
              // if (GetStorage().read(Constants.isHeadFamily) ?? false)

              if (GetStorage().read(Constants.id) == widget.userId)
                SizedBox(
                  width: 75,
                  height: 50,
                  child: IconButton(
                      onPressed: () {
                        Get.to(() => const AddOutlayScreen());
                      },
                      icon: const Icon(
                        Icons.add,
                        //   color: orangeDeep,
                      )),
                )
            ],
            title: const Text(
              'Outlays',
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
                  //color: orangeDeep,
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                // await outlayController
                //     .getExspensesByUserId(_box.read('id'))
                //     .then((value) {
                //   print('then');
                //   if (value.isNotEmpty) {
                //     print('object');
                //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //       content: Text(value),
                //       duration: const Duration(seconds: 2),
                //     ));
                //   }
                // });
                await submit(outlayController.selectedIsService.value);
              },
              child: ListView(
                padding: const EdgeInsets.all(15),
                children: [
                  const SizedBox(height: 10),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [chooseIsServiceButton1(size)],
                  // ),
                  SizedBox(
                    width: size.width - 30,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //const SizedBox(width: 25),
                        SizedBox(
                          width: 100,
                          // alignment: Alignment.center,
                          child: chooseIsServiceButton1(size),
                        ),
                        //const SizedBox(width: 25),
                        const SizedBox(width: 15),
                        SizedBox(
                          width: (size.width - 145),
                          // alignment: Alignment.centerLeft,
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
                                  print(outlayController.allExpenses.value);
                                  return Text(
                                    outlayController.allExpenses.value
                                        .toStringAsFixed(1)
                                        .toString(),
                                    // //maxLines: 2,

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
                  const SizedBox(height: 15),
                  Obx(() {
                    RxList myList = outlayController.outlays;
                    final selectedValue =
                        outlayController.selectedIsService.value;
                    if (selectedValue != 'All') {
                      if (selectedValue == 'Service') {
                        print('Service');
                        myList = outlayController.outlaysWithService;
                      } else {
                        print('material');
                        myList = outlayController.outlaysWithMaterial;
                      }
                    }
                    return myList.isEmpty
                        ? SizedBox(
                            height: size.height -
                                102 -
                                MediaQuery.of(context).padding.top,
                            child: const Center(
                              child: Text('No Outlays to show'),
                            ),
                          )
                        : Column(
                            children: List.generate(myList.length, (index) {
                              return OutlayWidget(myList[index]);
                            }),
                          );
                  }),
                  const SizedBox(height: 15),
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

  List isServiceList = ['All', 'Service', 'Mateial'];
  chooseIsServiceButton1(Size size) {
    return TextButton.icon(
      onPressed: () {
        Get.bottomSheet(
          Container(
            padding: const EdgeInsets.only(top: 4),
            width: size.width,
            color: offWhite,
            child: SingleChildScrollView(
              child: Column(
                  children: isServiceList
                      .map(
                        (element) => TextButton(
                          onPressed: () async {
                            print(outlayController.selectedIsService.value);
                            print(element);
                            outlayController.selectedIsService.value = element;
                            Get.back();
                            await submit(element);
                            // if (element != 'All') {
                            //   await outlayController
                            //       .getEspensesByUserIdAndIsService(
                            //           widget.userId,
                            //           element == 'Service' ? true : false)
                            //       .then((value) {
                            //     print('then');
                            //     if (value.isNotEmpty) {
                            //       print('object');
                            //       ScaffoldMessenger.of(context)
                            //           .showSnackBar(SnackBar(
                            //         content: Text(value),
                            //         duration: const Duration(seconds: 2),
                            //       ));
                            //     }
                            //   });
                            // } else {
                            //   await outlayController
                            //       .getmonthlyEspensesByUserId(widget.userId,
                            //           outlayController.myDateFormat(), null)
                            //       .then((value) {
                            //     print('then');
                            //     if (value.isNotEmpty) {
                            //       print('object');
                            //       ScaffoldMessenger.of(context)
                            //           .showSnackBar(SnackBar(
                            //         content: Text(value),
                            //         duration: const Duration(seconds: 2),
                            //       ));
                            //     }
                            //   });
                            // }
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
                                    element,
                                    overflow: TextOverflow.ellipsis,
                                    style: outlayController
                                                .selectedIsService.value ==
                                            element
                                        ? subTitleStyle.copyWith(
                                            color: primaryClr,
                                            fontWeight: FontWeight.w500,
                                          )
                                        : subTitleStyle,
                                  ),
                                ),
                                if (outlayController.selectedIsService.value ==
                                    element)
                                  const Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Icon(Icons.done, color: primaryClr),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList()),
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
          outlayController.selectedIsService.value,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: bluedeep1, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
