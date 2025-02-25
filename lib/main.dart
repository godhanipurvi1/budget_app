import 'package:budget/controller/category_controller.dart';
import 'package:budget/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/home_controller.dart';
import 'controller/spending_controller.dart';

void main() {
  Get.put(SpendingController());
  Get.put(HomeController());
  Get.put(CategoryController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}
