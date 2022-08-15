// @dart = 2.9
// 創建二元搜尋樹
import 'package:common_utils/common_utils.dart';
import 'node2.dart';

class SearchBinaryTree {
  Node2 root;

  // 添加節點的方法
  void add(Node2 node) {
    if(root == null) {
      root = node; // root為空則直接指向node
    } else {
      root.add(node);
    }
  }

  // 中序遍歷
  void infixOrder() {
    if(root != null) {
      root.infixOrder();
    } else {
      LogUtil.e("二元搜尋樹為空!");
    }
  }

  // 搜尋要刪除的節點
  Node2 search(int value) {
    if(root == null) {
      return null;
    } else {
      return root.search(value);
    }
  }

  // 搜尋父節點
  Node2 searchParent(int value) {
    if(root == null) {
      return null;
    } else {
      return root.searchParent(value);
    }
  }

  // 刪除0子樹的節點
  void deleteNode0(int value) {
    if(root == null) {
      return;
    } else {
      // 先找到要刪除的節點 targetNode
      Node2 targetNode = search(value);
      // 沒找到要刪除的節點
      if(targetNode == null) return;
      // 如果當前二元搜尋樹只有一個節點
      if(root.left == null && root.right == null) {
        root = null;
        return;
      }
      // 去找到targetNode的父節點
      Node2 parent = searchParent(value);
      // 如果要刪除的節點是葉子節點
      if(targetNode.left == null && targetNode.right == null) {
        // 判斷 targetNode 是父節點的左子節點還是右子節點
        if(parent.left != null && parent.left.value == value) {
          parent.left = null;
        } else if(parent.right != null && parent.right.value == value) {
          parent.right = null;
        }
      }
    }
  }

  // 刪除一顆子樹的節點
  void deleteNode1(int value) {
    if(root == null) {
      return;
    } else {
      // 先找到要刪除的節點 targetNode
      Node2 targetNode = search(value);
      // 沒找到要刪除的節點
      if(targetNode == null) return;
      // 如果當前二元搜尋樹只有一個節點
      if(root.left == null && root.right == null) {
        root = null;
        return;
      }
      // 去找到targetNode的父節點
      Node2 parent = searchParent(value);
      // 如果要刪除的節點是葉子節點
      if(targetNode.left == null && targetNode.right == null) {
        // 判斷 targetNode 是父節點的左子節點還是右子節點
        if(parent.left != null && parent.left.value == value) {
          parent.left = null;
        } else if(parent.right != null && parent.right.value == value) {
          parent.right = null;
        }
      } else if (targetNode.left != null && targetNode.right != null) { // 刪除有兩棵子樹的節點

      } else { // 刪除只有一棵子樹的節點
        // 如果要刪除的節點有左子節點
        if(targetNode.left != null) {
          if(parent != null) {
            // 如果 targetNode 是 parent 的左子節點
            if(parent.left.value == value) {
              parent.left = targetNode.left;
            } else {
              parent.right = targetNode.left;
            }
          } else {
            root = targetNode.left;
          }
        } else { // 要刪除的節點有右子節點
          if(parent != null) {
            // 如果 targetNode 是 parent 的右子節點
            if(parent.left.value == value) {
              parent.left = targetNode.right;
            } else {
              parent.right = targetNode.right;
            }
          } else {
            root = targetNode.right;
          }
        }
      }
    }
  }

  // 1. 返回以node 為根節點的二元搜尋樹的最小節點的值
  // 2. 刪除 node 為根節點的二元搜尋樹的最小節點
  /// @param node 傳入的節點(當作二元搜尋樹的根結點)
  /// @return 返回的 以node 為根節點的二元搜尋樹的最小節點的值
  int deleteRightTreeMin(Node2 node) {
    Node2 target = node;
    // 循環的搜尋左節點, 就會找到最小值
    while(target.left != null) {
      target = target.left;
    }
    // 這時target 指向了最小節點
    // 刪除最小節點
    deleteNode2(target.value);
    return target.value;
  }

  // 刪除兩顆子樹的節點
  void deleteNode2(int value) {
    if(root == null) {
      return;
    } else {
      // 先找到要刪除的節點 targetNode
      Node2 targetNode = search(value);
      // 沒找到要刪除的節點
      if(targetNode == null) return;
      // 如果當前二元搜尋樹只有一個節點
      if(root.left == null && root.right == null) {
        root = null;
        return;
      }
      // 去找到targetNode的父節點
      Node2 parent = searchParent(value);
      // 如果要刪除的節點是葉子節點
      if(targetNode.left == null && targetNode.right == null) {
        // 判斷 targetNode 是父節點的左子節點還是右子節點
        if(parent.left != null && parent.left.value == value) {
          parent.left = null;
        } else if(parent.right != null && parent.right.value == value) {
          parent.right = null;
        }
      } else if (targetNode.left != null && targetNode.right != null) { // 刪除有兩棵子樹的節點
        int minVal = deleteRightTreeMin(targetNode.right);
        targetNode.value = minVal;
      } else { // 刪除只有一棵子樹的節點
        // 如果要刪除的節點有左子節點
        if(targetNode.left != null) {
          if(parent != null) {
            // 如果 targetNode 是 parent 的左子節點
            if(parent.left.value == value) {
              parent.left = targetNode.left;
            } else {
              parent.right = targetNode.left;
            }
          } else {
            root = targetNode.left;
          }
        } else { // 要刪除的節點有右子節點
          if(parent != null) {
            // 如果 targetNode 是 parent 的右子節點
            if(parent.left.value == value) {
              parent.left = targetNode.right;
            } else {
              parent.right = targetNode.right;
            }
          } else {
            root = targetNode.right;
          }
        }
      }
    }
  }

}