import 'package:e_family_expenses/UI/constants.dart';
import 'package:e_family_expenses/UI/home/widget.dart';
import 'package:e_family_expenses/UI/materials_outlays/materials/materials_screen.dart';
import 'package:e_family_expenses/UI/materials_outlays/outlayTypes/outlayTypes_screen.dart';
import 'package:e_family_expenses/UI/materials_outlays/outlays/outays_screen.dart';
import 'package:e_family_expenses/UI/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'materials/my_material _controller.dart';

class MaterialsOutlaysScreen extends StatelessWidget {
  final myMaterialController = Get.put(MyMaterialController());

  final _box = GetStorage();

  MaterialsOutlaysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: offWhite,
      appBar: AppBar(
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
        centerTitle: true,
        toolbarHeight: 50,
        backgroundColor: offWhite,
        elevation: 0,
        title: const Text(
          '  Materials && Outlays',
          // style: TextStyle(
          //   //color: blueDark,
          //   fontWeight: FontWeight.w600,
          //   fontSize: 18,
          // ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          height: size.height - MediaQuery.of(context).padding.top,
          child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: [
                const SizedBox(height: 25),
                MyWidget(
                  name: 'Materials',
                  fun: () {
                    print('here');
                    Get.to(() => const MaterialsScreen());
                  },
                ),
                const SizedBox(height: 25),
                MyWidget(
                  name: 'Outlays',
                  fun: () {
                    Get.to(() => OutlaysScreen(
                            userId: _box.read(
                          Constants.id,
                        )));
                  },
                ),
                const SizedBox(height: 25),
                MyWidget(
                  name: 'OutlaysType',
                  fun: () {
                    Get.to(() => const OutlayTypesScreen());
                  },
                ),
                const SizedBox(height: 25),
              ]),
        ),
      ),
    );
  }

  // SizedBox material(String name) {
  //   return SizedBox(
  //     height: 150,
  //     child: Card(
  //       elevation: 2,
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //       color: orangeClr,
  //       child: Center(
  //           child: Text(
  //         name,
  //         style: subHeadingStyle.copyWith(color: blueDark),
  //       )),
  //     ),
  //   );
  // }
}
