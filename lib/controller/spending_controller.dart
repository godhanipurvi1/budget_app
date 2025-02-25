import 'package:budget/helper/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/spending_model.dart';

class SpendingController extends GetxController {
  String? mode;
  DateTime? dateTime;

  int? spendingIndex;
  int categoryId = 0;

  void getSpendingMode(String? value) {
    mode = value;

    update();
  }

  void getSpendingDate({required DateTime date}) {
    dateTime = date;

    update();
  }

  void getSpendingIndex({required int index, required int id}) {
    spendingIndex = index;
    categoryId = id;
    update();
  }

  void assignDefaultValue() {
    mode = dateTime = spendingIndex = null;

    update();
  }

  Future<void> addSpendingData({required SpendingModel model}) async {
    int? res = await DatabaseHelper.databaseHelper.insertSpending(model: model);

    if (res != null) {
      Get.snackbar(
        "Inserted",
        "spending inserted....",
        backgroundColor: Colors.green.shade300,
      );
    } else {
      Get.snackbar(
        "Failed",
        "spending failed....",
        backgroundColor: Colors.red.shade300,
      );
    }
  }
}
