// 創建一個環形的單向鏈結串列
import 'package:common_utils/common_utils.dart';

import 'Node.dart';

class CircularSingleLinkedList {
  // 創建一個first節點, 當前沒有編號
  Node first = Node(no: -1);

  // 添加節點, 構建成一個環形的鏈結串列
  void addNode(int numS) {
    // numS 數據校驗
    if (numS < 1) {
      LogUtil.e("CircularSingleLinkedList addNode:num值不正確!\n");
    }
    Node cur = Node(); // 輔助變數 幫助構建環形鏈結串列
    // 使用for循環創建環形鏈結串列
    for (int i = 1; i <= numS; i++) {
      // 根據編號創建節點
      Node child = Node(no: i);
      // 若為第一個節點
      if (i == 1) {
        first = child;
        first.setNext(first); // 構成環
        cur = first; // 讓cur 指向第一個節點
      } else {
        cur.setNext(child);
        child.setNext(first);
        cur = child;
      }
    }
  }

  // 遍歷當前環形鏈結串列
  String showNode() {
    String s = '';
    // 判斷鏈結串列是否為空
    if (first == null) {
      s += "鏈結串列為空\n";
      LogUtil.e("CircularSingleLinkedList showNode:鏈結串列為空\n");
      return s;
    }
    // 因為 first不能動,因此需要使用一個輔助指針
    Node cur = first;
    while (true) {
      if(cur.no == 41) {
        s += "節點編號${cur.getNo()}\n";
      }else{
        s += "節點編號${cur.getNo()}\t";
      }
      LogUtil.e("CircularSingleLinkedList showNode:節點編號${cur.getNo()}\n");
      if (cur.getNext() == first) { // 遍歷完畢
        break;
      }
      cur = cur.getNext(); // 往後遍歷
    }
    return s;
  }

  /// @param startNo  表示從第幾個node開始數
  /// @param countNum 表示數幾次
  /// @param numS     表示最初有多少個node在環中
  //根據使用者的輸入,計算出節點出隊列的順序
  String countNode(int startNo, int countNum, int numS) {
    String s = '';
    if (first == null || startNo < 1 || startNo > numS) {
      s += "CircularSingleLinkedList countNode:參數輸入有誤，請重新輸入\n";
      LogUtil.e("CircularSingleLinkedList countNode:參數輸入有誤，請重新輸入\n");
      return s;
    }
    // 創建一個輔助指針,幫助完成node出隊列
    Node helper = first;
    while (true) {
      if (helper.getNext() == first) { // helper指向最後一個節點
        break;
      }
      helper = helper.getNext();
    }

    //先讓first和helper 移動startNo-1次
    for (int j = 0; j < startNo - 1; j++) {
      first = first.getNext();
      helper = helper.getNext();
    }

    List<int> list = [];

    //當節點報數時，讓first和helper指針同時移動 countNum- 1次 然後出隊列
    while(true) {
      if(helper == first) {
        //說明環中只有一個node
        s += "節點${first.getNo()}出隊列\n";
        break;
      }
      //讓 first和helper同時移動 countNum -1次
      for (int i = 0; i < countNum -1; i++) {
        first = first.getNext();
        helper = helper.getNext();
      }
      //這時 first 指向的節點就是 要出隊列 的節點
      s += "節點${first.getNo()}出隊列\t";
      LogUtil.e("CircularSingleLinkedList countNode:節點${first.getNo()}出隊列\n");
      //將first指向的節點出隊列
      first = first.getNext(); //出隊列後往下一個節點繼續數
      helper.setNext(first); //把helper歸回第一個數的節點繼續遍歷
      list.add(first.getNo());
    }
    s += "最後留在環中的節點為${list[list.length - 2]},${list[list.length - 1]}";
    LogUtil.e("CircularSingleLinkedList countNode:最後留在環中的節點為${list[list.length - 2]},${list[list.length - 1]}");
    return s;
  }
}