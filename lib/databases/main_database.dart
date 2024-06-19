import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MainDatabase {
  static final MainDatabase instance = MainDatabase._privateConstructor();
  static Database? _database;

  MainDatabase._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'dekasut.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      email TEXT UNIQUE,
      username TEXT UNIQUE,
      password TEXT
    )
  ''');
    await db.execute('''
    CREATE TABLE products(
        id INTEGER PRIMARY KEY,
        name TEXT,
        price REAL,
        description TEXT,
        category TEXT,
        galleries TEXT
    )
  ''');
    await db.execute('''
    CREATE TABLE carts(
      userId INTEGER,
      productId INTEGER,
      quantity INTEGER,
      FOREIGN KEY (userId) REFERENCES users(id),
      FOREIGN KEY (productId) REFERENCES products(id)
    )
  ''');
  }
}
