import 'package:e_family_expenses/UI/theme.dart';
import 'package:e_family_expenses/domain/models/outlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import 'edit_outlay_screen.dart';

class OutlayWidget extends StatelessWidget {
  const OutlayWidget(this.outlay, {Key? key}) : super(key: key);
  final Outlay outlay;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: //GetStorage().read(Constants.isHeadFamily) ?? false
          GetStorage().read(Constants.id) == outlay.userId
              ? () {
                  Get.to(EditOutlayScreen(outlay: outlay));
                }
              : null,
      child: Container(
        constraints: BoxConstraints(maxHeight: 125),
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [bluedeep1, Colors.blue],
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            const SizedBox(width: 15),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //maxLines: 2,
                      outlay.material!.name,
                      //   overflow: TextOverflow.ellipsis,
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
                      outlay.outlayType!.name,
                      //overflow: TextOverflow.ellipsis,
                      //maxLines: 2,
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
            Container(
              width: 1,
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              color: offWhite,
            ),
            const SizedBox(width: 5),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      outlay.desc,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 5),
            Container(
              width: 1,
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              color: offWhite,
            ),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${outlay.price} SYP',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
                      outlay.date.split('T')[0],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
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
            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}
