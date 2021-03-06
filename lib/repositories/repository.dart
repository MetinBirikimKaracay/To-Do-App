//insert data gibi fonksiyonları burada yazacakmışız

import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/repositories/database_connection.dart';

class Repository{
  DatabaseConnection? _databaseConnection;
  Repository(){
    //initialize database connection
    _databaseConnection = DatabaseConnection();

  }
  static Database? _database;
  Future<Database?> get database async{
    if(_database != null) return _database;
    _database ??= await _databaseConnection?.setDatabase();
    return _database;
  }
//buranın üstünde yaptığımız şey; database connectionlarımda database fonksiyonlarını çağırdık.
//buranın üstünü 01:31:51'den önce anlattı

//artık insert data to table kısmına geçiyoruz
  insertData(table, data) async{
    var connection = await database;
    return await connection?.insert(table, data);
  }

//read data from table
  readData(table) async{
    var connection = await database;
    return await connection?.query(table);
  }
  readDataById(table, itemId) async{
    var connection = await database;
    return await connection?.query(table,
        where: 'id=?', whereArgs: [itemId]);
  }
  updateData(table, data) async{
    var connection = await database;
    return await connection?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }
  deleteData(table, itemId) async{
    var connection = await database;
    return await connection?.rawDelete("DELETE FROM $table WHERE id = $itemId");
  }

  readDataByColumnName(table, columnName, columnValue) async{
    var connection = await database;
    return await connection?.query(table, where: '$columnName=?', whereArgs: [columnValue]);
  }
}