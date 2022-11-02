//d
import 'package:flutter/material.dart';

import '../../theme.dart';

class InputField extends StatelessWidget {
  InputField({
    Key? key,
    this.save,
    this.mykeyboardType,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
    required this.isReadOnly,
    this.autofocus,
    this.valid,
  }) : super(key: key);
  void Function(String?)? save;
  String? Function(String?)? valid;
  final bool? autofocus;
  final TextInputType? mykeyboardType;
  final bool isReadOnly;
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: titleStyle,
              ),
              const SizedBox(
                width: 5,
              ),
              // if (widget == null)
              //   Text('Required'.tr,
              //       style:
              //           titleStyle.copyWith(color: Colors.red.withOpacity(0.9)))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            keyboardType: mykeyboardType,
            validator: valid,
            onSaved: save,
            focusNode: FocusNode(canRequestFocus: false),
            // textAlign: Get.locale.toString() == 'ar'
            //     ? TextAlign.right
            //     : TextAlign.left,
            maxLines: null,
            controller: controller,
            style: subTitleStyle,
            // autofocus: autofocus ?? false,
            readOnly: isReadOnly,
            cursorColor: bluedeep1,
//Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              suffixIcon: widget,
              hintText: hint,
              hintStyle: subTitleStyle,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 1, color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(width: 1, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
