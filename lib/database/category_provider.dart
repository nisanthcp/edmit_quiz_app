import 'package:edmit_quiz_app/const/const.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_riverpod/all.dart';

class Category {
  int id;
  String name, image;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnMainCategoryId: id,
      columnCategoryName: name,
      columnCategoryimage: image
    };
    return map;
  }

  Category();

  Category.fromMap(Map<String, dynamic> map) {
    id = map[columnMainCategoryId];
    name = map[columnCategoryName];
    image = map[columnCategoryimage];
  }
}

class CategoryProvider {
  Future<Category> getCateogoryById(Database db, int id) async {
    var maps = await db.query(tableCategoryName,
        columns: [
          columnMainCategoryId,
          columnCategoryName,
          columnCategoryimage
        ],
        where: '$columnMainCategoryId=?',
        whereArgs: [id]);
    if (maps.length > 0) return Category.fromMap(maps.first);
    return null;
  }

  Future<List<Category>> getCateogories(Database db) async {
    var maps = await db.query(tableCategoryName, columns: [
      columnMainCategoryId,
      columnCategoryName,
      columnCategoryimage
    ]);
    if (maps.length > 0)
      return maps.map((category) => Category.fromMap(category)).toList();
    return null;
  }
}

class CategoryList extends StateNotifier<List<Category>> {
  CategoryList(List<Category> state) : super(state ?? []);

  void addAll(List<Category> category) {
    state.addAll(category);
  }

  void add(Category category) {
    state = [
      ...state,
      category,
    ];
  }
}
