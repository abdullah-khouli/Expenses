import 'package:e_family_expenses/UI/login/login_button.dart';
import 'package:e_family_expenses/UI/materials_outlays/materials/add_material_screen.dart';
import 'package:e_family_expenses/UI/materials_outlays/materials/my_material%20_controller.dart';
import 'package:e_family_expenses/UI/materials_outlays/outlayTypes/add_outlayType_screen.dart';
import 'package:e_family_expenses/domain/models/outlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../login/signup_screen.dart';
import '../../theme.dart';
import '../outlayTypes/outlayType_controller.dart';
import 'input_field.dart';
import 'outlay_controller.dart';

class AddOutlayScreen extends StatefulWidget {
  const AddOutlayScreen({Key? key}) : super(key: key);

  @override
  State<AddOutlayScreen> createState() => _AddOutlayScreenState();
}

class _AddOutlayScreenState extends State<AddOutlayScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _box = GetStorage();

  final OutlayController outlayController = Get.put((OutlayController()));

  final MyMaterialController materialController =
      Get.put((MyMaterialController()));
  final OutlayTypeController outlayTypeCotroller =
      Get.put(OutlayTypeController());

  final Map<String, dynamic> outlayData = {
    'desc': '',
    'price': 0.0,
  };

  Future<String?> submit() async {
    if (!_formKey.currentState!.validate()) {
      return null;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    return await outlayController.addExpense(
      outlayData,
      // Outlay(
      //   price: outlayData['price'],
      //   desc: outlayData['desc'],
      //   userId: _box.read('id'),
      //   date: outlayController.myDateFormat(),
      //   materialId: outlayData['materialId'],
      //   outlayTypeId: outlayData['outlayTypeId'],
      // ),
    );
  }

  @override
  void initState() {
    outlayController.selectedMaterial.value = MaterialModel(
        userId: 'userId', name: 'None', desc: 'desc', isService: true);
    outlayController.selectedOutlayType.value =
        OutlayType(userId: 'userId', name: 'None', desc: 'desc');

    outlayController.selectedDate.value = DateTime.now();
    print(outlayController.selectedDate.value.toString());
    print(outlayController.selectedMaterial.value.name);
    print(outlayController.selectedOutlayType.value.name);
    print(outlayTypeCotroller.outlayTypes.length);
    outlayTypeCotroller.getOutlayTypesByUserId();
    materialController.getMaterialsById();
    print(outlayTypeCotroller.outlayTypes.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          //backgroundColor: Colors.white,
          appBar: AppBar(
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(0.1),
              child: SizedBox(
                height: 0.1,
                child: Divider(
                  color: Colors.grey,
                ),
              ),
            ),
            // centerTitle: true,
            // title: Text('Create outlay', style: titleStyle),
            // toolbarHeight: size.height / 16 < 40 ? 40 : size.height / 16,
            // backgroundColor: Colors.white,
            // elevation: 0,
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
                  // size: size.height / 40 < 16 ? 16 : size.height / 40,
                  // color: orangeDeep,
                ),
              ),
            ),
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width / 20),
              child: RefreshIndicator(
                onRefresh: () async {
                  print(outlayTypeCotroller.outlayTypes.length);
                  await outlayTypeCotroller.getOutlayTypesByUserId();
                  print(outlayTypeCotroller.outlayTypes.length);
                  await materialController.getMaterialsById();
                },
                child: ListView(
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 35,
                          child: Text(
                            'Crate New outlay',
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
                        Hero(
                          tag: 'price',
                          child: InputField(
                            mykeyboardType: TextInputType.number,
                            save: (name) {
                              outlayData['price'] = name!.trim();
                            },
                            valid: (user) {
                              if (user!.trim().isEmpty) {
                                return 'Enter Price';
                              }
                              return null;
                            },
                            isReadOnly: false,
                            autofocus: true,
                            title: 'Price',
                            hint: 'Enter Price Here',
                            widget: Icon(
                              Icons.text_fields,
                              color: bluedeep1,
                            ),
                          ),
                        ),
                        Hero(
                          tag: 'Description',
                          child: InputField(
                            save: (desc) {
                              outlayData['desc'] = desc!.trim();
                            },
                            isReadOnly: false,
                            autofocus: true,
                            title: 'Description',
                            hint: 'Enter Description Here',
                            widget: Icon(
                              Icons.description,
                              color: bluedeep1,
                            ),
                          ),
                        ),
                        Hero(
                          tag: 'Date',
                          child: Obx(() {
                            return InputField(
                              isReadOnly: true,
                              title: 'Date',
                              hint: DateFormat.yMd()
                                  .format(outlayController.selectedDate.value),
                              widget: IconButton(
                                onPressed: () => _getDateFromUser(),
                                icon: Icon(
                                  Icons.date_range,
                                  color: bluedeep1,
                                ),
                              ),
                            );
                          }),
                        ),
                        Hero(
                          tag: 'Outlay Type',
                          child: Obx(() {
                            return InputField(
                              valid: (outlayType) {
                                print('lllllllllllllllllllllllllllllllll');
                                print(outlayType);
                                if (outlayController
                                        .selectedOutlayType.value.name ==
                                    'None') {
                                  return 'Choose Outlay Type';
                                }
                                return null;
                              },
                              isReadOnly: true,
                              title: 'Outlay Type',
                              hint: outlayController
                                  .selectedOutlayType.value.name,
                              widget: SizedBox(
                                width: 50,
                                child: IconButton(
                                  onPressed: () {
                                    print('object');
                                    print(
                                        outlayTypeCotroller.outlayTypes.length);
                                    Get.bottomSheet(
                                      Container(
                                        padding: const EdgeInsets.only(top: 4),
                                        width: size.width,
                                        color: Get.isDarkMode
                                            ? darkGreyClr
                                            : Colors.white,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              for (OutlayType outlayType
                                                  in outlayTypeCotroller
                                                      .outlayTypes)
                                                TextButton(
                                                  onPressed: () {
                                                    outlayController
                                                        .selectedOutlayType
                                                        .value = outlayType;
                                                    Get.back();
                                                  },
                                                  style: ButtonStyle(
                                                    overlayColor:
                                                        MaterialStateColor
                                                            .resolveWith(
                                                                (states) => Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.15)),
                                                  ),
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10,
                                                        horizontal: 20),
                                                    width: double.infinity,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            outlayType.name,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: (outlayController
                                                                        .selectedOutlayType
                                                                        .value
                                                                        .name) ==
                                                                    outlayType
                                                                        .name
                                                                ? subTitleStyle
                                                                    .copyWith(
                                                                    color:
                                                                        primaryClr,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  )
                                                                : subTitleStyle,
                                                          ),
                                                        ),
                                                        if ((outlayController
                                                                .selectedOutlayType
                                                                .value
                                                                .name) ==
                                                            outlayType.name)
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 15.0),
                                                            child: Icon(
                                                                Icons.done,
                                                                color:
                                                                    primaryClr),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              TextButton(
                                                onPressed: () {
                                                  Get.to(
                                                      const AddOutlayTypeScreen());
                                                },
                                                style: ButtonStyle(
                                                  overlayColor:
                                                      MaterialStateColor
                                                          .resolveWith(
                                                              (states) => Colors
                                                                  .grey
                                                                  .withOpacity(
                                                                      0.15)),
                                                ),
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10,
                                                      horizontal: 20),
                                                  width: double.infinity,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          'Create new Outlay Type',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              // (outlayController
                                                              //             .selectedOutlayType
                                                              //             .value
                                                              //             .name) ==
                                                              //         outlayType
                                                              //             .name
                                                              //     ? subTitleStyle
                                                              //         .copyWith(
                                                              //         color:
                                                              //             primaryClr,
                                                              //         fontWeight:
                                                              //             FontWeight
                                                              //                 .w500,
                                                              //       )
                                                              //     :
                                                              subTitleStyle,
                                                        ),
                                                      ),
                                                      // if ((outlayController
                                                      //         .selectedOutlayType
                                                      //         .value
                                                      //         .name) ==
                                                      //     outlayType.name)
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 15.0),
                                                        child: Icon(Icons.add,
                                                            color: primaryClr),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: bluedeep1,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        Hero(
                          tag: 'Material',
                          child: Obx(() {
                            return InputField(
                              valid: (material) {
                                print('lllllllllllllllllllllllllllllllll');
                                print(material);
                                if (outlayController
                                        .selectedMaterial.value.name ==
                                    'None') {
                                  return 'Choose Material';
                                }
                                return null;
                              },
                              isReadOnly: true,
                              title: 'Material',
                              hint:
                                  outlayController.selectedMaterial.value.name,
                              widget: SizedBox(
                                width: 50,
                                child: IconButton(
                                  onPressed: () {
                                    print('Material');
                                    print(materialController.materials.length);
                                    Get.bottomSheet(
                                      Container(
                                        padding: const EdgeInsets.only(top: 4),
                                        width: size.width,
                                        color: Get.isDarkMode
                                            ? darkGreyClr
                                            : Colors.white,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              for (MaterialModel material
                                                  in materialController
                                                      .materials)
                                                TextButton(
                                                  onPressed: () {
                                                    outlayController
                                                        .selectedMaterial
                                                        .value = material;
                                                    Get.back();
                                                  },
                                                  style: ButtonStyle(
                                                    overlayColor:
                                                        MaterialStateColor
                                                            .resolveWith(
                                                                (states) => Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.15)),
                                                  ),
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10,
                                                        horizontal: 20),
                                                    width: double.infinity,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            material.name,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: (outlayController
                                                                        .selectedOutlayType
                                                                        .value
                                                                        .name) ==
                                                                    material
                                                                        .name
                                                                ? subTitleStyle
                                                                    .copyWith(
                                                                    color:
                                                                        primaryClr,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  )
                                                                : subTitleStyle,
                                                          ),
                                                        ),
                                                        if ((outlayController
                                                                .selectedMaterial
                                                                .value
                                                                .name) ==
                                                            material.name)
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 15.0),
                                                            child: Icon(
                                                                Icons.done,
                                                                color:
                                                                    primaryClr),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              TextButton(
                                                onPressed: () {
                                                  // outlayController
                                                  //     .selectedMaterial
                                                  //     .value = material;
                                                  Get.to(
                                                      const AddMaterialScreen());
                                                },
                                                style: ButtonStyle(
                                                  overlayColor:
                                                      MaterialStateColor
                                                          .resolveWith(
                                                              (states) => Colors
                                                                  .grey
                                                                  .withOpacity(
                                                                      0.15)),
                                                ),
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10,
                                                      horizontal: 20),
                                                  width: double.infinity,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          'Create new Material',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              // (outlayController
                                                              //             .selectedOutlayType
                                                              //             .value
                                                              //             .name) ==
                                                              //         material
                                                              //             .name
                                                              //     ? subTitleStyle
                                                              //         .copyWith(
                                                              //         color:
                                                              //             primaryClr,
                                                              //         fontWeight:
                                                              //             FontWeight
                                                              //                 .w500,
                                                              //       )
                                                              //     :
                                                              subTitleStyle,
                                                        ),
                                                      ),
                                                      // if ((outlayController
                                                      //         .selectedMaterial
                                                      //         .value
                                                      //         .name) ==
                                                      //     material.name)
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 15.0),
                                                        child: Icon(Icons.add,
                                                            color: primaryClr),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: bluedeep1,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 50),
                        LoginButton(
                            fun: () async {
                              await submit().then((value) {
                                if (value == null) {
                                } else if (value.isEmpty) {
                                  Get.back();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      duration: Duration(seconds: 2),
                                      content: Text(
                                          'The outlayType has been created successfully'),
                                    ),
                                  );
                                } else {
                                  showMyDialog(context, value);
                                }
                              });
                            },
                            name: 'Create'),
                        // SizedBox(
                        //   width: size.width * 11.5 / 12.5,
                        //   height:
                        //       size.height / 12.7 < 50 ? 50 : size.height / 12.7,
                        //   child: ElevatedButton(
                        //       style: ButtonStyle(
                        //         backgroundColor:
                        //             MaterialStateProperty.all<Color>(
                        //                 orangeDeep),
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
                        //             Get.back();
                        //             ScaffoldMessenger.of(context).showSnackBar(
                        //               const SnackBar(
                        //                 duration: Duration(seconds: 2),
                        //                 content: Text(
                        //                     'The outlayType has been created successfully'),
                        //               ),
                        //             );
                        //           } else {
                        //             showMyDialog(context, value);
                        //           }
                        //         });
                        //       },
                        //       child: Text('Create', style: subHeadingStyle)),
                        // ),
                        const SizedBox(height: 15),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Obx(() {
          if (outlayTypeCotroller.outlayTypeIsLoading.value ||
              materialController.materialIsLoading.value ||
              outlayController.createOutlayIsLoading.value) {
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
          if (outlayTypeCotroller.outlayTypeIsLoading.value ||
              materialController.materialIsLoading.value ||
              outlayController.createOutlayIsLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Container(height: 0);
          }
        }),
      ],
    );
  }

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
      print(outlayController.selectedDate);
      outlayController.selectedDate.value = pickedDate;
      print('object');
      print('pickedDate$pickedDate');
      print(outlayController.selectedDate.value);
    } else
      print('');
  }
}
