import 'package:budget_tracker_app/helper/db_helper.dart';
import 'package:sqflite/sqlite_api.dart';

class UserDbHelper
{
  UserDbHelper._();
  static UserDbHelper userDbHelper = UserDbHelper._();

  Database? _database;

  Future<Database?> get database async => _database ?? await DbHelper.dbHelper.createDatabase();

  Future<void> insertUser(String name)
  async {
    Database? db = await database;
    String sql = "INSERT INTO user(name) VALUES(?)";
    List args = [name];
    await db!.rawInsert(sql,args);
  }

  Future<List<Map<String, Object?>>> fetchData()
  async {
    Database? db = await database;
    String query = '''SELECT * FROM user''';
    List<Map<String, Object?>> userList = await db!.rawQuery(query);

    return userList;
  }
  Future<void> updateData({required String name})
  async {
    Database? db = await database;
    String query = '''UPDATE user SET name=?''';
    List args = [name];
    await db!.rawUpdate(query,args);
  }

}