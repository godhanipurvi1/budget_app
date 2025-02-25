// import 'package:budget/helper/database_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../model/spending_model.dart';
//
// class SpendingController extends GetxController {
//   String? mode;
//   DateTime? dateTime;
//
//   int? spendingIndex;
//   int categoryId = 0;
//
//   void getSpendingMode(String? value) {
//     mode = value;
//
//     update();
//   }
//
//   void getSpendingDate({required DateTime date}) {
//     dateTime = date;
//
//     update();
//   }
//
//   void getSpendingIndex({required int index, required int id}) {
//     spendingIndex = index;
//     categoryId = id;
//     update();
//   }
//
//   void assignDefaultValue() {
//     mode = dateTime = spendingIndex = null;
//
//     update();
//   }
//
//   Future<void> addSpendingData({required SpendingModel model}) async {
//     int? res = await DatabaseHelper.databaseHelper.insertSpending(model: model);
//
//     if (res != null) {
//       Get.snackbar(
//         "Inserted",
//         "spending inserted....",
//         backgroundColor: Colors.green.shade300,
//       );
//     } else {
//       Get.snackbar(
//         "Failed",
//         "spending failed....",
//         backgroundColor: Colors.red.shade300,
//       );
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../helper/database_helper.dart';
import '../model/spending_model.dart';

class SpendingController extends GetxController {
  String? paymentMode;
  DateTime? selectedDate;
  int? selectedCategoryIndex;
  int selectedCategoryId = 0;
  late bool _splitScreenMode = false;

  void updatePaymentMode(String? mode) {
    paymentMode = mode;
    update();
  }

  void updateSpendingDate({required DateTime date}) {
    selectedDate = date;
    update();
  }

  void selectCategory({required int index, required int categoryId}) {
    selectedCategoryIndex = index;
    selectedCategoryId = categoryId;
    update();
  }

  void resetDefaultValues() {
    paymentMode = null;
    selectedDate = null;
    selectedCategoryIndex = null;
    update();
  }

  Future<void> addSpending({required SpendingModel spending}) async {
    await addSpendingData(model: spending);
    resetDefaultValues(); // Reset after adding
  }

  Future<void> addSpendingData({required SpendingModel model}) async {
    int? res = await DatabaseHelper.databaseHelper.insertSpending(model: model);
    if (res != null) {
      Get.snackbar("Inserted", "Spending inserted....",
          backgroundColor: Colors.green.shade300);
    } else {
      Get.snackbar("Failed", "Spending failed....",
          backgroundColor: Colors.red.shade300);
    }
  }
}
