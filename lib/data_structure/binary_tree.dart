// @dart = 2.9

import 'package:common_utils/common_utils.dart';

import 'hero_node3.dart';

class BinaryTree {

  HeroNode3 root;

  HeroNode3 getRoot(){
    return root;
  }

  void setRoot(HeroNode3 root) {
    this.root = root;
  }

  preOrder() {
    if(root != null) {
      root.preOrder();
    } else {
      "二元樹為空";
    }
  }

  inOrder() {
    if(root != null) {
      root.inOrder();
    } else {
      "二元樹為空";
    }
  }

  postOrder() {
    if(root != null) {
      root.postOrder();
    } else {
      "二元樹為空";
    }
  }

  // 前序搜尋
  HeroNode3 preOrderSearch(int no) {
    if(root != null) {
      return root.preOrderSearch(no);
    } else {
      return null;
    }
  }

  // 中序搜尋
  HeroNode3 infixOrderSearch(int no) {
    if(root != null) {
      return root.infixOrderSearch(no);
    } else {
      return null;
    }
  }

  // 後序搜尋
  HeroNode3 postOrderSearch(int no) {
    if(root != null) {
      return root.postOrderSearch(no);
    } else {
      return null;
    }
  }

  // 刪除節點
  void deleteNode(int no) {
    if(root != null) {
      // 如果只有一個root節點, 需要判斷root是不是就是要刪除的節點
      if(root.no == no) {
        root = null;
      } else {
        // 遞迴刪除
        root.deleteNode(no);
      }
    } else {
      LogUtil.e("BinaryTree delete:空樹");
    }
  }

}