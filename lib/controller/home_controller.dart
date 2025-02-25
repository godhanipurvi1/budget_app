import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../components/all_categories_page.dart';
import '../components/all_spending_page.dart';
import '../components/categories_page.dart';
import '../components/spending_page.dart';

class HomeController extends GetxController {
  int? sIndex;
  void selectedImage(int index) {
    sIndex = index;
    update();
  }

  void unselectImage() {
    sIndex = null;
    update();
  }

  RxInt selectedIndex = 0.obs;
  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  List<Map<String, String>> categories = [
    {
      "name": "entertainment",
      "image": 'assets/01.png',
    },
    {
      "name": "investments",
      "image": 'assets/02.png',
    },
    {
      "name": "gift",
      "image": 'assets/03.png',
    },
    {
      "name": "housing",
      "image": 'assets/04.png',
    },
    {
      "name": "insurance",
      "image": 'assets/05.png',
    },
    {
      "name": "food",
      "image": 'assets/06.png',
    },
    {
      "name": "healthcare",
      "image": 'assets/08.png',
    },
    {
      "name": "bills",
      "image": 'assets/09.png',
    },
    {
      "name": "shopping",
      "image": 'assets/010.png',
    },
    {
      "name": "transport",
      "image": 'assets/011.png',
    },
  ];

  List<Widget> pages = [
    const SpendingForm(),
    const AllSpendingComponents(),
    const AllCategoryComponents(),
    const AllCategoriesPage(),
  ];
}
