import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../constants.dart';
import '../../theme.dart';
import 'add_outlayType_screen.dart';
import 'outlayType_controller.dart';
import 'outlayType_widget.dart';

class OutlayTypesScreen extends StatefulWidget {
  const OutlayTypesScreen({Key? key}) : super(key: key);

  @override
  State<OutlayTypesScreen> createState() => _OutlayTypesScreenState();
}

class _OutlayTypesScreenState extends State<OutlayTypesScreen> {
  final OutlayTypeController outlayTypeController =
      Get.put(OutlayTypeController()
          // tag: 'OutlayTypeController',
          // permanent: true
          );

  @override
  void initState() {
    outlayTypeController.getOutlayTypesByUserId().then((value) {
      print('then');
      if (value.isNotEmpty) {
        print('object');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(value),
          duration: const Duration(seconds: 2),
        ));
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('objectjkjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj');
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: offWhite,
          appBar: AppBar(
            actions: [
              if (GetStorage().read(Constants.isHeadFamily) ?? false)
                SizedBox(
                  width: 75,
                  height: 50,
                  child: IconButton(
                      onPressed: () {
                        Get.to(() => const AddOutlayTypeScreen());
                      },
                      icon: const Icon(
                        Icons.add,
                        //  color: orangeDeep,
                      )),
                )
            ],
            title: const Text(
              '  OutlayTypes',
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
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: RefreshIndicator(onRefresh: () async {
              await outlayTypeController.getOutlayTypesByUserId().then((value) {
                print('then');
                if (value.isNotEmpty) {
                  print('object');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(value),
                    duration: const Duration(seconds: 2),
                  ));
                }
              });
            }, child: Obx(
              () {
                return outlayTypeController.outlayTypes.isEmpty
                    ? SizedBox(
                        height: size.height -
                            102 -
                            MediaQuery.of(context).padding.top,
                        child: const Center(
                          child: Text('No Outlay Types to show'),
                        ),
                      )
                    : myGrilList();
              },
            )),
          ),
        ),
        Obx(() {
          if (outlayTypeController.outlayTypeIsLoading.value) {
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
          if (outlayTypeController.outlayTypeIsLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Container(height: 0);
          }
        }),
      ],
    );
  }

  myGrilList() {
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this would produce 2 rows.
      crossAxisCount: 2, crossAxisSpacing: 15,
      mainAxisSpacing: 15, childAspectRatio: 1.3,
      // Generate 100 Widgets that display their index in the List
      children: List.generate(outlayTypeController.outlayTypes.length, (index) {
        return OutlayTypeWidget(outlayTypeController.outlayTypes[index]);
      }),
    );
  }
}
//  ListView(
//                 padding: const EdgeInsets.all(15),
//                 children: [
//                   const SizedBox(height: 10),
//                   Obx(() {
//                     return outlayTypeController.outlayTypes.isEmpty
//                         ? SizedBox(
//                             height: size.height -
//                                 102 -
//                                 MediaQuery.of(context).padding.top,
//                             child: const Center(
//                               child: Text('No Outlay Types to show'),
//                             ),
//                           )
//                         : Column(
//                             children: List.generate(
//                                 outlayTypeController.outlayTypes.length,
//                                 (index) {
//                               return OutlayTypeWidget(
//                                   outlayTypeController.outlayTypes[index]);
//                             }),
//                           );
//                   }),
//                 ],
//               ),