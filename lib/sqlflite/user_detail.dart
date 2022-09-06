import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_practice2/sqlflite/sql_constants.dart';
import 'package:flutter_practice2/sqlflite/user_db.dart';
import 'package:flutter_practice2/sqlflite/user_db_util.dart';
import 'package:flutter_practice2/util/regexp_util.dart';
import 'package:oktoast/oktoast.dart';

import '../util/function_util.dart';

class UserDetail extends StatefulWidget {
  final UserDB user;
  const UserDetail(this.user, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UserDetailState();
}

class UserDetailState extends State<UserDetail> {
  final UserDbUtil _userDbUtil = UserDbUtil.getInstance();
  late UserDB user;
  final List<UserDB> _listUserDb = [], _listSearch = [];
  String multiUserDb = '', searchDb = '';

  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    user = widget.user;
    if(user.id != null) {
      idController.text = user.id.toString();
    }
    nameController.text = user.name;
    descriptionController.text = user.desc;
    return Scaffold(
      appBar: AppBar(
        title: const Text('User detail'),
      ),
      body: SingleChildScrollView(
        child: KeyboardDismissOnTap(
          dismissOnCapturedTaps: true, // 沒點擊不會自動打開
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: TextField(
                    keyboardType: TextInputType.text,
                    controller: idController,
                    decoration: const InputDecoration(
                        labelText: '單筆插入/更新/刪除必須輸入',
                        labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
                        hintText: 'ex:1',
                        helperText: "請輸入編號 "
                    ),
                    onChanged: (value) {
                      _updateId();
                    }),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: TextField(
                    keyboardType: TextInputType.text,
                    controller: nameController,
                    decoration: const InputDecoration(
                        labelText: '必須輸入',
                        labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
                        hintText: 'ex:王明',
                        helperText: "請輸入名字"
                    ),
                    onChanged: (value) {
                      _updateName(); // 更新userName
                    }),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: TextField(
                    keyboardType: TextInputType.text,
                    controller: descriptionController,
                    onChanged: (value) {
                      _updateDescription();
                    },
                    decoration: const InputDecoration(
                        labelText: '必須輸入',
                        labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
                        hintText: 'ex:醫生',
                        helperText: "請輸入職業"
                    )),
              ),
              _listSearch.isNotEmpty ? Padding(padding: const EdgeInsets.all(20),child: FunctionUtil().initText2(searchDb, Colors.black, Colors.transparent, 18),) : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: const Text('多個新增請點我',),
                    onPressed: () {
                      setState(() {
                        _setListUser();
                      });
                    },
                  ),
                  RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    child: const Text('查詢',),
                    onPressed: () {
                      setState(() {
                        _searchAll();
                      });
                    },
                  ),
                  RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: const Text('清空',),
                      onPressed: () {
                        setState(() {
                          _clearAll();
                        });
                      },
                  ),
                ],
              ),
              multiUserDb.isNotEmpty ? Padding(padding: const EdgeInsets.all(20),child: FunctionUtil().initText2(multiUserDb, Colors.black, Colors.transparent, 18),) : Container(),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: const Text('插入',),
                        onPressed: () {
                          setState(() {
                            _save();
                          });
                        }),
                    RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: const Text('更新',),
                        onPressed: () {
                          setState(() {
                            _update();
                          });
                        }),
                    RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: const Text('删除',),
                        onPressed: () {
                          setState(() {
                            _delete();
                          });
                        })
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: const Text(
                        '插入列表',
                      ),
                      onPressed: () {
                       setState(() {
                       _saveList();
                       });
                    }),
                    RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: const Text(
                        '更新列表',
                      ),
                        onPressed: () {
                          setState(() {
                            _updateList();
                          });
                        }),
                    RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: const Text(
                        '删除列表',
                      ),
                        onPressed: () {
                          setState(() {
                            _deleteList();
                          });
                        }),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: const Text(
                        '删除表',
                      ),
                      onPressed: () => _deleteTable,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _updateId() {
    String text = idController.text.replaceAll(' *&^%#@?>|}{?><_+-=/[],.', '');
    if(RegExpUtil.isNumber1(text)){
      user.id = int.parse(text);
    }else if(text.isNotEmpty && RegExpUtil.isNumber1(text) == false){
      showToast('請照範例輸入正確格式');
    }else{

    }
    // LogUtil.e('UserDetail listIdLength:${_listId.length} listUserLength:${_listUserDb.length}');
  }

  void _updateName() {
    String text = nameController.text.replaceAll(' *&^%#@?>|}{?><_+-=/[],.', '');
    if(RegExpUtil.isChinese1(text)){
      user.name = text;
    }else if(text.isNotEmpty && RegExpUtil.isChinese1(text) == false){
      showToast('請照範例輸入正確格式');
    }else{

    }
  }

  void _updateDescription() {
    String text = descriptionController.text.replaceAll(' *&^%#@?>|}{?><_+-=/[],.', '');
    if(RegExpUtil.isChinese1(text)){
      user.desc = text;
    }else if(text.isNotEmpty && RegExpUtil.isChinese1(text) == false){
      showToast('請照範例輸入正確格式');
    }else{

    }
  }

  _searchAll() async {
    _listSearch.addAll(await _userDbUtil.getAllUser());
    if(_listSearch.isEmpty){
      _showOkToast("資料庫無資料");
      return;
    }
    for (var element in _listSearch) {
      setState(() {
        searchDb += '${element.id} ${element.name} ${element.desc} ';
      });
    }
  }

  _setListUser(){
    if(user.id == null && user.name == null && user.desc == null){
      _showOkToast("請輸入正確資訊");
      return;
    }else if(user.id == null){
      _showOkToast("請輸入正確編號");
      return;
    }else if(user.name == null){
      _showOkToast("請輸入正確姓名");
      return;
    }else if(user.desc == null){
      _showOkToast("請輸入正確職業");
      return;
    }
    UserDB newUser = UserDB();
    newUser.id = user.id;
    newUser.name = user.name;
    newUser.desc = user.desc;
    _listUserDb.add(newUser);
    multiUserDb += '${user.id} ${user.name} ${user.desc} ';
  }

  _clearAll(){
    idController.text = '';
    nameController.text = '';
    descriptionController.text = '';
    idController.clear();
    nameController.clear();
    descriptionController.clear();
    _listUserDb.clear();
    _listSearch.clear();
    multiUserDb = '';
    searchDb = '';
    user.id = null;
    user.name = null;
    user.desc = null;
  }

  _deleteTable() async {

    int result = await _userDbUtil.deleteTable(SQLConstants.tableName);

    moveToLastScreen();

    if (result != 0) {
      _showOkToast("删除成功");
    } else {
      _showOkToast("刪除失敗");
    }

  }

  void _save() async {

    if(user.id == null && user.name == null && user.desc == null){
      _showOkToast("請輸入正確資訊");
      return;
    }else if(user.id == null){
      _showOkToast("請輸入正確編號");
      return;
    }else if(user.name == null){
      _showOkToast("請輸入正確姓名");
      return;
    }else if(user.desc == null){
      _showOkToast("請輸入正確職業");
      return;
    }

    UserDB newUserDb = await _userDbUtil.getUser(user.id);

    if(newUserDb.id != null){
      showToast('已有相同編號,請重新輸入');
      return;
    }

     // LogUtil.e('UserDetail id:${user.id} newId:${newUserDb.id}');

    // user.id = DateTime.now().millisecondsSinceEpoch;  //id 为当前时间戳
    bool result = await _userDbUtil.insertUser(user);

    moveToLastScreen();

    if (result) {
      _showOkToast("儲存成功");
    } else {
      _showOkToast("儲存失敗");
    }

  }

  void _update() async {

    if(user.id == null || user.id < 1){
      _showOkToast("請輸入正確編號");
      return;
    }

    UserDB newUserDb = await _userDbUtil.getUser(user.id);

    if (newUserDb.id == null || newUserDb.id < 1) {
      _showOkToast("沒有用户可被更新");
      return;
    }

    user.name ??= newUserDb.name;
    user.desc ??= newUserDb.desc;

    bool result = await _userDbUtil.update(user);

    moveToLastScreen();

    if (result) {
      _showOkToast("更新成功");
    } else {
      _showOkToast("更新失敗");
    }

  }

  void _delete() async {

    if(user.id == null || user.id < 1){
      _showOkToast("請輸入正確編號");
      return;
    }

    UserDB newUserDb = await _userDbUtil.getUser(user.id);

    if (newUserDb.id == null || newUserDb.id < 1) {
      _showOkToast("沒有用户可被刪除");
      return;
    }

    bool result = await _userDbUtil.deleteUser(user.id);

    moveToLastScreen();

    if (result) {
      _showOkToast("刪除成功");
    } else {
      _showOkToast("刪除失敗");
    }

  }

  void _saveList() async {

    if(_listUserDb.isEmpty){ // 判斷是不是指定id
      _listUserDb.addAll(await _userDbUtil.getAllUser());
      if(_listUserDb.isEmpty || _listUserDb.length < 10000){
        if(_listUserDb.length > 1){
          LogUtil.e('UserDetail lastId:${_listUserDb.last.id}');
          for(int i = _listUserDb.last.id+1; i < _listUserDb.last.id+10000; i++) {
            UserDB a = UserDB();
            a.name = '儲存';
            a.desc = '一萬筆資料';
            _listUserDb.add(a);
          }
        }else if(_listUserDb.length == 1){
          LogUtil.e('UserDetail firstId:${_listUserDb.first.id}');
          for(int i = 2; i < 10001; i++) {
            UserDB a = UserDB();
            a.name = '儲存';
            a.desc = '一萬筆資料';
            _listUserDb.add(a);
          }
        }else{
          for(int i = 0; i < 10000; i++) {
            UserDB a = UserDB();
            a.name = '儲存';
            a.desc = '一萬筆資料';
            _listUserDb.add(a);
          }
        }
      }
    }

    for (int i = 0; i < _listUserDb.length; i++) {
      if(_listUserDb[i].name == null && _listUserDb[i].desc == null){
        _showOkToast("第${_listUserDb[i].id}筆,請輸入正確保存或插入資訊");
        return;
      }else if(_listUserDb[i].name == null){
        _showOkToast("第${_listUserDb[i].id}筆,請輸入正確姓名");
        return;
      }else if(_listUserDb[i].desc == null){
        _showOkToast("第${_listUserDb[i].id}筆,請輸入正確職業");
        return;
      }
    }

    bool result = await _userDbUtil.insertUserList(_listUserDb);

    moveToLastScreen();

    if (result) {
      _showOkToast("儲存成功");
    } else {
      _showOkToast("儲存失敗");
    }

  }

  void _updateList() async {

    if (_listUserDb.isEmpty) { // 判斷是不是指定id
      _listUserDb.addAll(await _userDbUtil.getAllUser());
      if (_listUserDb.isEmpty || _listUserDb.length < 10000) {
        for (var element in _listUserDb) {
          element.name = '更新';
        }
        // _showOkToast("沒有用户可被更新");
        // return;
      }else{
        for (int i = _listUserDb.last.id-10000; i < _listUserDb.last.id; i++) {
          _listUserDb[i].name = '更新';
        }
      }
    }

    for (int i = 0; i < _listUserDb.length; i++) {
      if(_listUserDb[i].id == null && _listUserDb[i].name == null && _listUserDb[i].desc == null){
        _showOkToast("第${_listUserDb[i].id}筆,請輸入正確資訊");
        return;
      }else if(_listUserDb[i].id == null){
        _showOkToast("第${_listUserDb[i].id}筆,請輸入正確編號");
        return;
      }else if(_listUserDb[i].name == null){
        _showOkToast("第${_listUserDb[i].id}筆,請輸入正確姓名");
        return;
      }else if(_listUserDb[i].desc == null){
        _showOkToast("第${_listUserDb[i].id}筆,請輸入正確職業");
        return;
      }
    }

    // LogUtil.e('UserDetail length:${_listUserDb.length}');
    bool result = await _userDbUtil.updateUserList(_listUserDb);

    moveToLastScreen();

    if (result) {
      _showOkToast("更新成功");
    } else {
      _showOkToast("更新失敗");
    }
    // if (listString.any((string) => listId.contains(int.parse(string)))) {
    //   // Lists have at least one common element
    // } else {
    //   // Lists DON'T have any common element
    // }
  }

  void _deleteList() async {

    //LogUtil.e('UserDetail length:${_listUserDb.length}');
    List<UserDB> listNew = [];

    if (_listUserDb.isEmpty) { // 判斷是不是指定id
      _listUserDb.addAll(await _userDbUtil.getAllUser());
      if (_listUserDb.isEmpty || _listUserDb.length < 10000) {
        listNew.addAll(_listUserDb);
        // _showOkToast("沒有用户可被刪除");
        // return;
      }else{
        for (int i = _listUserDb.last.id-10000; i < _listUserDb.last.id; i++) {
          listNew.add(_listUserDb[i]);
        }
      }
    }else{
      listNew.addAll(_listUserDb);
    }

    for (int i = 0; i < listNew.length; i++) {
      if(listNew[i].id == null){
        _showOkToast("第${listNew[i].id}筆,請輸入正確編號");
        return;
      }
    }

    bool result = await _userDbUtil.deleteUserList(listNew);

    moveToLastScreen();

    if (result) {
      _showOkToast("刪除成功");
    } else {
      _showOkToast("刪除失敗");
    }

  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void _showOkToast(String message, {ToastPosition? toastPosition}){
    showToast(message, position: toastPosition);
  }

}