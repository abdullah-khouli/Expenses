import 'package:e_family_expenses/UI/login/login_button.dart';
import 'package:e_family_expenses/UI/materials_outlays/materials/my_material%20_controller.dart';
import 'package:e_family_expenses/domain/models/outlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../login/login_textfield.dart';
import '../../login/signup_screen.dart';
import '../../theme.dart';

class AddMaterialScreen extends StatefulWidget {
  const AddMaterialScreen({Key? key}) : super(key: key);

  @override
  State<AddMaterialScreen> createState() => _AddMaterialScreenState();
}

class _AddMaterialScreenState extends State<AddMaterialScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _box = GetStorage();

  final MyMaterialController materialCotroller =
      Get.put((MyMaterialController()));

  final Map<String, dynamic> materialData = {
    'name': '',
    'desc': '',
    'isService': false
  };

  Future<String?> submit() async {
    if (!_formKey.currentState!.validate()) {
      return null;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    return await materialCotroller.addMaterial(MaterialModel(
        id: 0,
        userId: _box.read('id'),
        name: materialData['name'],
        desc: materialData['desc'],
        isService: materialData['isService']));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          // backgroundColor: Colors.white,
          appBar: AppBar(
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(0.1),
              child: SizedBox(
                //  padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 0.1,
                child: Divider(
                  color: Colors.grey,
                ),
              ),
            ),
            // centerTitle: true,
            title: const Text(
              'Create material',
              // style: titleStyle,
            ),
            // toolbarHeight: size.height / 16 < 40 ? 40 : size.height / 16,
            // backgroundColor: Colors.white,
            // elevation: 0,
            //   leadingWidth: size.width * 0.3 > 135 ? 135 : size.width * 0.3,
            leading: Container(
              padding: EdgeInsets.only(left: size.width * 0.02),
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  // size: size.height / 40 < 16 ? 16 : size.height / 40,
                  // color: Colors.black,
                ),
              ),
            ),
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width / 25),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 35,
                      child: Text(
                        'Crate New material',
                        style: headingStyle,
                      ),
                    ),
                    SizedBox(
                      height: 18,
                      child: Text(
                        'Please enter info ',
                        style: body2Style,
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 80,
                      child: LoginTextField(
                        save: (name) {
                          materialData['name'] = name!.trim();
                        },
                        valid: (user) {
                          if (user!.trim().isEmpty) {
                            return 'Invalid name';
                          }
                          return null;
                        },
                        hint: 'Name',
                        prefixIcon: Icon(
                          Icons.text_fields,
                          color: bluedeep1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 80,
                      child: LoginTextField(
                        save: (desc) {
                          materialData['desc'] = desc!.trim();
                        },
                        hint: 'description',
                        prefixIcon: Icon(
                          Icons.description,
                          color: bluedeep1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 45,
                      child: Row(
                        children: [
                          Obx(() {
                            return Checkbox(
                              value: materialCotroller.isService.value,
                              onChanged: (newisService) {
                                materialCotroller.changeisServiceStatus();
                                materialData['isService'] =
                                    materialCotroller.isService.value;
                                print(materialCotroller.isService.value);
                              },
                              checkColor: Colors.white,
                              activeColor: bluedeep1,
                            );
                          }),
                          Text(
                            'is Service',
                            style: subTitleStyle,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    LoginButton(
                      fun: () async {
                        await submit().then((value) {
                          if (value == null) {
                          } else if (value.isEmpty) {
                            // Get.snackbar(
                            //     'Create User', 'user created successfully');
                            Get.back();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 2),
                                content: Text(
                                    'The material has been created successfully'),
                              ),
                            );
                          } else {
                            showMyDialog(context, value);
                          }
                        });
                      },
                      name: 'Create',
                    ),
                    // SizedBox(
                    //   width: size.width * 11.5 / 12.5,
                    //   height: size.height / 12.7 < 50 ? 50 : size.height / 12.7,
                    //   child: ElevatedButton(
                    //       style: ButtonStyle(
                    //         backgroundColor:
                    //             MaterialStateProperty.all<Color>(blueDark),
                    //         shape: MaterialStateProperty.all<
                    //             RoundedRectangleBorder>(
                    //           RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(25.0),
                    //           ),
                    //         ),
                    //       ),
                    //       onPressed: () async {
                    //         await submit().then((value) {
                    //           if (value == null) {
                    //           } else if (value.isEmpty) {
                    //             // Get.snackbar(
                    //             //     'Create User', 'user created successfully');
                    //             Get.back();
                    //             ScaffoldMessenger.of(context).showSnackBar(
                    //               const SnackBar(
                    //                 duration: Duration(seconds: 2),
                    //                 content: Text(
                    //                     'The material has been created successfully'),
                    //               ),
                    //             );
                    //           } else {
                    //             showMyDialog(context, value);
                    //           }
                    //         });
                    //       },
                    //       child: Text('Create', style: subHeadingStyle)),
                    // ),
                    const SizedBox(height: 15)
                  ],
                ),
              ),
            ),
          ),
        ),
        Obx(() {
          if (materialCotroller.createMaterialIsLoading.value) {
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
          if (materialCotroller.createMaterialIsLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Container(height: 0);
          }
        }),
      ],
    );
  }
}
