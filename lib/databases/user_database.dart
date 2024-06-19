import 'package:dekasut/databases/main_database.dart';
import 'package:dekasut/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

class UserDatabase {
  static final UserDatabase instance = UserDatabase._privateConstructor();
  static Database? _database;

  UserDatabase._privateConstructor();

  Future<Database> get database async {
    _database = await MainDatabase.instance.database;
    return _database!;
  }

  Future<int> insertUser(UserModel user) async {
    Database db = await instance.database;
    return await db.insert('users', user.toMap());
  }

  Future<List<UserModel>> getUsers() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return UserModel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        email: maps[i]['email'],
        username: maps[i]['username'],
        password: maps[i]['password'],
      );
    });
  }

  Future<int> updateUser(UserModel user) async {
    Database db = await instance.database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    Database db = await instance.database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<UserModel?> getUserByEmail(String email) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    print('get user by email testing ${maps[0]}');

    if (maps.isNotEmpty) {
      return UserModel(
        id: maps[0]['id'],
        name: maps[0]['name'],
        email: maps[0]['email'],
        username: maps[0]['username'],
        password: maps[0]['password'],
      );
    }

    return null;
  }
}
