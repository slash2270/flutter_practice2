// @dart = 2.9

//定義SingleLinkedList 管理英雄
import 'package:common_utils/common_utils.dart';
import 'hero_node.dart';
import 'stack_model.dart';

class SingleLinkedList {
  //先初始化一個頭節點,頭節點不要動,不存放具體數據
  HeroNode head = HeroNode(no: 0, name: '', nickname: '');

  HeroNode getHead() {
    return head;
  }

  //求鏈結串列中有效節點的個數
  int getLength(HeroNode head) {
    if(head.next == null)  return 0;
    int length = 0;
    HeroNode cur = head.next;
    while(cur != null) {
      length++;
      cur = cur.next;
    }
    return length;
  }

  /// 編寫一個方法，接收head節點，同時接收一個index
  /// index表示的是倒數第index個節點
  /// 先把鏈結串列從頭到尾遍歷，得到鏈結串列的總長度 getLength() => size
  /// 得到size後，從鏈結串列第一個開始遍歷 size - index個
  /// 如果找到則返回該節點，否則返回null
  //查找倒數第n個節點
  HeroNode findLastIndexNode(HeroNode head,int index) {
    if (head.next == null) return null;
    int size = getLength(head);
    if (index <= 0 || index > size) return null;
    HeroNode cur = head.next;
    for(int i=0; i< size-index; i++) {
      cur = cur.next;
    }
    return cur;
  }

  /// 先定義一個節點 reverseHead = new HeroNode();
  /// 從頭到尾遍歷原來的鏈結串列，每遍歷一個節點就將其取出並放在新的鏈結串列reverseHead 的最前端
  /// 原來的鏈結串列的 head.next = reverseHead.next;
  //鏈結串列的反轉
  void reverseList(HeroNode head) {
    //如果鏈結串列為空或者只有一個就無需反轉
    if(head.next == null || head.next.next == null) return;

    //輔助指針 幫助我們遍歷原來的鏈結串列
    HeroNode cur = head.next; //第一筆數據
    HeroNode next; //指向cur的下一個節點;
    HeroNode reverseHead = HeroNode(no:0, name: "", nickname: "");

    //遍歷原來的鏈結串列,每遍歷一個節點就將其取出並放在reverseHead的最前端
    while(cur != null) {
      next = cur.next; //先保留當前節點的下一個節點
      cur.next = reverseHead.next; //將cur的下一個節點指向新的鏈結串列最前端
      reverseHead.next = cur; //將cur連結到新的鏈結串列上
      cur = next; //讓 cur 後移遍歷
    }

    //將head.next 指向 reverseHead.next
    head.next = reverseHead.next;
  }

  /// 上面的題目要求就是逆序輸出鏈結串列
  /// 方法1: 先將鏈結串列進行反轉操作然後遍歷即可，這樣做的問題是會破壞原來鏈結串列的結構，不建議使用。
  /// 方法2：可以利用棧(Stack)這個資料結構，將各個節點push到棧中，利用棧的先進後出特點實現逆序輸出效果。
  //從尾到頭列印鏈結串列
  //逆序單向鏈結串列
  String reverseStack(HeroNode head) {
    String s = '';
    if(head.next == null) return s;
    StackQueue<HeroNode> stack = StackQueue<HeroNode>();
    //創建一個stack將各個節點push進stack中
    HeroNode cur = head.next;
    while(cur != null) {
      stack.push(cur);
      cur = cur.next;
    }
    //將stack中節點輸出
    while(stack.length > 0) {
      s += "${stack.pop()}";
    }
    // LogUtil.e("singleLinkedList stack:${s}");
    return s;
  }

  //添加節點到單向鏈結串列
  //思路:當不考慮編號順序時
  //1.找到當前鏈結串列的最後節點
  //2.將最後節點的next域指向新的節點
  void add(HeroNode heroNode) {

    //因為head節點不能動,因此我們需要一個輔助遍歷 temp
    HeroNode temp = head;
    //遍歷鏈結串列,找到最後
    while(true) {
      if (temp.next == null) {
        break;
      }
      temp = temp.next; //沒找到就將temp後移一個節點
    }
    //當退出while循環時,temp就指向了鏈結串列的最後
    //將最後這個節點的next指向新的節點
    temp.next = heroNode;
  }

  void addByOrder(HeroNode heroNode) {

    //因為頭節點不能動,因此仍用輔助變數來幫助找到添加的位置
    //因為是單向鏈結串列，所以temp是位於添加位置的前一個節點
    HeroNode temp = head;
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
      LogUtil.e("singleLinkedList 準備添加的英雄編號${heroNode.no}已經存在，不能添加\n");
    }else{
      //插入到鏈結串列中, temp的後面
      heroNode.next = temp.next;
      temp.next = heroNode;
    }

  }

  //顯示鏈結串列
  String list() {
    String s = '';

    if (head.next == null) {
      // LogUtil.e("singleLinkedList list:鏈結串列為空");
      s += 'next = null';
      return s;
    }

    HeroNode temp = head.next;
    while (true) {
      if (temp != null) {
        //輸出節點訊息
        LogUtil.e("singleLinkedList temp:$temp");
        s += temp.toString();
        //將temp後移, 不然是死循環
        temp = temp.next;
      } else {
        s += '\tnext = null\n';
        break;
      }
    }

    return s;
  }

  //修改節點的資訊,根據編號來修改
  void update(HeroNode newHeroNode) {
    if(head.next == null) {
      LogUtil.e("singleLinkedList list:鏈結串列為空");
      return;
    }

    //找到需要修改的節點
    //定義一個輔助變數
    HeroNode temp = head.next;
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
      LogUtil.e("singleLinkedList list:沒有找到編號${newHeroNode.no}的節點,不能修改\n");
    }

  }

  void delete(HeroNode heroNode) {
    HeroNode temp = head;
    bool flag = false;

    while(true) {
      if (temp.next == null) break;
      if(temp.next.no == heroNode.no) {
        flag = true;
        break;
      }
      temp = temp.next;
    }

    if(flag) {
      LogUtil.e("singleLinkedList list:刪除了編號${heroNode.no}的節點\n");
      temp.next = temp.next.next;
    } else {
      LogUtil.e("singleLinkedList list:要刪除的節點${heroNode.no}不存在\n");
    }

  }

}