// @dart = 2.9
//某個頂點的鄰接點的相關資訊
class Node3 {
  int index = 0; //代表此Node在vertex陣列中的序號
  double weight = 0.0; //頂點與此鄰接點的邊的權值
  Node3 nextNode; //點的下一個鄰接點
}