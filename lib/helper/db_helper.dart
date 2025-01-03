import 'dart:developer';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static DbHelper dbHelper = DbHelper._();
  Database? _database;
  final String _tableName = "budget";

  Future<Database?> get database async => _database ?? await createDatabase();

  Future<void> deleteDb() async {
    var path = await getDatabasesPath();
    var dbPath = join(path, 'budget.db');
    await deleteDatabase(dbPath);
  }

  Future<Database?> createDatabase() async {
    var dbPath = await getDatabasesPath();
    var path = join(dbPath,'budget.db');


    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        String query = '''CREATE TABLE $_tableName(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      amount REAL,
      isIncome INTEGER,
      date TEXT,
      category TEXT,
      name TEXT,
      img BLOB
      )''';

        String userQuery = '''CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        phone TEXT,
        img BLOB
        )''';

        await db.execute(query);
        await db.execute(userQuery);
      },);
    return _database;
  }

  Future<void> insertRecord(double amount, String category, String date, int isIncome)
  async {
    Database? db = await database;
  log("Inserting...");
    String query =
        '''INSERT INTO $_tableName (amount,category,date,isIncome) VALUES(?,?,?,?)''';

    List args = [amount,category,date,isIncome];
    await db!.rawInsert(query,args);
  }

  // read - fetch

  Future<List<Map<String, Object?>>> fetchRecords() async {
    Database? db = await database;
    String query = '''SELECT * FROM $_tableName''';
    return await db!.rawQuery(query);
  }

  //  delete

  Future<void> deleteRecord(int id)
  async {
    Database? db = await database;
    String query = '''DELETE FROM $_tableName WHERE id = ?''';
    List args = [id];
    db!.rawDelete(query,args);
  }

//   update

 Future<void> updateRecord(int id,int isIncome,double amount,String date,String category)
 async {
     Database? db = await database;
     log('message');
     String query = '''UPDATE $_tableName SET amount = ?,category = ?, isIncome = ?, date = ? WHERE id = ?''';
     List args = [amount,category,isIncome,date,id];
     await db!.rawUpdate(query,args);
 }
 Future<List<Map<String, Object?>>> filterCategory(int isIncome)
 async {
   Database? db = await database;
   String query = "SELECT * FROM $_tableName WHERE isIncome=?";
   List args = [isIncome];
   return await db!.rawQuery(query,args);
 }
 Future<List<Map<String, Object?>>> filterBySearch(String search)
 async {
   Database? db = await database;
   String query = "SELECT * FROM $_tableName WHERE category  LIKE '$search%'";
   // List args = [search];
   return await db!.rawQuery(query);
 }

}
