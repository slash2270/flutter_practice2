// @dart = 2.9
// 創建Node節點
import 'package:common_utils/common_utils.dart';

class Node2 {
  int value;
  Node2 left; // 左子樹
  Node2 right; // 右子樹
  Node2(this.value);

  @override
  String toString() {
    return "Node2 [value = $value]";
  }

  // 用遞迴的形式添加節點的方法
  void add(Node2 node) {
    if(node == null) return;
    // 判斷傳入的節點的值, 和當前根節點的值的關係
    if(node.value < value) {
      // 如果當前節點左子節點為空
      if(left == null) {
        left = node;
      } else {
        // 遞迴的向左子樹添加
        left.add(node);
      }
    } else { // 添加的節點大於等於當前節點
      if(right == null) {
        right = node;
      } else {
        // 遞迴的向右子樹添加
        right.add(node);
      }
    }
  }

  // 中序遍歷
  void infixOrder() {
    if(left != null) {
      left.infixOrder();
    }
    LogUtil.e("${this}");
    if(right != null) {
      right.infixOrder();
    }
  }

  // 搜尋要刪除的節點
  /// @param value 希望刪除的節點的值
  /// @return 如果找到返回該節點, 否則返回null
  Node2 search(int value) {
    if(value == this.value) { // 找到該節點
      return this;
    } else if(value < this.value) { // 如果搜尋的值小於當前節點, 向左子樹遞迴搜尋
      // 如果左子節點為空
      if(left == null) return null;
      return left.search(value);
    } else {
      // 如果右子節點為空
      if(right == null) return null;
      return right.search(value);
    }
  }

  // 搜尋要刪除節點的父節點
  /// @param value 要找的節點的值
  /// @return 返回的是要刪除的節點的父節點, 如果沒有則返回null
  Node2 searchParent(int value) {
    // 如果當前節點就是要刪除節點的父節點, 就返回
    if((left != null && left.value == value) || (right != null && right.value == value)) {
      return this;
    } else {
      // 如果搜尋的值小於當前節點的值, 並且當前節點的左子節點不為空
      if(value < this.value && left != null) {
        return left.searchParent(value); // 向左子樹遞迴搜尋
      } else if(value >= this.value && right != null) {
        return right.searchParent(value); // 向右子樹遞迴搜尋
      } else {
        return null; // 沒有找到父節點
      }
    }
  }

}