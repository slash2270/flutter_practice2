// @dart = 2.9

import 'package:common_utils/common_utils.dart';
import 'package:flutter_practice2/data_structure/tree_node.dart';

class ThreadedBinaryTree {
  // TreeNode prev, root;
  //
  // void setRoot(TreeNode root) {
  //   this.root = root;
  // }
  //
  // /// @param node 當前需要線索化的節點
  // //對二元樹進行中序線索化的方法
  // void inThreadedNodes(TreeNode node) {
  //   if (node == null) {
  //     return;
  //   }
  //
  //   // 1. 先線索化左子樹
  //   inThreadedNodes(node.getLeft());
  //   // 2. 線索化當前節點
  //   // 處理當前節點的前驅節點
  //   if (node.getLeft() == null) {
  //     // 讓當前節點的左指針指向前驅節點
  //     node.setLeft(prev);
  //     // 修改當前節點的左指針類型
  //     node.setLeftType(1);
  //   }
  //   // 處理後繼節點
  //   if (prev != null && prev.getRight() == null) {
  //     // 讓前驅節點的右指針指向當前節點
  //     prev.setRight(node);
  //     // 修改當前節點的右指針類型
  //     prev.setRightType(1);
  //   }
  //   // 每處理一個節點後, 讓當前節點是下一個節點的前驅節點
  //   prev = node;
  //   // 3. 再線索化右子樹
  //   inThreadedNodes(node.getRight());
  // }
  //
  // // 中序遍歷線索化二元樹的方法
  // String inThreadedList() {
  //   String s = '';
  //   // 定義一個變數, 臨時存儲當前遍歷的節點, 從root開始
  //   TreeNode node = root;
  //   while(node != null) {
  //     // 循環的找到leftType = 1 的節點, 說明該節點是按照線索化處理後的有效節點
  //     while(node.getLeftType() == 0) {
  //       node = node.getLeft();
  //     }
  //     // 輸出當前節點
  //     LogUtil.e("$node");
  //     s += '節點:$node';
  //     // 如果當前節點的右指針指向的是後繼節點, 就一直輸出
  //     while(node.getRightType() == 1) {
  //       node = node.getRight();
  //       LogUtil.e("$node");
  //       s += '節點:$node';
  //     }
  //     // 替換這個遍歷的節點
  //     node = node.getRight();
  //   }
  //   return s;
  // }
  //
  // // 對二元樹進行前序線索化的方法
  // void preThreadedNodes(TreeNode node) {
  //   if(node == null) {
  //     return;
  //   }
  //
  //   if(node.getLeft() == null) {
  //     // 讓當前節點的左指針指向前驅節點
  //     node.setLeft(prev);
  //     // 修改當前節點的左指針類型
  //     node.setLeftType(1);
  //   }
  //
  //   if(prev != null && prev.getRight() == null) {
  //     // 讓前驅節點的右指針指向當前節點
  //     prev.setRight(node);
  //     // 修改當前節點的右指針類型
  //     prev.setRightType(1);
  //   }
  //
  //   prev = node;
  //
  //   if(node.getLeftType() == 0) {
  //     preThreadedNodes(node.getLeft());
  //   }
  //
  //   if(node.getRightType() == 0) {
  //     preThreadedNodes(node.getRight());
  //   }
  //
  // }
  //
  // // 前序遍歷線索化二元樹
  // String preThreadedList() {
  //   String s = '';
  //   TreeNode node = root;
  //   while(node != null) {
  //
  //     LogUtil.e("$node");
  //     s += '節點:$node';
  //
  //     while(node.getLeftType() == 0) {
  //       node = node.getLeft();
  //       s += '節點:$node';
  //       LogUtil.e("$node");
  //     }
  //
  //     while(node.getRightType() == 1) {
  //       node = node.getRight();
  //       s += '節點:$node';
  //       LogUtil.e("$node");
  //     }
  //
  //     node = node.getRight();
  //   }
  //   return s;
  // }

  TreeNode root;
  TreeNode prev = null;

 void setRoot(TreeNode root) {
    this.root = root;
  }

  // 重載線索化方法
  // void preThreadedNodes() {
  //   this.preThreadedNodes(root);
  // }
  //
  // void infixThreadedNodes() {
  //   this.infixThreadedNodes(root);
  // }

  // 中序遍歷線索化二元樹
  String infixThreadedList() {
    String s = '';
    // 定義一個變數, 臨時存儲當前遍歷的節點, 從root開始
    TreeNode node = root;
    for(int i = 0; i < 2; i++) {

      // 循環的找到leftType = 0 的節點, 說明該節點是按照線索化處理後的有效節點
      while(node.getLeftType() == 0) {
        node = node.getLeft();
        s += "$node";
        LogUtil.e("$node");
      }

      // 輸出當前節點
      s += "$node";
      LogUtil.e("$node");

      // 如果當前節點的右指針指向的是後繼節點, 就一直輸出
      while(node.getRightType() == 1) {
        node = node.getRight();
        s += "$node";
        LogUtil.e("$node");
      }

      // 替換這個遍歷的節點
      node = node.getRight();
    }
    return s;
  }

  // 前序遍歷線索化二元樹
  String preThreadedList() {
   String s = '';
   // 定義一個變數, 臨時存儲當前遍歷的節點, 從root開始
    TreeNode node = root;
   for(int i = 0; i < 2; i++) {

      // 輸出當前節點
     s += "$node";
     LogUtil.e("$node");

      // 循環的找到leftType = 0 的節點, 說明該節點是按照線索化處理後的有效節點
      while(node.getLeftType() == 0) {
        node = node.getLeft();
        s += "$node";
        LogUtil.e("$node");
      }

      // 如果當前節點的右指針指向的是後繼節點, 就一直輸出
      while(node.getRightType() == 1) {
        node = node.getRight();
        s += "$node";
        LogUtil.e("$node");
      }

      // 替換這個遍歷的節點
      node = node.getRight();
    }
    return s;
  }

  /// @param node 當前需要線索化的節點
  //對二元樹進行中序線索化的方法
  void infixThreadedNodes(TreeNode node) {
    if (node == null) {
      return;
    }

    // 1. 先線索化左子樹
    infixThreadedNodes(node.getLeft());
    // 2. 線索化當前節點
    // 處理當前節點的前驅節點
    if (node.getLeft() == null) {
      // 讓當前節點的左指針指向前驅節點
      node.setLeft(prev);
      // 修改當前節點的左指針類型
      node.setLeftType(1);
    }
    // 處理後繼節點
    if (prev != null && prev.getRight() == null) {
      // 讓前驅節點的右指針指向當前節點
      prev.setRight(node);
      // 修改當前節點的右指針類型
      prev.setRightType(1);
    }
    // 每處理一個節點後, 讓當前節點是下一個節點的前驅節點
    prev = node;
    // 3. 再線索化右子樹
    infixThreadedNodes(node.getRight());
  }

  //對二元樹進行前序線索化的方法
  void preThreadedNodes(TreeNode node) {
      if(node == null) {
        return;
      }

      if(node.getLeft() == null) {
        // 讓當前節點的左指針指向前驅節點
        node.setLeft(prev);
        // 修改當前節點的左指針類型
        node.setLeftType(1);
      }

      if(prev != null && prev.getRight() == null) {
        // 讓前驅節點的右指針指向當前節點
        prev.setRight(node);
        // 修改當前節點的右指針類型
        prev.setRightType(1);
      }

      prev = node;

      if(node.getLeftType() == 0) {
        preThreadedNodes(node.getLeft());
      }
      if(node.getRightType() == 0) {
        preThreadedNodes(node.getRight());
      }
    }

    // 刪除節點
    void deleteNode(int no) {
        if(root != null) {
            // 如果只有一個root節點, 需要判斷root是不是就是要刪除的節點
            if(root.getNo() == no) {
                root = null;
            } else {
                // 遞迴刪除
                root.deleteNode(no);
            }
        } else {
          LogUtil.e("空樹");
        }
    }

    // 前序遍歷
    void preOrder() {
        if(root != null) {
            root.preOrder();
        } else {
          LogUtil.e("二元樹為空");
        }
    }
    // 中序遍歷
    void inOrder() {
        if(root != null) {
            root.inOrder();
        } else {
          LogUtil.e("二元樹為空");
        }
    }
    // 後序遍歷
    void postOrder() {
        if(root != null) {
            root.postOrder();
        } else {
          LogUtil.e("二元樹為空");
        }
    }

    // 前序搜尋
    TreeNode preOrderSearch(int no) {
        if(root != null) {
          LogUtil.e("${root.preOrderSearch(no)}");
            return root.preOrderSearch(no);
        } else {
            return null;
        }
    }

    // 中序搜尋
    TreeNode infixOrderSearch(int no) {
        if(root != null) {
          LogUtil.e("${root.infixOrderSearch(no)}");
            return root.infixOrderSearch(no);
        } else {
            return null;
        }
    }

    // 後序搜尋
    TreeNode postOrderSearch(int no) {
        if(root != null) {
          LogUtil.e("${root.postOrderSearch(no)}");
            return root.postOrderSearch(no);
        } else {
            return null;
        }
    }

}
