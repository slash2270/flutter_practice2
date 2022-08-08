// @dart = 2.9
// 創建一個Node類,表示一個節點
class Node {
  int no; // 編號
  Node next; // 指向下一個節點

  Node({this.no});

  Node getNext() => next;
  void setNext(Node next) => this.next = next;

  int getNo() => no;
  void setNo(int no) => this.no = no;
}