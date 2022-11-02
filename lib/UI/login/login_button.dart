import 'package:flutter/material.dart';

import '../theme.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.fun,
    required this.name,
  }) : super(key: key);
  final Future Function() fun;
  final String name;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width / 10),
      width: size.width * 11.5 / 12.5,
      height: size.height / 12.7 < 50
          ? 50
          : size.height / 12.7 > 55
              ? 55
              : size.height / 12.7,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.black87, Colors.blue],
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
          onPressed: fun,
          child: Text(name, style: subHeadingStyle.copyWith(fontSize: 18))),
    );
  }
}
