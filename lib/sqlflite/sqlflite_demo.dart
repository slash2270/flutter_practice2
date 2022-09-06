// @dart = 2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/sqlflite/user_db.dart';
import 'package:flutter_practice2/sqlflite/user_db_util.dart';
import 'package:flutter_practice2/sqlflite/user_detail.dart';

import '../util/function_util.dart';

class SqlFLiteDemo extends StatefulWidget {
  const SqlFLiteDemo({Key key}) : super(key: key);

  @override
  createState() => SqlFLiteDemoState();
}

class SqlFLiteDemoState extends State<SqlFLiteDemo> {
  UserDbUtil provider = UserDbUtil();
  List<UserDB> userList;
  int count = 0;  //在为被初始化前item的数量为0

  @override
  Widget build(BuildContext context) {
    if(userList == null) {
      userList = [];
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('SqlFLite Demo'),
      ),
      body: getListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(UserDB());
        },
        child:const Icon(Icons.add),
      ),
    );
  }

  Widget getListView() {
    return userList.isNotEmpty ? ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 3.0,
            child: ListTile(
              leading: Text(position.toString()),
              title: Text(userList[position].id.toString()),
              subtitle: Text('${userList[position].name}\n${userList[position].desc}'),
              trailing: GestureDetector(
                child: const Icon(Icons.delete, color: Colors.red,),
                onTap: () {
                  _delete(context, userList[position]);
                },
              ),
              onTap: () {
                navigateToDetail(userList[position]);
              },
            ),
          );
        }
    ) : Center(
      child: FunctionUtil().initText2('請按+鍵至下一頁新增數據！', Colors.black, Colors.transparent, 30),
    );
  }

  //跳转到编辑添加数据页面
  void navigateToDetail(UserDB user) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) {
      return UserDetail(user);
    }));
    // LogUtil.e("UserDb result:$result");
    if(result ==true){
      updateListView();
    }
  }

  //删除某条数据
  void _delete(BuildContext context, UserDB user) async {
    // LogUtil.e("UserDb delete id :$id");
    bool result = await provider.deleteUser(user.id);
    // LogUtil.e("UserDb delete result :$result");
    if (result) {
      updateListView(); //删除成功后更新列表
    }
  }

  void updateListView() {
    Future<List<UserDB>> listUsersFuture = provider.getAllUser();
    listUsersFuture.then((userList) {
      setState(() {
        this.userList = userList;
        count = userList.length;
        // for (var element in userList) {
        //   LogUtil.e("UserDb list:${element.id} ${element.name} ${element.desc}");
        // }
      });
    });
  }

}