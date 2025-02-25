// import 'dart:developer';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import '../controller/category_controller.dart';
// import '../model/category_model.dart';
//
// class AllCategoryComponents extends StatelessWidget {
//   const AllCategoryComponents({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     CategoryController categoryController = Get.put(CategoryController());
//     final TextEditingController categoryTextController =
//         TextEditingController();
//     final GlobalKey<FormState> categoryKey = GlobalKey<FormState>();
//     final List<String> availableCategoryImages = [
//       'assets/images/image1.png',
//       'assets/images/image2.png',
//     ];
//     categoryController.fetchCategoryData();
//      return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           TextField(
//             onChanged: (val) async {
//               log("Search Input: $val");
//               categoryController.searchData(val: val);
//             },
//             decoration: const InputDecoration(
//               prefixIcon: Icon(CupertinoIcons.search),
//               hintText: "Search Categories",
//             ),
//           ),
//           SizedBox(
//             height: 20.h,
//           ),
//           Expanded(
//             child: GetBuilder<CategoryController>(builder: (context) {
//               return FutureBuilder(
//                 future: categoryController.allCategory,
//                 builder: (context, categorySnapshot) {
//                   if (categorySnapshot.hasError) {
//                     return Center(
//                       child: Text("Error: ${categorySnapshot.error}"),
//                     );
//                   } else if (categorySnapshot.hasData) {
//                     List<CategoryModel> categoryList =
//                         categorySnapshot.data ?? [];
//
//                     return (categoryList.isNotEmpty)
//                         ? ListView.builder(
//                             itemCount: categoryList.length,
//                             itemBuilder: (context, index) {
//                               CategoryModel categoryItem = CategoryModel(
//                                 id: categoryList[index].id,
//                                 name: categoryList[index].name,
//                                 image: categoryList[index].image,
//                                 index: categoryList[index].index,
//                               );
//                               return Card(
//                                 child: ListTile(
//                                   leading: CircleAvatar(
//                                     radius: 26.w,
//                                     backgroundImage:
//                                         MemoryImage(categoryItem.image),
//                                   ),
//                                   title: Text(categoryItem.name),
//                                   trailing: Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       IconButton(
//                                         onPressed: () {
//                                           categoryTextController.text =
//                                               categoryItem.name;
//
//                                           categoryController.assignDefaultVal();
//
//                                           Get.bottomSheet(
//                                             Container(
//                                               width: double.infinity,
//                                               padding: const EdgeInsets.all(16),
//                                               decoration: const BoxDecoration(
//                                                 color: Colors.white,
//                                                 borderRadius: BorderRadius.only(
//                                                   topLeft: Radius.circular(20),
//                                                   topRight: Radius.circular(20),
//                                                 ),
//                                               ),
//                                               child: Form(
//                                                 key: categoryKey,
//                                                 child: Column(
//                                                   children: [
//                                                     const Text(
//                                                       "Edit Category",
//                                                       style: TextStyle(
//                                                         fontSize: 25,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                       height: 10.h,
//                                                     ),
//                                                     TextFormField(
//                                                       controller:
//                                                           categoryTextController,
//                                                       validator: (val) =>
//                                                           val!.isEmpty
//                                                               ? "Required..."
//                                                               : null,
//                                                       decoration:
//                                                           InputDecoration(
//                                                         labelText:
//                                                             "Category Name",
//                                                         hintText:
//                                                             "Enter category name...",
//                                                         enabledBorder:
//                                                             OutlineInputBorder(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(12),
//                                                           borderSide:
//                                                               const BorderSide(
//                                                                   color: Colors
//                                                                       .grey),
//                                                         ),
//                                                         focusedBorder:
//                                                             OutlineInputBorder(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(12),
//                                                           borderSide:
//                                                               const BorderSide(
//                                                                   color: Colors
//                                                                       .deepPurpleAccent),
//                                                         ),
//                                                         errorBorder:
//                                                             OutlineInputBorder(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(12),
//                                                           borderSide:
//                                                               const BorderSide(
//                                                                   color: Colors
//                                                                       .redAccent),
//                                                         ),
//                                                         focusedErrorBorder:
//                                                             OutlineInputBorder(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(12),
//                                                           borderSide:
//                                                               const BorderSide(
//                                                                   color: Colors
//                                                                       .redAccent),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                       height: 10.h,
//                                                     ),
//                                                     Expanded(
//                                                       child: GridView.builder(
//                                                         gridDelegate:
//                                                             const SliverGridDelegateWithFixedCrossAxisCount(
//                                                           crossAxisCount: 5,
//                                                         ),
//                                                         itemCount:
//                                                             availableCategoryImages
//                                                                 .length,
//                                                         itemBuilder: (context,
//                                                                 index) =>
//                                                             GetBuilder<
//                                                                 CategoryController>(
//                                                           builder: (context) {
//                                                             return GestureDetector(
//                                                               onTap: () {
//                                                                 categoryController
//                                                                     .getCategoryIndex(
//                                                                         index:
//                                                                             index);
//                                                               },
//                                                               child: Container(
//                                                                 margin:
//                                                                     const EdgeInsets
//                                                                         .all(3),
//                                                                 decoration:
//                                                                     BoxDecoration(
//                                                                   borderRadius:
//                                                                       BorderRadius
//                                                                           .circular(
//                                                                               12),
//                                                                   border: Border
//                                                                       .all(
//                                                                     color: (categoryController.categoryIndex !=
//                                                                             null)
//                                                                         ? (categoryController.categoryIndex ==
//                                                                                 index)
//                                                                             ? Colors
//                                                                                 .grey
//                                                                             : Colors
//                                                                                 .transparent
//                                                                         : (index ==
//                                                                                 categoryItem.index)
//                                                                             ? Colors.grey
//                                                                             : Colors.transparent,
//                                                                   ),
//                                                                   image:
//                                                                       DecorationImage(
//                                                                     image: AssetImage(
//                                                                         availableCategoryImages[
//                                                                             index]),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             );
//                                                           },
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     FloatingActionButton
//                                                         .extended(
//                                                       onPressed: () async {
//                                                         if (categoryKey
//                                                                 .currentState!
//                                                                 .validate() &&
//                                                             categoryController
//                                                                     .categoryIndex !=
//                                                                 null) {
//                                                           String name =
//                                                               categoryTextController
//                                                                   .text;
//
//                                                           String assetPath =
//                                                               availableCategoryImages[
//                                                                   categoryController
//                                                                       .categoryIndex!];
//
//                                                           ByteData byteData =
//                                                               await rootBundle
//                                                                   .load(
//                                                                       assetPath);
//                                                           Uint8List image =
//                                                               byteData.buffer
//                                                                   .asUint8List();
//
//                                                           CategoryModel model =
//                                                               CategoryModel(
//                                                             id: categoryItem.id,
//                                                             name: name,
//                                                             image: image,
//                                                             index: categoryController
//                                                                 .categoryIndex!,
//                                                           );
//
//                                                           categoryController
//                                                               .updateCategoryData(
//                                                                   model: model);
//                                                           Navigator.pop(
//                                                               context);
//                                                         }
//                                                       },
//                                                       label: const Text(
//                                                           "Update Category"),
//                                                     )
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                         icon: const Icon(
//                                           Icons.edit,
//                                           color: Colors.green,
//                                         ),
//                                       ),
//                                       IconButton(
//                                         onPressed: () {
//                                           categoryController.deleteCategory(
//                                               id: categoryItem.id);
//                                         },
//                                         icon: const Icon(
//                                           Icons.delete,
//                                           color: Colors.red,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           )
//                         : const Center(
//                             child: Text("No Categories Available"),
//                           );
//                   }
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class AllCategoryComponents extends StatefulWidget {
  const AllCategoryComponents({super.key});

  @override
  State<AllCategoryComponents> createState() => _AllCategoryComponentsState();
}

class _AllCategoryComponentsState extends State<AllCategoryComponents> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
