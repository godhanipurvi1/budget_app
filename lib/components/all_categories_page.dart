import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:budget/controller/category_controller.dart';
import 'package:budget/helper/database_helper.dart';

class AllCategoriesPage extends StatefulWidget {
  const AllCategoriesPage({super.key});

  @override
  State<AllCategoriesPage> createState() => _AllCategoriesPageState();
}

class _AllCategoriesPageState extends State<AllCategoriesPage> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController cnt = TextEditingController();
  CategoryController controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Categories"),
            const SizedBox(height: 20),
            Form(
              key: key,
              child: TextFormField(
                controller: cnt,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter category name";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: controller.categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 16,
                  childAspectRatio: 2 / 1,
                  crossAxisSpacing: 16,
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) {
                  var category = controller.categories[index];
                  return GestureDetector(
                    onTap: () {
                      controller.selectedImage(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: (controller.sIndex.value == index)
                              ? Colors.black
                              : Colors.transparent,
                        ),
                      ),
                      child: Image.asset(
                        category['image']!,
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () async {
                    if (key.currentState!.validate() &&
                        controller.sIndex.value >= 0) {
                      String name = cnt.text;
                      String assetPath = controller
                          .categories[controller.sIndex.value]['image']!;
                      try {
                        ByteData byteData = await rootBundle.load(assetPath);
                        Uint8List image = byteData.buffer.asUint8List();

                        int? res = await DatabaseHelper.databaseHelper
                            .insertCategory(
                                name: name,
                                image: image,
                                index: controller.sIndex.value);

                        if (res != null) {
                          Get.snackbar(
                            "Insert",
                            "$name category is inserted....$res",
                            colorText: Colors.white,
                            backgroundColor: Colors.green.shade300,
                          );
                        } else {
                          Get.snackbar(
                            "Failed",
                            "$name category insertion failed....",
                            colorText: Colors.white,
                            backgroundColor: Colors.red.shade300,
                          );
                        }
                      } catch (e) {
                        print("========================================");
                        print(e);
                        Get.snackbar(
                          "Error",
                          "Failed to load image",
                          colorText: Colors.white,
                          backgroundColor: Colors.red.shade300,
                        );
                      }
                    } else {
                      Get.snackbar(
                        "Required",
                        "Category name and image are required..",
                        colorText: Colors.white,
                        backgroundColor: Colors.redAccent,
                      );
                    }
                    cnt.clear();
                    controller.unselectImage(); // Reset image selection
                  },
                  child: const Text("Submit"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
