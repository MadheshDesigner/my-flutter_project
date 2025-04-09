import '../../../data/database/database_connection.dart';
import '../../../model/add_item_model.dart';
import '../../../utils/constant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseRepository{
  late DatabaseConnection _databaseConnection;
  DatabaseRepository(){
    _databaseConnection = DatabaseConnection();
  }
  static Database? _database;


  Future<Database?> get database async{
    if(_database!=null){
      return _database;
    }else{
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  Future<int> insertItem(ItemModel item)async{
   final connection = await database;
   return await connection!.insert(AppConstant.tableName, item.toMap());
  }

  Future<List<ItemModel>> getItem()async{
    final connection = await database;
    final List<Map<String, dynamic>> data = await connection!.query(AppConstant.tableName);
    return List.generate(data.length, (index) {
      return ItemModel.fromMap(data[index]);
    },);
  }

  Future<int> updateItem(ItemModel item)async{
    final connection = await database;
    return await connection!.update(AppConstant.tableName, item.toMap(),where: 'id=?',whereArgs:[ item.id]);
  }

  Future<int> deleteItem(int id)async{
    final connection = await database;
    return await connection!.delete(AppConstant.tableName,where: 'id=?',whereArgs:[id]);
  }

}