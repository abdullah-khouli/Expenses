import 'package:e_family_expenses/UI/theme.dart';
import 'package:e_family_expenses/domain/models/outlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import 'edit_outlayType_screen.dart';

class OutlayTypeWidget extends StatelessWidget {
  const OutlayTypeWidget(this.outlayType, {Key? key}) : super(key: key);
  final OutlayType outlayType;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: GetStorage().read(Constants.isHeadFamily) ?? false
          ? () {
              Get.to(EditOutlayTypeScreen(outlayType: outlayType));
            }
          : null,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [bluedeep1.withOpacity(0.9), Colors.blue],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                outlayType.name,
                // overflow: TextOverflow.ellipsis,
                //  maxLines: null,
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                outlayType.desc,
                // overflow: TextOverflow.ellipsis,
                // maxLines: 2,
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[100],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
