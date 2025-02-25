import 'dart:typed_data';

import 'package:sqflite/sqflite.dart';

import '../model/category_model.dart';
import '../model/spending_model.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static DatabaseHelper databaseHelper = DatabaseHelper._();
  String spendingTable = "spending";
  String spendingId = "spending_id";
  String spendingDesc = "spending_description";
  String spendingAmount = "spending_amount";
  String spendingMode = "spending_mode";
  String spendingDate = "spending_date";
  String spendingCategoryId = "spending_category_id";

  Database? db;
  String? tableName = "category";

  String? categoryName = "category_name";
  String? categoryImage = "category_image";
  String categoryImageIndex = "category_image_index";
  Future<void> initDB() async {
    String dbPath = await getDatabasesPath();
    String path = "${dbPath}budget.db";

    db = await openDatabase(path, version: 1, onCreate: (Database db, _) async {
      String query = '''CREATE TABLE $tableName(
            category_id INTEGER PRIMARY KEY AUTOINCREMENT,
            $categoryName TEXT NOT NULL,
            $categoryImage BLOB NOT NULL
        );''';
      db.execute(query).then((value) {
        print(".....");
      });
    });
  }

  Future<int?> insertCategory({
    required String name,
    required Uint8List image,
    required int index,
  }) async {
    await initDB();

    String query =
        "INSERT INTO $tableName ($categoryName, $categoryImage) VALUES(?, ?);";
    List arg = [name, image, index];

    return await db?.rawInsert(query, arg);
  }

  Future<int?> insertSpending({required SpendingModel model}) async {
    await initDB();

    String query =
        "INSERT INTO $spendingTable ($spendingDesc,$spendingAmount,$spendingMode,$spendingDate,$spendingCategoryId) VALUES(?, ?, ?, ?, ?);";

    List args = [
      model.description,
      model.amount,
      model.paymentMode,
      model.date,
      model.categoryId,
    ];

    return await db?.rawInsert(query, args);
  }

  Future<List<CategoryModel>> fetchCategory() async {
    await initDB();

    String query = "SELECT * FROM $tableName;";

    List<Map<String, dynamic>> res = await db?.rawQuery(query) ?? [];

    return res
        .map(
          (e) => CategoryModel.fromMap(data: e),
        )
        .toList();
  }

  Future<List<SpendingModel>> fetchSpending() async {
    await initDB();

    String query = "SELECT *  FROM $spendingTable;";

    List<Map<String, dynamic>> res = await db?.rawQuery(query) ?? [];

    return res
        .map(
          (e) => SpendingModel.formMap(data: e),
        )
        .toList();
  }

  Future<CategoryModel> fetchSingleCategory({required int id}) async {
    await initDB();

    String query = "SELECT * FROM $tableName WHERE category_id = $id;";

    List<Map<String, dynamic>> res = await db?.rawQuery(query) ?? [];

    return CategoryModel(
        id: res[0]['category_id'],
        name: res[0][categoryName],
        image: res[0][categoryImage],
        index: res[0][categoryImageIndex]);
  }

  Future<List<CategoryModel>> liveSearchCategory({
    required String search,
  }) async {
    await initDB();

    String query =
        "SELECT * FROM $tableName WHERE $categoryName LIKE '%$search%';";

    List<Map<String, dynamic>> res = await db?.rawQuery(query) ?? [];

    return res
        .map(
          (e) => CategoryModel.fromMap(data: e),
        )
        .toList();
  }

  Future<int?> updateCategory({required CategoryModel model}) async {
    await initDB();

    String query =
        "UPDATE $tableName SET $categoryName = ?, $categoryImage = ?, $categoryImageIndex = ? WHERE category_id = ${model.id};";
    List arg = [
      model.name,
      model.image,
      model.index,
    ];
    return await db?.rawUpdate(query, arg);
  }

  Future<int?> deleteCategory({required int id}) async {
    await initDB();

    String query = "DELETE FROM $tableName WHERE category_id=$id;";

    return await db?.rawDelete(query);
  }
}
