// @dart = 2.9

import 'package:common_utils/common_utils.dart';
import 'package:flutter_practice2/sqlflite/sql_constants.dart';
import 'package:flutter_practice2/sqlflite/user_db.dart';
import 'package:sqflite/sqlite_api.dart';

import 'basedb_provider.dart';

class UserDbUtil extends BaseDbProvider{

  static UserDbUtil _instance;

  // 私有的命名构造函数
  UserDbUtil._internal();

  static UserDbUtil getInstance() => _instance ??= UserDbUtil._internal();

  UserDbUtil();

  final String name = SQLConstants.tableName;
  final String columnId = "id";
  final String columnName = "name";
  final String columnDesc = "desc";

  //获取表名称
  @override
  tableName() {
    return name;
  }

  //创建表操作
  @override
  createTableString() {
    return '''
        create table $name (
        $columnId integer primary key,$columnName text not null,
        $columnDesc text not null)
      ''';
  }

  ///查询数据
  Future selectUser(int id) async {
    List<Map<String, Object>> result;
    Database db = await getDataBase();
    await db.transaction((txn) async {
      try {
        result = await txn.rawQuery("select * from $name where $columnId = $id");
      }catch (e){
        result = [];
        LogUtil.e('UserDb selectUser $e');
      }
    });
    return result;
  }

  //查询数据库所有
  Future<List<Map<String, dynamic>>> selectMapList() async {
    List<Map<String, dynamic>> result = [];
    Database db = await getDataBase();
    await db.transaction((txn) async {
      result.addAll(await txn.query(name));
    });
    return result;
  }

  //查詢id所有
  Future<List<int>> selectIdList() async{
    List<Map<String, dynamic>> userMapList = await selectMapList();
    List<int> userList= [];

    for(int i = 0; i < userMapList.length; i++){
      userList.add(UserDB.fromMap(userMapList[i]).id);
    }
    return userList;
  }

  //获取数据库里所有user
  Future<List<UserDB>> getAllUser() async{
    var userMapList = await selectMapList();
    var count  = userMapList.length;
    List<UserDB> userList= [];

    for(int i=0; i < count; i++){
      userList.add(UserDB.fromMap(userMapList[i]));
    }
    return userList;
  }

  //根据id查询user
  Future<UserDB> getUser(int id) async {
    List<Map<String, Object>> listMap = await selectUser(id); // Get 'Map List' from database
    if(listMap.isEmpty){
      return UserDB.fromMap({});
    }else{
      return UserDB.fromMap(listMap[id-1]);
    }
  }

  //增加数据
  Future<bool> insertUser(UserDB user) async {
    bool result;
    if(user == null){
      LogUtil.e('UserDb InsertUser user:null');
      return false;
    }
    Database db = await getDataBase();
    Batch batch = db.batch();
    try {
      batch.insert(name, user.toMap());
      //await txn.execute('INSERT INTO $name(id, name, desc) VALUES(?, ?, ?)', [user.id, user.name, user.desc]);
      //await txn.rawInsert('INSERT INTO $name(id, name, desc) VALUES(?, ?, ?)', [user.id, user.name , user.desc]);
      result = true;
    } catch (e){
      LogUtil.e('UserDb InsertUser $e');
      result = false;
    }
    await batch.commit();
    return result;
  }

  //增加数据
  Future<bool> insertUserList(List<UserDB> list) async {
    bool result;
    if(list.isEmpty){
      LogUtil.e('UserDb InsertUserList List<UserDB>:null');
      return false;
    }
    Database db = await getDataBase();
    Batch batch = db.batch();
    for (var element in list) {
      try {
        batch.insert(name, element.toMap());
        //await txn.execute('INSERT INTO $name(id, name, desc) VALUES(?, ?, ?)', [user.id, user.name, user.desc]);
        //await txn.rawInsert('INSERT INTO $name(id, name, desc) VALUES(?, ?, ?)', [user.id, user.name , user.desc]);
        result = true;
      } catch (e){
        LogUtil.e('UserDb InsertUserList $e');
        result = false;
      }
    }
    await batch.commit(noResult: true);
    return result;
  }

  //更新数据
  Future<bool> update(UserDB user) async {
    bool result;
    if(user == null){
      LogUtil.e('UserDb update user:null');
      return false;
    }
    Database db = await getDataBase();
    Batch batch = db.batch();
    try {
      batch.update(name, user.toMap(), where: "$columnId = ?", whereArgs: [user.id]);
      //result = await txn.rawUpdate("update $name set $columnName = ?,$columnDesc = ? where $columnId = ?", [user.name, user.desc, user.id]);
      result = true;
    } catch (e){
      LogUtil.e('UserDb update $e');
      result = false;
    }
    await batch.commit();
    return result;
  }

  //增加数据
  Future<bool> updateUserList(List<UserDB> list) async {
    bool result;
    if(list.isEmpty){
      LogUtil.e('UserDb updateUserList List<UserDB>:null');
      return false;
    }
    Database db = await getDataBase();
    Batch batch = db.batch();
    for (int i = 0; i < list.length; i++) {
      // LogUtil.e('UserDb User:${listUser[i].id} ${listUser[i].name} ${listUser[i].desc}');
      try {
        batch.update(name, list[i].toMap(), where: "$columnId = ?", whereArgs: [list[i].id]);
        //await txn.execute('INSERT INTO $name(id, name, desc) VALUES(?, ?, ?)', [user.id, user.name, user.desc]);
        //await txn.rawInsert('INSERT INTO $name(id, name, desc) VALUES(?, ?, ?)', [user.id, user.name , user.desc]);
        result = true;
      } catch (e){
        LogUtil.e('UserDb updateUserList $e');
        result = false;
      }
    }
    await batch.commit(noResult: true);
    return result;
  }

  //删除数据
  Future<bool> deleteUser(int id) async {
    bool result;
    if(id < 1){
      LogUtil.e('UserDb delete id:0');
      return false;
    }
    Database db = await getDataBase();
    Batch batch = db.batch();
    try {
      batch.delete(name, where: '$columnId = ?', whereArgs: [id]);
      //result = await txn.rawDelete('DELETE FROM $name WHERE $columnId = $id');
      result = true;
    } catch (e){
      LogUtil.e('UserDb delete $e');
      result = false;
    }
    await batch.commit();
    return result;
  }

  //删除数据
  Future<bool> deleteUserList(List<UserDB> list) async {
    bool result;
    if(list.isEmpty){
      LogUtil.e('UserDb deleteUserList List<int>:null');
      return false;
    }
    Database db = await getDataBase();
    Batch batch = db.batch();
    for (var element in list) {
      try {
        batch.delete(name, where: '$columnId = ?', whereArgs: [element.id]);
        //results = await batch.rawDelete('DELETE FROM $name WHERE $columnId = $id');
        //result = await txn.delete(tableName, where: key, whereArgs: args);
        result = true;
      } catch (e){
        LogUtil.e('UserDb deleteUserList $e');
        result = false;
      }
    }
    await batch.commit(noResult: true);
    return result;
  }

  // 刪除
  Future<int> deleteTable(String tableName) async {
    int result;
    if(tableName.isEmpty){
      LogUtil.e('UserDb deleteTable table:0');
      return 0;
    }
    Database db = await getDataBase();
    await db.transaction((txn) async {
      result = await db.rawDelete("Delete * from $tableName");
    });
    return result;
  }

}