// @dart = 2.9

import 'package:common_utils/common_utils.dart';
import 'emp.dart';

class EmpLinkedList {
  // 頭節點 指向第一個 Emp, 這個鏈結串列的 head 是直接指向第一個員工
  Emp head; // 默認null

  // 添加員工到鏈結串列
  // 1. 假定添加員工時 id 自增長 , id 的分配從小到大
  //    因此我們將該員工直接加入到本鏈結串列的最後即可
  void add(Emp emp) {
    // 如果是添加第一個員工
    if(head == null) {
      head = emp;
      return;
    }
    // 如果不是第一個員工, 則使用第一個輔助的指針, 幫助定位到最後
    Emp curEmp = head;
    while(true) {
      if(curEmp.next == null) { // 說明到鏈結串列最後
        break;
      }
      curEmp = curEmp.next;
    }

    // 退出時直接將emp 加入鏈結串列
    curEmp.next = emp;
  }

  // 遍歷鏈結串列的員工資訊
  String list(int no) {
    String s = '';
    if(head == null){
      s += "第${no+1}鏈結串列為空";
      //LogUtil.e("Emp 第${no+1}鏈結串列為空");
      return s;
    }
    s += "第${no+1}鏈結串列資訊為:";
    // LogUtil.e("第${no+1}鏈結串列資訊為");
    Emp curEmp = head;
    while(true) {
      s += "id = ${curEmp.id} name = ${curEmp.name}\t";
      // LogUtil.e("EmpLinkedList list => id = ${curEmp.id} , name = ${curEmp.name}\t");
      if(curEmp.next == null){ //curEmp為最後節點
        break;
      }
      curEmp = curEmp.next;
    }
    s += "\n";
    LogUtil.e("\n");
    return s;
  }

  // 根據 id 搜尋員工
  // 搜尋到就返回Emp, 沒有則返回null
  Emp findById(int id) {
    Emp curEmp = Emp(id: 0, name: '');
    if(head.next == null) {
      LogUtil.e("Emp findEmpById 鏈結串列為空");
      return curEmp;
    }
    curEmp = head;
    while(true) {
      if(curEmp.id == id) {
        break;
      }
      // 遍歷結束沒找到 退出
      if(curEmp.next == null) {
        break;
      }
      curEmp = curEmp.next;
    }
    return curEmp;
  }

  // 刪除元素
  Emp deleteById(int id) {
    if (head == null) {
      return null;
    }
    // 非空的鏈結串列才需要循環
    Emp temp = head;
    Emp prev = head;
    while (true) {
      if (temp.id == id) {
        // 找到要刪除的元素
        break;
      }
      if (temp.next == null) {
        // 當前節點的為最末尾
        temp = null;
        break;
      }
      prev = temp;  // 將 prev 指向當前節點
      temp = temp.next; // 將當前節點後移 繼續遍歷
    }

    // 沒有找到要刪除的元素
    if (temp == null) {
      return null;
    }
    // head 為要刪除的節點
    if (head == temp) {
      head = temp.next;
      return temp;
    }
    // 找到要刪除的元素 temp, 將 prev.next 指向 temp.next
    prev.next = temp.next;
    return temp;
  }

}