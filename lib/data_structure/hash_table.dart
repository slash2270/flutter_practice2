// @dart = 2.9
//Hash Table 管理多條鏈結串列
import 'package:flutter_practice2/data_structure/emp_linked_list.dart';
import '../az_listview/common/index.dart';
import 'emp.dart';

class HashTable {
  int size;
  List<EmpLinkedList> empLinkedListArray;

  ///@param size 多少條鏈結串列
  HashTable(this.size){
    final empLinkedList = EmpLinkedList();
    // 初始化 empLinkedListArray
    empLinkedListArray = List.filled(size, empLinkedList);
    // 分別初始化每個鏈結串列
    for(int i = 0; i < size; i++) {
      empLinkedListArray[i] = empLinkedList;
    }
  }

  // 添加員工
  void add(Emp emp) {
    //int empLinkedListNum = hashFun(emp.id);
    // 將 emp 添加到對應鏈結串列中
    // LogUtil.e("Emp add:${emp.id} ${emp.name}");
    empLinkedListArray[emp.id - 1].add(emp);
  }

  String s = '';
  // 遍歷所有鏈結串列, 遍歷hash table
  String list() {
    String s = '';
    for(int i = 0; i < size; i++) {
      s += empLinkedListArray[i].list(i);
      LogUtil.e("HashTable list:$s");
    }
    return s;
  }

  // 根據id搜尋員工
  String findById(int id) {
    String s = '';
    // 使用雜湊函數確定到哪條鏈結串列搜尋
    // int empLinkedListNum = hashFun(id);
    Emp emp = empLinkedListArray[id - 1].findById(id);
    if(emp != null) {
      s += "在第$id條鏈結串列中找到員工id = $id , name = ${emp.name}\n";
      // LogUtil.e("HashTable 在第${empLinkedListNum + 1}條鏈結串列中找到員工id = $id , name = ${emp.name} a\n");
    } else {
      s += "在雜湊表中沒有找到該員工資訊";
      // LogUtil.e("HashTable 在雜湊表中沒有找到該員工資訊");
    }
    return s;
  }

  // 刪除員工資訊
  String deleteById(int id) {
    String s = '';
    // 先找到 id 所屬的鏈結串列
    // int no = hashFun(id);
    // 判斷 no 值是否大於或小於範圍
    if (id > size || id < 0) {
      s += "id = $id範圍錯誤\n";
      // LogUtil.e("HashTable id = $id 範圍錯誤\n");
      return null;
    }
    Emp emp = empLinkedListArray[id - 1].deleteById(id);
    if (emp == null) {
      s += "在第$id條鏈結串列中找到 id = $id的員工, 删除失敗!\n";
      // LogUtil.e("HashTable 在第$id條鏈結串列中找到 id = $id的員工, 删除失敗!\n");
    } else {
      s += "在第$id條鏈結串列中找到 id = ${emp.id}的員工, name = ${emp.name}, 删除成功!\n";
      // LogUtil.e("HashTable 在第$id條鏈結串列中找到 id = $id的員工, name = ${emp.name}, 删除成功!\n");
    }
    return s;
  }

  // 編寫雜湊函數, 使用簡單的取模法
  int hashFun(int id) {
    return id % size;
  }

}