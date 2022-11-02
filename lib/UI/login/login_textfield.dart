import 'package:flutter/material.dart';

import '../theme.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField(
      {Key? key,
      this.save,
      this.valid,
      required this.hint,
      this.hidePass,
      this.controller,
      required this.prefixIcon,
      this.suffixIcon,
      this.textInputType})
      : super(key: key);
  final String hint;
  final TextEditingController? controller;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final Function(String?)? save;
  final String? Function(String?)? valid;
  final bool? hidePass;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: bluedeep1,
      validator: valid,
      onSaved: save,
      controller: controller,
      obscureText: hidePass ?? false,
      keyboardType: textInputType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        //    iconColor: newColor,
        prefixIconColor: bluedeep1,
        //fillColor: newColor,
        //focusColor: newColor,
        //hoverColor: newColor,
        focusColor: bluedeep1,
        suffixIconColor: bluedeep1,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hint,
        hintStyle: subTitleStyle,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 1, color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 2, color: bluedeep1),
        ),
      ),
    );
  }
}
