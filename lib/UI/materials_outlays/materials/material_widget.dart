import 'package:e_family_expenses/UI/materials_outlays/materials/edit_material_screen.dart';
import 'package:e_family_expenses/UI/theme.dart';
import 'package:e_family_expenses/domain/models/outlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';

class MaterialWidget extends StatelessWidget {
  const MaterialWidget(this.material, {Key? key}) : super(key: key);
  final MaterialModel material;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: GetStorage().read(Constants.isHeadFamily) ?? false
          ? () {
              print(material.isService);
              Get.to(EditMaterialScreen(material: material));
            }
          : null,
      child: Container(
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      material.name,
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
                      material.desc,
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
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              //width: 60,
              height: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            const SizedBox(height: 5),
            Text(
              material.isService ? 'Service' : 'Material',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: orangeNew,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
