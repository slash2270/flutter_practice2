// @dart = 2.9

import 'package:common_utils/common_utils.dart';

class TreeNode{
  // // 1. 如果 leftType = 0 表示指向左子樹 , leftType = 1 表示指向前驅節點
  // // 2. 如果 rightType = 0 表示指向右子樹 , rightType = 1 表示指向後繼節點
  // String name;
  // int no,leftType,rightType;
  // TreeNode left, right;
  //
  // TreeNode(this.no, this.name);
  //
  // int getNo() {
  //   return no;
  // }
  //
  // void setNo(int no) {
  //   this.no = no;
  // }
  //
  // String getName() {
  //   return name;
  // }
  //
  // void setName(String name) {
  //   this.name = name;
  // }
  //
  // TreeNode getLeft() {
  //   return left;
  // }
  //
  // void setLeft(TreeNode left) {
  //   this.left = left;
  // }
  //
  // TreeNode getRight() {
  //   return right;
  // }
  //
  // void setRight(TreeNode right) {
  //   this.right = right;
  // }
  //
  // int getLeftType() {
  //   return leftType;
  // }
  //
  // void setLeftType(int leftType) {
  //   this.leftType = leftType;
  // }
  //
  // int getRightType() {
  //   return rightType;
  // }
  //
  // void setRightType(int rightType) {
  //   this.rightType = rightType;
  // }
  //
  // @override
  // String toString() {
  //   return "TreeNode[no=$no,name=$name]\n";
  // }
  int no;
  String name;
  TreeNode left;
  TreeNode right;
  // 1. 如果 leftType = 0 表示指向左子樹 , leftType = 1 表示指向前驅節點
  // 2. 如果 rightType = 0 表示指向右子樹 , rightType = 1 表示指向後繼節點
  int leftType;
  int rightType;

  TreeNode(this.no, this.name);

  int getLeftType() {
    return leftType;
  }

  void setLeftType(int leftType) {
    this.leftType = leftType;
  }

  int getRightType() {
    return rightType;
  }

  void setRightType(int rightType) {
    this.rightType = rightType;
  }

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

  TreeNode getLeft() {
    return left;
  }

  void setLeft(TreeNode left) {
    this.left = left;
  }

  TreeNode getRight() {
    return right;
  }

  void setRight(TreeNode right) {
    this.right = right;
  }

  @override
  String toString() {
    return "TreeNode[no=$no,name=$name]\n";
  }

  // 遞迴刪除節點
  void deleteNode(int no) {
    // 如果當前節點的左子節點不為空，並且左子節點就是要刪除節點，就將 this.left = null; 並且就返回(結束遞迴刪除)
    if (left != null && left.no == no) {
      left = null;
      return;
    }
    // 如果當前節點的右子節點不為空，並且右子節點就是要刪除節點，就將this.right = null; 並且就返回(結束遞迴刪除)
    if (right != null && right.no == no) {
      right = null;
      return;
    }
    // 如果前面兩步都沒有刪除節點，就需要向左子樹進行遞迴刪除
    if (left != null) {
      left.deleteNode(no);
    }
    // 如果上一步也沒有刪除節點，則應向右子樹進行遞迴刪除
    if (right != null) {
      right.deleteNode(no);
    }
  }

  void preOrder() {
    LogUtil.e("TreeNode ${this}");
    if (left != null) {
      left.preOrder();
    }
    if (right != null) {
      right.preOrder();
    }
  }

  void inOrder() {
    if (left != null) {
      left.inOrder();
    }
    LogUtil.e("TreeNode ${this}");
    if (right != null) {
      right.inOrder();
    }
  }

  void postOrder() {
    if (left != null) {
      left.postOrder();
    }
    if (right != null) {
      right.postOrder();
    }
    LogUtil.e("TreeNode ${this}");
  }

  // 前序遍歷搜尋
  TreeNode preOrderSearch(int no) {
    LogUtil.e("TreeNode 前序遍歷 1 次");
    if (this.no == no) {
      return this;
    }
    // 1.判斷當前節點的左子節點是否為空, 如果不為空則遞迴前序搜尋
    // 2.如果左遞迴前序搜尋, 找到節點就返回
    TreeNode resNode;
    if (left != null) {
      resNode = left.preOrderSearch(no);
    }

    if (resNode != null) {
      // 說明左子樹找到
      return resNode;
    }
    // 1.左遞迴前序搜尋, 找到節點就返回, 否則繼續判斷
    // 2.當前節點的右子節點是否為空, 如果不空, 則繼續向右遞迴前序搜尋
    if (right != null) {
      resNode = right.preOrderSearch(no);
    }

    return resNode;
  }

  // 中序遍歷搜尋
  TreeNode infixOrderSearch(int no) {
    // 判斷當前節點的左子節點是否為空, 如果不為空則遞迴中序搜尋
    TreeNode resNode;
    if (left != null) {
      resNode = left.infixOrderSearch(no);
    }
    if (resNode != null) {
      return resNode;
    }

    LogUtil.e("TreeNode 中序遍歷 1 次"); // 計算遍歷了幾次才找到
    // 如果找到則返回, 沒找到就和當前節點比較, 如果是則返回當前節點
    if (this.no == no) {
      return this;
    }

    // 否則繼續右遞迴中序搜尋
    if (right != null) {
      resNode = right.infixOrderSearch(no);
    }

    return resNode;
  }

  // 後序遍歷搜尋
  TreeNode postOrderSearch(int no) {
    // 判斷當前節點的左子節點是否為空, 如果不為空則遞迴後序搜尋
    TreeNode resNode;
    if (left != null) {
      resNode = left.postOrderSearch(no);
    }
    if (resNode != null) {
      return resNode;
    }

    // 否則繼續右遞迴後序搜尋
    if (right != null) {
      resNode = right.postOrderSearch(no);
    }

    if (resNode != null) {
      return resNode;
    }
    LogUtil.e("TreeNode 後序遍歷 1 次"); // 計算遍歷了幾次才找到

    if (this.no == no) {
      return this;
    }

    return resNode;
  }

}