// @dart = 2.9

import 'package:common_utils/common_utils.dart';
import 'package:meta/meta.dart';

import 'hero_node2.dart';

class DoubleLinkedList {
  //先初始化一個頭節點,頭節點不要動,不存放具體數據
  HeroNode2 head = HeroNode2(no:0, name: "", nickname: "");
  HeroNode2 getHead() {
    return head;
  }

  //遍歷雙向鏈結串列
  String list() {
    String s = '';
    if(head.next == null) {
      LogUtil.e("doubleLinkedList list:鏈結串列為空");
      return s;
    }
    HeroNode2 temp = head.next;
    while(true) {
      if(temp == null) {
        break;
      }
      //輸出節點訊息
      s += temp.toString();
      LogUtil.e("doubleLinkedList temp:$temp");
      //將temp後移, 不然是死循環
      temp = temp.next;
    }
    return s;
  }

  //添加數據到雙向鏈結串列的最後
  void add(HeroNode2 heroNode) {
    //因為head節點不能動,因此我們需要一個輔助遍歷 temp
    HeroNode2 temp = head;
    //遍歷鏈結串列,找到最後
    while(true) {
      if (temp.next == null) {
        break;
      }

      temp = temp.next; //沒找到就將temp後移一個節點
    }
    //當退出while循環時,temp就指向了鏈結串列的最後
    //形成一個雙向鏈結串列
    temp.next = heroNode;
    heroNode.prev = temp;
  }

  void addByOrder(HeroNode2 heroNode) {
    HeroNode2 temp = head;
    bool flag = false; //添加的編號是否已經存在

    while(true) {
      if(temp.next == null) break;
      if(temp.next.no > heroNode.no) { //位置找到, 就在temp的後面插入
        break;
      }else if(temp.next.no == heroNode.no) { //編號已經存在
        flag = true;
        break;
      }
      temp = temp.next;
    }

    //判斷flag的值
    if(flag) {
      LogUtil.e("doubleLinkedList 準備添加的英雄編號${heroNode.no}已經存在，不能添加\n");
    }else{
      heroNode.next = temp.next;
      temp.next = heroNode;
      heroNode.prev = temp;
    }
  }

  //修改節點內容
  void update(HeroNode2 newHeroNode) {
    if(head.next == null) {
      LogUtil.e("doubleLinkedList update:鏈結串列為空");
      return;
    }
    //找到需要修改的節點
    //定義一個輔助變數
    HeroNode2 temp = head.next;
    bool flag = false; //是否找到該節點
    while(true) {
      if (temp == null) break; //已遍歷結束
      if (temp.no == newHeroNode.no) { //找到
        flag = true;
        break;
      }
      temp = temp.next;
    }
    //根據flag 判斷是否找到
    if(flag) {
      temp.name = newHeroNode.name;
      temp.nickname = newHeroNode.nickname;
    }else {
      LogUtil.e("doubleLinkedList update:沒有找到編號${newHeroNode.no}的節點,不能修改\n");
    }
  }

  //刪除節點
  void delete(int no) {
    HeroNode2 temp = head.next;
    bool flag = false;
    if(head.next == null) {
      LogUtil.e("doubleLinkedList delete:鏈結串列為空,無法刪除");
      return;
    }
    while(true) {
      if (temp == null) break; //已遍歷結束
      if(temp.no == no) { //要刪除的節點為第一個節點
        flag = true;
        break;
      }
      temp = temp.next;
    }

    if(flag) {
      temp.prev.next = temp.next;
      //如果是最後一個節點就不需要執行下面這句話,否則會出現空指針異常
      if(temp.next != null) {
        temp.next.prev = temp.prev;
      }
      LogUtil.e("doubleLinkedList delete:刪除了$no的節點\n");
    }else {
      LogUtil.e("doubleLinkedList delete:沒有找到編號$no 的節點,不能刪\n");
    }
  }

}