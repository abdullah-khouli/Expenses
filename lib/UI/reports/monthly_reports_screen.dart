import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../materials_outlays/outlays/outlay_controller.dart';
import '../materials_outlays/outlays/outlay_widget.dart';
import '../theme.dart';

class MonthlyReportsScreen extends StatefulWidget {
  const MonthlyReportsScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);
  final String userId;
  @override
  State<MonthlyReportsScreen> createState() => _MonthlyReportsScreenState();
}

class _MonthlyReportsScreenState extends State<MonthlyReportsScreen> {
  final outlayController = Get.put((OutlayController()));
  DatePickerController? datePickerController = DatePickerController();

  //List isServiceList = ['All', 'Service', 'Mateial'];

  submit() async {
    await outlayController
        .getmonthlyEspensesByUserId(
            widget.userId, outlayController.myDateFormat(), null)
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
  }

  @override
  void initState() {
    //  to do set the right date
    Future.delayed(Duration.zero, () {
      // outlayController
      //     .getmonthlyEspensesByUserId(
      //         widget.userId, outlayController.myDateFormat(), null)
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
      submit();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          // backgroundColor: offWhite,
          appBar: AppBar(
            // toolbarHeight: 50,
            // backgroundColor: offWhite,
            // elevation: 0,
            // centerTitle: true,
            title: const Text(
              '  Monthly Reports',
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
                // await outlayController
                //     .getmonthlyEspensesByUserId(
                //         widget.userId, outlayController.myDateFormat(), null)
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
                await submit();
              },
              child: ListView(
                padding: const EdgeInsets.all(15),
                children: [
                  // const SizedBox(height: 10),
                  SizedBox(
                    width: size.width - 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 150, child: texButton(size)),
                        const SizedBox(width: 15),
                        SizedBox(
                          width: (size.width - 195),
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
                                width: (size.width - 270),
                                child: Obx(() {
                                  return Text(
                                    outlayController.aMonthExpenses.value
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
                    return outlayController.outlaysMonthly.isEmpty
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
                                outlayController.outlaysMonthly.length,
                                (index) {
                              return OutlayWidget(
                                  outlayController.outlaysMonthly[index]);
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

  texButton(Size size) {
    return Obx(() {
      return TextButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
        onPressed: () => _getDateFromUser(),
        label: const Icon(
          Icons.date_range,
          color: offWhite,
        ),
        icon: Text(
          outlayController.myDateFormat(),
          style: subHeadingStyle,
        ),
      );
    });
  }

  // chooseIsServiceButton1(Size size) {
  //   return TextButton.icon(
  //     onPressed: () {
  //       Get.bottomSheet(
  //         Container(
  //           padding: const EdgeInsets.only(top: 4),
  //           width: size.width,
  //           color: offWhite,
  //           child: SingleChildScrollView(
  //             child: Column(
  //                 children: isServiceList
  //                     .map(
  //                       (element) => TextButton(
  //                         onPressed: () async {
  //                           print(outlayController.selectedIsService.value);
  //                           print(element);
  //                           outlayController.selectedIsService.value = element;
  //                           Get.back();
  //                           if (element != 'All') {
  //                             await outlayController
  //                                 .getEspensesByUserIdAndIsService(
  //                                     widget.userId,
  //                                     element == 'Service' ? true : false)
  //                                 .then((value) {
  //                               print('then');
  //                               if (value.isNotEmpty) {
  //                                 print('object');
  //                                 ScaffoldMessenger.of(context)
  //                                     .showSnackBar(SnackBar(
  //                                   content: Text(value),
  //                                   duration: const Duration(seconds: 2),
  //                                 ));
  //                               }
  //                             });
  //                           } else {
  //                             await outlayController
  //                                 .getmonthlyEspensesByUserId(widget.userId,
  //                                     outlayController.myDateFormat(), null)
  //                                 .then((value) {
  //                               print('then');
  //                               if (value.isNotEmpty) {
  //                                 print('object');
  //                                 ScaffoldMessenger.of(context)
  //                                     .showSnackBar(SnackBar(
  //                                   content: Text(value),
  //                                   duration: const Duration(seconds: 2),
  //                                 ));
  //                               }
  //                             });
  //                           }
  //                         },
  //                         style: ButtonStyle(
  //                           overlayColor: MaterialStateColor.resolveWith(
  //                               (states) => Colors.grey.withOpacity(0.15)),
  //                         ),
  //                         child: Container(
  //                           alignment: Alignment.centerLeft,
  //                           padding: const EdgeInsets.symmetric(
  //                               vertical: 10, horizontal: 20),
  //                           width: double.infinity,
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Expanded(
  //                                 child: Text(
  //                                   element,
  //                                   overflow: TextOverflow.ellipsis,
  //                                   style: outlayController
  //                                               .selectedIsService.value ==
  //                                           element
  //                                       ? subTitleStyle.copyWith(
  //                                           color: primaryClr,
  //                                           fontWeight: FontWeight.w500,
  //                                         )
  //                                       : subTitleStyle,
  //                                 ),
  //                               ),
  //                               if (outlayController.selectedIsService.value ==
  //                                   element)
  //                                 const Padding(
  //                                   padding: EdgeInsets.only(left: 15.0),
  //                                   child: Icon(Icons.done, color: primaryClr),
  //                                 ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     )
  //                     .toList()),
  //           ),
  //         ),
  //       );
  //     },
  //     label: const Icon(
  //       Icons.arrow_drop_down,
  //       color: primaryClr,
  //     ),
  //     icon: Obx(
  //       () => Text(
  //         outlayController.selectedIsService.value,
  //         overflow: TextOverflow.ellipsis,
  //         style: const TextStyle(
  //             color: primaryClr, fontSize: 18, fontWeight: FontWeight.w500),
  //       ),
  //     ),
  //   );
  // }

  _getDateFromUser() async {
    DateTime? pickedDate = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: bluedeep1, // <-- SEE HERE
              //   onPrimary: Colors.redAccent, // <-- SEE HERE
              //onSurface: Colors.blueAccent, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  //  primary: Colors.red, // button text color
                  ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: outlayController.selectedDate.value,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      outlayController.selectedDate.value = pickedDate;
      await submit();
      print(pickedDate);
    }
  }
}
