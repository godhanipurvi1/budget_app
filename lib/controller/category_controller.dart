import 'package:get/get.dart';

class CategoryController extends GetxController {
  // Reactive variable to track selected category
  RxInt sIndex = RxInt(-1);

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

  // Method to select an image by updating sIndex
  void selectedImage(int index) {
    sIndex.value = index;
  }

  // Method to unselect the image
  void unselectImage() {
    sIndex.value = -1;
  }
}
