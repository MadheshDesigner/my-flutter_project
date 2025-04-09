import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../utils/constant.dart';

class DatabaseConnection{

  Future<Database> setDatabase()async{
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path,AppConstant.databaseName);
    var database = openDatabase(path,version: 1,onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version)async{
    var query = "CREATE TABLE ${AppConstant.tableName}(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,description TEXT);";
    await database.execute(query);
  }
}