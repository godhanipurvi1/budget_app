import 'dart:typed_data'; // Import for Uint8List
import 'dart:convert'; // Import for base64 decoding

class CategoryModel {
  int id;
  String name;
  Uint8List image;
  int index;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.index,
  });

  factory CategoryModel.fromMap({required Map<String, dynamic> data}) {
    return CategoryModel(
      id: data['category_id'],
      name: data['category_name'],
      image: data['category_image'],
      index: data['category_image_index'],
    );
  }
}
