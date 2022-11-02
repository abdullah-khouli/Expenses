import 'package:date_format/date_format.dart';
import 'package:e_family_expenses/UI/theme.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({required this.name, required this.fun, Key? key})
      : super(key: key);
  final String name;
  final Function() fun;

  @override
  GestureDetector build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: fun,
      child: Container(
        alignment: Alignment.center,
        constraints: const BoxConstraints(maxHeight: 60, maxWidth: 150),
        width: size.width * 0.5,
        height: 60,
        //margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [bluedeep1, Colors.blue],
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          name,
          style: headingStyle.copyWith(color: offWhite, fontSize: 23),
        ),
      ),
    );
  }
}
