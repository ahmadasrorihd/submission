import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/restaurant.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  final String tableName = 't_fav_restaurant';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnDescription = 'description';
  final String columnCity = 'city';
  final String columnRating = 'rating';
  final String columnPictureId = 'pictureId';

  DbHelper._internal();
  factory DbHelper() => _instance;

  //cek apakah database ada
  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'restaurant.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //membuat tabel dan field-fieldnya
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId TEXT PRIMARY KEY, "
        "$columnName TEXT,"
        "$columnDescription TEXT,"
        "$columnCity TEXT,"
        "$columnRating DOUBLE,"
        "$columnPictureId TEXT)";
    await db.execute(sql);
  }

  //insert ke database
  Future<int?> addToFavorite(Restaurant restaurant) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, restaurant.toMap());
  }

  //read database
  Future<List<Restaurant>> getAllFavoriteRestaurant() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnName,
      columnDescription,
      columnCity,
      columnRating,
      columnPictureId
    ]);

    return result.map((res) => Restaurant.fromMap(res)).toList();
  }

  Future<Restaurant> getFavById(String id) async {
    var dbClient = await _db;
    List<Map<String, dynamic>> results = await dbClient!.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return results.map((res) => Restaurant.fromMap(res)).first;
  }

  Future<int?> deleteFromFav(int id) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
