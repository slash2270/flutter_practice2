// @dart = 2.9

// 先創建 HeroNode 節點
import '../az_listview/common/index.dart';

class HeroNode3 {

  int no;
  String name;
  HeroNode3 left;
  HeroNode3 right;

  HeroNode3(this.no, this.name);

  int getNo() {
    return no;
  }

  void setNo(int no) {
    this.no = no;
  }

  String getName() {
    return name;
  }

  void setName(String name) {
    this.name = name;
  }

  HeroNode3 getLeft() {
    return left;
  }

  void setLeft(HeroNode3 left) {
    this.left = left;
  }

  HeroNode3 getRight() {
    return right;
  }

  void setRight(HeroNode3 right) {
    this.right = right;
  }

  @override
  String toString() {
    return "HeroNode3[no=$no,name=$name]\n";
  }

  preOrder() {
    LogUtil.e("HeroNode3 preOrder:${this}");
    if (left != null) {
      left.preOrder();
    }
    if (right != null) {
      right.preOrder();
    }
  }

  inOrder() {
    if (left != null) {
      left.inOrder();
    }
    LogUtil.e("HeroNode3 inOrder:${this}");
    if (right != null) {
      right.inOrder();
    }
  }

  postOrder() {
    if (left != null) {
      left.postOrder();
    }
    if (right != null) {
      right.postOrder();
    }
    LogUtil.e("HeroNode3 postOrder:${this}");
  }

  // 前序遍歷搜尋
  HeroNode3 preOrderSearch(int no) {
    LogUtil.e("HeroNode3 前序遍歷 1 次"); // 計算遍歷了幾次才找到

    if(this.no == no) {
      return this;
    }
    // 1.判斷當前節點的左子節點是否為空, 如果不為空則遞迴前序搜尋
    // 2.如果左遞迴前序搜尋, 找到節點就返回
    HeroNode3 resNode;
    if(left != null) {
      resNode = left.preOrderSearch(no);
    }

    if(resNode != null) { // 說明左子樹找到
      return resNode;
    }

    // 1.左遞迴前序搜尋, 找到節點就返回, 否則繼續判斷
    // 2.當前節點的右子節點是否為空, 如果不空, 則繼續向右遞迴前序搜尋
    if(right != null) {
      resNode = right.preOrderSearch(no);
    }

    return resNode;
  }

  // 中序遍歷搜尋
  HeroNode3 infixOrderSearch(int no) {
    // 判斷當前節點的左子節點是否為空, 如果不為空則遞迴中序搜尋
    HeroNode3 resNode;
    if(left != null) {
      resNode = left.infixOrderSearch(no);
    }
    if(resNode != null) {
      return resNode;
    }

    LogUtil.e("HeroNode3 中序遍歷 1 次"); // 計算遍歷了幾次才找到
    // 如果找到則返回, 沒找到就和當前節點比較, 如果是則返回當前節點
    if(this.no == no) {
      return this;
    }

    // 否則繼續右遞迴中序搜尋
    if(right != null) {
      resNode = right.infixOrderSearch(no);
    }

    return resNode;
  }

  // 後序遍歷搜尋
  HeroNode3 postOrderSearch(int no) {
    // 判斷當前節點的左子節點是否為空, 如果不為空則遞迴後序搜尋
    HeroNode3 resNode;
    if(left != null) {
      resNode = left.postOrderSearch(no);
    }

    if(resNode != null) {
      return resNode;
    }

    // 否則繼續右遞迴後序搜尋
    if(right != null) {
      resNode = right.postOrderSearch(no);
    }

    if(resNode != null) {
      return resNode;
    }

    LogUtil.e("HeroNode3 後序遍歷 1 次"); // 計算遍歷了幾次才找到

    if(this.no == no) {
      return this;
    }

    return resNode;
  }

  // 遞迴刪除節點
  void deleteNode(int no) {
    // 如果當前節點的左子節點不為空，並且左子節點就是要刪除節點，就將 this.left = null; 並且就返回(結束遞迴刪除)
    if(left != null && left.no == no) {
      left = null;
      return;
    }

    // 如果當前節點的右子節點不為空，並且右子節點就是要刪除節點，就將this.right = null; 並且就返回(結束遞迴刪除)
    if(right != null && right.no == no) {
      right = null;
      return;
    }

    // 如果前面兩步都沒有刪除節點，就需要向左子樹進行遞迴刪除
    if(left != null) {
      left.deleteNode(no);
    }

    // 如果上一步也沒有刪除節點，則應向右子樹進行遞迴刪除
    if(right != null) {
      right.deleteNode(no);
    }
  }

}