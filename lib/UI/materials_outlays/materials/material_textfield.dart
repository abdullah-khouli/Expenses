import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme.dart';

class MaterialTextField extends StatelessWidget {
  TextEditingController controller;
  FontWeight fontWeight;
  double fontSize;
  final Function(String?)? save;
  final String? Function(String?)? valid;
  MaterialTextField({
    Key? key,
    required this.controller,
    required this.fontWeight,
    required this.fontSize,
    this.save,
    this.valid,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: valid,
        onSaved: save,

        // readOnly: isCompleted.value == 1 ? true : false,
        autofocus: false,
        focusNode: FocusNode(canRequestFocus: false),
        maxLines: null,
        style: TextStyle(
            color: Get.isDarkMode ? Colors.white.withOpacity(0.8) : darkGreyClr,
            fontSize: fontSize,
            fontWeight: fontWeight),
        cursorColor: bluedeep1,
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(width: 0, color: context.theme.backgroundColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(width: 0, color: context.theme.backgroundColor),
          ),
        ));
  }
}
