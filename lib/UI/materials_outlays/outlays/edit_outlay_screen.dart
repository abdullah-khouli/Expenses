import 'package:e_family_expenses/UI/login/login_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import 'package:e_family_expenses/UI/materials_outlays/materials/my_material%20_controller.dart';
import 'package:e_family_expenses/domain/models/outlay.dart';

import '../../login/signup_screen.dart';
import '../../theme.dart';
import '../my_dialog.dart';
import '../outlayTypes/outlayType_controller.dart';
import 'input_field.dart';
import 'outlay_controller.dart';

class EditOutlayScreen extends StatefulWidget {
  const EditOutlayScreen({
    Key? key,
    required this.outlay,
  }) : super(key: key);
  final Outlay outlay;
  @override
  State<EditOutlayScreen> createState() => _EditOutlayScreenState();
}

class _EditOutlayScreenState extends State<EditOutlayScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _box = GetStorage();

  final OutlayController outlayController = Get.put((OutlayController()));

  final MyMaterialController materialController =
      Get.put((MyMaterialController()));
  final OutlayTypeController outlayTypeCotroller =
      Get.put(OutlayTypeController());
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  // final Map<String, dynamic> outlayData = {
  //   'desc': '',
  //   'price': 0.0,
  // };

  Future<String?> submit() async {
    print(widget.outlay.id);
    if (!_formKey.currentState!.validate()) {
      return null;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    return await outlayController.editExpense(
      {
        'desc': descriptionController.text,
        'price': priceController.text,
        'id': widget.outlay.id
      },
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

  getInitialData() {
    priceController.text = widget.outlay.price.toString();
    descriptionController.text = widget.outlay.desc;
    outlayController.selectedDate.value = DateTime.parse(widget.outlay.date);
    outlayController.selectedMaterial.value = widget.outlay.material!;
    outlayController.selectedOutlayType.value = widget.outlay.outlayType!;
  }

  @override
  void initState() {
    getInitialData();
    print(outlayTypeCotroller.outlayTypes.length);
    outlayTypeCotroller.getOutlayTypesByUserId();
    materialController.getMaterialsById();
    print(outlayTypeCotroller.outlayTypes.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.outlay.id);
    print(widget.outlay.userId);
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          //  backgroundColor: Colors.white,
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
            //centerTitle: true,
            title: const Text(
              'Edit outlay',
              // style: titleStyle,
            ),
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
                icon: const Icon(
                  Icons.arrow_back_ios,
                  // size: size.height / 40 < 16 ? 16 : size.height / 40,
                  // color: orangeDeep,
                ),
              ),
            ),
            actions: [
              Container(
                padding: EdgeInsets.only(right: size.width * 0.02),
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () async {
                    myMaterialDialog(context, 'Delete the Outlay?', () async {
                      Get.back();
                      print(widget.outlay.id);
                      await outlayController
                          .deleteExpense(widget.outlay.id!)
                          .then((value) {
                        if (value.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Outlay deleted successfully')));
                          // Get.snackbar('Delete OutlayType',
                          //     'OutlayType edited successfully');
                          Get.back();
                        } else {
                          showMyDialog(context, value);
                        }
                      });
                    });
                    //to do show dialog to confirm then call delete method or cancel
                  },
                  icon: const Icon(
                    Icons.delete,
                    // size: size.height / 40 < 16 ? 16 : size.height / 40,
                    color: test,
                  ),
                ),
              ),
            ],
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
                            'Edit Your outlay',
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
                            controller: priceController,
                            mykeyboardType: TextInputType.number,
                            save: (name) {
                              priceController.text = name!.trim();
                            },
                            valid: (user) {
                              if (user!.trim().isEmpty) {
                                return 'Enter Price';
                              }
                              return null;
                            },
                            isReadOnly: false,
                            // autofocus: true,
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
                            controller: descriptionController,
                            save: (desc) {
                              descriptionController.text = desc!.trim();
                            },
                            isReadOnly: false,
                            // autofocus: true,
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
                                                            style:
                                                                //  (outlayController
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
                                                        if ((outlayController
                                                                .selectedMaterial
                                                                .value
                                                                .name) ==
                                                            material.name)
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 15.0),
                                                            child: Icon(
                                                                Icons.done,
                                                                color:
                                                                    bluedeep1),
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
                                          'The outlay has been edited successfully'),
                                    ),
                                  );
                                } else {
                                  showMyDialog(context, value);
                                }
                              });
                            },
                            name: 'Save'),
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
                        //                     'The outlay has been edited successfully'),
                        //               ),
                        //             );
                        //           } else {
                        //             showMyDialog(context, value);
                        //           }
                        //         });
                        //       },
                        //       child: Text('Save', style: subHeadingStyle)),
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
          if (outlayController.editOutlayLoading.value ||
              materialController.materialIsLoading.value ||
              outlayTypeCotroller.outlayTypeIsLoading.value) {
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
          if (outlayController.editOutlayLoading.value ||
              materialController.materialIsLoading.value ||
              outlayTypeCotroller.outlayTypeIsLoading.value) {
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
      outlayController.selectedDate.value = pickedDate;
      print(pickedDate);
    } else
      print('');
  }
}
