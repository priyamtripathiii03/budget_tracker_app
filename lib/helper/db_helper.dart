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
        String query = '''CREATE TABLE budget(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      amount REAL,
      isIncome INTEGER,
      date TEXT,
      category TEXT
      )''';
        await db.execute(query);
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
   try{
     Database? db = await database;
     log('message');
     String query = '''UPDATE $_tableName SET amount = ?,category = ?, isIncome = ?, date = ? WHERE id = ?''';
     List args = [amount,category,isIncome,date,id];
     await db!.rawUpdate(query,args);
   }catch(e)
   {
     log(e.toString());
   }
 }

}
