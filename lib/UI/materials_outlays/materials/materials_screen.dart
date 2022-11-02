import 'package:e_family_expenses/UI/materials_outlays/materials/add_material_screen.dart';
import 'package:e_family_expenses/UI/materials_outlays/materials/material_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../constants.dart';
import '../../theme.dart';
import 'my_material _controller.dart';

class MaterialsScreen extends StatefulWidget {
  const MaterialsScreen({Key? key}) : super(key: key);

  @override
  State<MaterialsScreen> createState() => _MaterialsScreenState();
}

class _MaterialsScreenState extends State<MaterialsScreen> {
  final MyMaterialController materialController =
      Get.put((MyMaterialController()));

  final _box = GetStorage();

  @override
  void initState() {
    materialController.getMaterialsById().then((value) {
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
                        Get.to(() => const AddMaterialScreen());
                      },
                      icon: const Icon(
                        Icons.add,
                        //  color: orangeDeep,
                      )),
                )
            ],
            toolbarHeight: 50,
            backgroundColor: offWhite,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              '  Materials',
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
            child: RefreshIndicator(
              onRefresh: () async {
                await materialController.getMaterialsById().then((value) {
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
              child: Obx(
                () {
                  return materialController.materials.isEmpty
                      ? SizedBox(
                          height: size.height -
                              102 -
                              MediaQuery.of(context).padding.top,
                          child: const Center(
                            child: Text('No Materials to show'),
                          ),
                        )
                      : myGrilList();
                },
              ),
            ),
          ),
        ),
        Obx(() {
          if (materialController.materialIsLoading.value) {
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
          if (materialController.materialIsLoading.value) {
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
      children: List.generate(materialController.materials.length, (index) {
        return MaterialWidget(materialController.materials[index]);
      }),
    );
  }
}
