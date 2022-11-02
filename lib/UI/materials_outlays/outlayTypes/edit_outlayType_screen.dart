import 'package:e_family_expenses/UI/login/login_button.dart';
import 'package:e_family_expenses/UI/materials_outlays/materials/material_textfield.dart';
import 'package:e_family_expenses/UI/materials_outlays/my_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/models/outlay.dart';
import '../../login/signup_screen.dart';
import '../../theme.dart';
import 'outlayType_controller.dart';

class EditOutlayTypeScreen extends StatefulWidget {
  final OutlayType outlayType;

  const EditOutlayTypeScreen({
    Key? key,
    required this.outlayType,
  }) : super(key: key);

  @override
  State<EditOutlayTypeScreen> createState() => _EditOutlayTypeScreenState();
}

class _EditOutlayTypeScreenState extends State<EditOutlayTypeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final outlayTypeCotroller = Get.put((OutlayTypeController()));
  //final outlayTypeCotroller = Get.find<OutlayTypeController>(tag: 't');

  final TextEditingController nameController = TextEditingController();

  final TextEditingController descController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    super.dispose();
  }

  Future<String?> submit() async {
    if (!_formKey.currentState!.validate()) {
      return null;
    }
// FocusScope.of(context).unfocus();
    return await outlayTypeCotroller.editOutlayType(
      OutlayType(
        userId: widget.outlayType.userId,
        id: widget.outlayType.id,
        name: nameController.text,
        desc: descController.text,
      ),
    );
  }

  @override
  void initState() {
    nameController.text = widget.outlayType.name;
    descController.text = widget.outlayType.desc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          // backgroundColor: Colors.white,
          appBar: AppBar(
            // title: const Text(
            //   'Edit OutlayType',
            //   // style: headingStyle,
            // ),
            // bottom: Container,
            /*  bottom: const PreferredSize(
              preferredSize: Size.fromHeight(0.1),
              child: SizedBox(
                //  padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 0.1,
                child: Divider(
                  color: Colors.grey,
                ),
              ),
            ),
            centerTitle: true,
            title: Text('Create User', style: titleStyle),*/
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
                    myMaterialDialog(context, 'Delete the OutlayType?',
                        () async {
                      Get.back();
                      await outlayTypeCotroller
                          .deleteOutlayType(widget.outlayType.id!)
                          .then((value) {
                        if (value.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('OutlayType deleted successfully')));
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
              padding: EdgeInsets.symmetric(horizontal: size.width / 25),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 35,
                      child: Text(
                        'Edit OutlayType',
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
                      //   height: 80,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                            child: Icon(
                              Icons.text_format,
                              size: 25,
                              color: bluedeep1,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: MaterialTextField(
                                valid: (name) =>
                                    name!.isEmpty ? 'Invali name' : null,
                                controller: nameController,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      height: 80,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                            child: Icon(
                              Icons.description,
                              size: 25,
                              color: bluedeep1,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: MaterialTextField(
                                controller: descController,
                                fontWeight: FontWeight.w400,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 75,
                    ),
                    LoginButton(
                        fun: () async {
                          //  FocusScope.of(context).unfocus();
                          await submit().then((value) {
                            if (value == null) {
                            } else if (value.isEmpty) {
                              Get.back();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'OutlayType edited successfully')));
                              // Get.snackbar('Edit OutlayType',
                              //     'OutlayType edited successfully');

                            } else {
                              showMyDialog(context, value);
                            }
                          });
                        },
                        name: 'Save'),
                    // SizedBox(
                    //   width: size.width * 11.5 / 12.5,
                    //   height: size.height / 12.7 < 50 ? 50 : size.height / 12.7,
                    //   child: ElevatedButton(
                    //       style: ButtonStyle(
                    //         backgroundColor:
                    //             MaterialStateProperty.all<Color>(orangeDeep),
                    //         shape: MaterialStateProperty.all<
                    //             RoundedRectangleBorder>(
                    //           RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(25.0),
                    //           ),
                    //         ),
                    //       ),
                    //       onPressed: () async {
                    //         //  FocusScope.of(context).unfocus();
                    //         await submit().then((value) {
                    //           if (value == null) {
                    //           } else if (value.isEmpty) {
                    //             Get.back();
                    //             ScaffoldMessenger.of(context).showSnackBar(
                    //                 const SnackBar(
                    //                     content: Text(
                    //                         'OutlayType edited successfully')));
                    //             // Get.snackbar('Edit OutlayType',
                    //             //     'OutlayType edited successfully');

                    //           } else {
                    //             showMyDialog(context, value);
                    //           }
                    //         });
                    //       },
                    //       child: Text('Save', style: subHeadingStyle)),
                    // ),
                    const SizedBox(height: 15)
                  ],
                ),
              ),
            ),
          ),
        ),
        Obx(() {
          if (outlayTypeCotroller.editOutlayTypeLoading.value) {
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
          if (outlayTypeCotroller.editOutlayTypeLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Container(height: 0);
          }
        }),
      ],
    );
  }
}






 /*Row(
                children: [
                  SizedBox(
                    width: 30,
                    child: Icon(
                      Icons.text_format,
                      size: 25,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child:
                        buildTextField(_titleController, FontWeight.w600, 20),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                    child: Icon(
                      Icons.description,
                      size: 25,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: buildTextField(_noteController, FontWeight.w400, 18),
                  ),
                ],
              ),
              const SizedBox(height: 25),*/
              