import 'package:e_family_expenses/UI/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void myMaterialDialog(
    BuildContext context, String message, Future Function() confirm) {
  var alertDialog = AlertDialog(
    title: Text(
      'Delete',
      style: subHeadingStyle.copyWith(fontSize: 25, color: test),
    ),
    content: Text(
      message,
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () => Get.back(),
        child: Text(
          'Cancel',
          style: body2Style.copyWith(color: Colors.black, fontSize: 16),
        ),
      ),
      TextButton(
        onPressed: confirm,
        child: Text(
          'Confirm',
          style: body2Style.copyWith(color: Colors.black, fontSize: 16),
        ),
      ),
    ],
  );
  showDialog(context: context, builder: (ctx) => alertDialog);
}
