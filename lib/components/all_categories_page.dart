// import 'package:budget/controller/home_controller.dart';
// import 'package:budget/helper/database_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
//
// class AllCategoriesPage extends StatefulWidget {
//   const AllCategoriesPage({super.key});
//
//   @override
//   State<AllCategoriesPage> createState() => _AllCategoriesPageState();
// }
//
// class _AllCategoriesPageState extends State<AllCategoriesPage> {
//   GlobalKey<FormState> key = GlobalKey<FormState>();
//   TextEditingController cnt = TextEditingController();
//   HomeController controller = Get.put(HomeController());
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("Select Categories"),
//             const SizedBox(
//               height: 20,
//             ),
//             TextFormField(
//               key: key,
//               controller: cnt,
//               decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15))),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return "enter category name";
//                 }
//               },
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: GridView.builder(
//                   itemCount: controller.categories.length,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       mainAxisSpacing: 16,
//                       childAspectRatio: 2 / 1,
//                       crossAxisSpacing: 16,
//                       crossAxisCount: 4),
//                   itemBuilder: (context, index) {
//                     var category = controller.categories[index];
//                     return GestureDetector(
//                       onTap: () {
//                         controller.selectedImage(index);
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                               color: (controller.sIndex == index)
//                                   ? Colors.black
//                                   : Colors.transparent),
//                         ),
//                         child: Image.asset(
//                           category['image']!,
//                         ),
//                       ),
//                     );
//                   }),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 FloatingActionButton(
//                   onPressed: () async {
//                     if (key.currentState!.validate() &&
//                         controller.sIndex != null) {
//                       String? name = cnt.text;
//                       String? assetPath =
//                           controller.categories[controller.sIndex!]['image'];
//                       print(assetPath);
//                       ByteData byteData = await rootBundle.load(assetPath!);
//                       Uint8List image = byteData.buffer.asUint8List();
//                       int? res = await DatabaseHelper.databaseHelper
//                           .insertCategory(
//                               name: name,
//                               image: image,
//                               index: controller.sIndex!);
//                       if (res != null) {
//                         Get.snackbar(
//                           "Insert",
//                           "$name category is inserted....$res",
//                           colorText: Colors.white,
//                           backgroundColor: Colors.green.shade300,
//                         );
//                       } else {
//                         Get.snackbar(
//                           "Failed",
//                           "$name category is Insertion failed....",
//                           colorText: Colors.white,
//                           backgroundColor: Colors.red.shade300,
//                         );
//                       }
//                     } else {
//                       Get.snackbar(
//                         "Required",
//                         "category name and image are required..",
//                         colorText: Colors.white,
//                         backgroundColor: Colors.redAccent,
//                       );
//                     }
//                     cnt.clear();
//                     controller.unselectImage();
//                   },
//                   child: const Text("submit"),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:budget/controller/home_controller.dart';
import 'package:budget/helper/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AllCategoriesPage extends StatefulWidget {
  const AllCategoriesPage({super.key});

  @override
  State<AllCategoriesPage> createState() => _AllCategoriesPageState();
}

class _AllCategoriesPageState extends State<AllCategoriesPage> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController cnt = TextEditingController();
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Categories"),
            const SizedBox(
              height: 20,
            ),
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
                    crossAxisCount: 4),
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
                            color: (controller.sIndex == index)
                                ? Colors.black
                                : Colors.transparent),
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
                        controller.sIndex != null &&
                        controller.sIndex! >= 0) {
                      String? name = cnt.text;
                      String? assetPath =
                          controller.categories[controller.sIndex!]['image'];

                      // Ensure the asset path is valid before continuing
                      if (assetPath == null) {
                        Get.snackbar(
                          "Error",
                          "Please select an image",
                          colorText: Colors.white,
                          backgroundColor: Colors.red.shade300,
                        );
                        return;
                      }

                      try {
                        ByteData byteData = await rootBundle.load(assetPath);
                        Uint8List image = byteData.buffer.asUint8List();

                        int? res = await DatabaseHelper.databaseHelper
                            .insertCategory(
                                name: name,
                                image: image,
                                index: controller.sIndex!);

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
            )
          ],
        ),
      ),
    );
  }
}
