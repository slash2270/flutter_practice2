// @dart = 2.9
// 創建一個Node類,表示一個節點

class Node1 {

  int no; // 編號
  Node1 next; // 指向下一個節點

  Node1({this.no});

  Node1 getNext() => next;
  void setNext(Node1 next) => this.next = next;

  int getNo() => no;
  void setNo(int no) => this.no = no;

}