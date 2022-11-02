import 'package:e_family_expenses/UI/main/main_controller.dart';
import 'package:e_family_expenses/UI/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/home_screen.dart';
import '../materials_outlays/materials_outlays_screen.dart';
import '../settings/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainController mainController = Get.put((MainController()));

  final List<BottomNavigationBarItem> itemsList = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    // const BottomNavigationBarItem(
    //     icon: Icon(Icons.summarize), label: 'Reports'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.more), label: 'Material&Outlay'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: 'Settings'),
  ];
  @override
  void dispose() {
    mainController.dispose();
    super.dispose();
  }

  final List<Widget> list = [
    const HomeScreen(),
    // const ReportsScreen(),
    MaterialsOutlaysScreen(),
    const SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 56,
        child: Obx(() {
          return BottomNavigationBar(
            backgroundColor: Colors.white,
            onTap: (newIndex) {
              mainController.changeCurrentIndex(newIndex);
            },
            items: itemsList,
            currentIndex: mainController.currentIndex.value,
            elevation: 5,
            selectedItemColor: bluedeep1,
            type: BottomNavigationBarType.fixed,
          );
        }),
      ),
      body: Obx(() {
        return list[mainController.currentIndex.value];
      }),
    );
  }
}
