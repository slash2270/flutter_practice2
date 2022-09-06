// @dart = 2.9

import 'package:flutter_practice2/data_structure/vertex2.dart';
import 'edge1.dart';
import 'node3.dart';

/// 有向帶權圖的鄰接表實現
class AdjacencyList {

  List<Vertex2> vertexNameList; //所有頂點名的陣列
  List<Node3> getList = [];

  AdjacencyList(List<String> vert, List<Edge1> edge){
  //讀入頂點，並初始化
  vertexNameList = List.filled(vert.length, Vertex2());

    for (int i = 0; i < vert.length; i++) {
      vertexNameList[i] = Vertex2();
      vertexNameList[i].data = vert[i]; //頂點名稱
      vertexNameList[i].firstEdge = null; //還沒有鄰接點，當然沒邊
    }

    //初始化邊
    for (int i = 0; i < edge.length; i++) {
      String start = edge[i].start;
      String end = edge[i].end;

      //獲取頂點對應的序號
      int startRank = getPosition(start);
      int endRank = getPosition(end);

      //1.endRank是startRank的鄰接點，把endRank連線在以startRank為頭的連結串列中
      Node3 endRankNode = Node3();
      endRankNode.index = endRank;
      endRankNode.weight = edge[i].weight;
      getList.add(linkedLast(startRank, endRankNode));
    }
  }

  //尾插法，將頂點連線到連結串列的尾巴
  Node3 linkedLast(int index, Node3 node) {
    if (vertexNameList[index].firstEdge == null) {
      vertexNameList[index].firstEdge = node;
      // LogUtil.e("index:${vertexNameList[index].firstEdge.index},\tweight:${vertexNameList[index].firstEdge.weight}\n");
      return vertexNameList[index].firstEdge;
    } else {
      Node3 tmp = vertexNameList[index].firstEdge;
      while (tmp.nextNode != null) {
        tmp = tmp.nextNode;
      }
      tmp.nextNode = node;
      return tmp.nextNode;
    }
  }

  //獲取某個頂點在陣列中序號
  int getPosition(String v) {
    for (int i = 0; i < vertexNameList.length; i++) {
      if (vertexNameList[i].data == v) return i;
    }
    //不存在這樣的頂點則返回-1
    return -1;
  }

  // /// 圖的遍歷演算法(基於鄰接表)
  // /// 深度優先遍歷(DFS: Depth First Search)
  // /// 深度優先演算法的過程，簡單來說是從起點開始，找到一條最深的路徑，到頭之後，返回上一個節點，繼續找一條最深的路徑(每個節點只能訪問一次)。
  // //深度優先搜尋(DFS)遍歷圖,從第一個頂點開始遍歷圖
  // void DFS(){
  //   List<bool> visited = List.filled(vertexNameList.length, false); //頂點是否已被遍歷，預設為false
  //   List<int> path = List.filled(vertexNameList.length, 0); //遍歷時，頂點出現的順序，按序記錄其下標
  //   int index = 0;                                           //path[]的索引
  //
  //   /**
  //    * MyStack:表示資料結構——棧;先進後出
  //    * 棧的基本操作：
  //    * 1） push(Object o)：元素入棧
  //    * 2） Object pop()：返回棧頂元素，並把該元素從棧中刪除。
  //    * 3） Object peek()：返回棧頂元素，但不把該元素刪除。
  //    */
  //   StackQueue<int> stack = StackQueue();
  //
  //   for (int i = 0; i < visited.length; i++) {
  //     //利用棧的先進後出特性，先找到一條最深的路徑
  //     stack.push(i);
  //
  //     if(!visited[i]) {
  //       visited[i] = true;       //下標i的頂點被遍歷
  //       path[index++] = i;       //第一個被遍歷的頂點，其下標是i
  //
  //       while(stack.canPop) {
  //         int v = getUnVisitedVertex(stack.peak(),visited);
  //         //如果不存在沒有訪問的鄰接點，就出棧，原路返回
  //         if(v == -1) {
  //           stack.pop();
  //         } else {
  //           path[index++] = v;   //訪問鄰接點順序
  //           visited[v] = true;   //鄰接點v已訪問
  //           stack.push(v);       //入棧
  //         }
  //
  //       }
  //     }
  //     else {
  //       stack.pop();
  //     }
  //   }
  //
  //   //列印DFS路徑
  //   LogUtil.e("DFS路徑:");
  //   for (int i = 0; i < path.length; i++) {
  //     LogUtil.e("${vertexNameList[path[i]].data} ");
  //   }
  //
  // }
  //
  // //返回某個頂點還沒有被訪問的鄰接點的序號
  // int getUnVisitedVertex(int v, List<bool> visited) {
  //   Node3 tmp = vertexNameList[v].firstEdge;
  //
  //   //如果存在鄰接點,且鄰接點還沒有被遍歷，返回此鄰接點下標;
  //   while (tmp != null) {
  //     if (!visited[tmp.index]) return tmp.index;
  //     tmp = tmp.nextNode;
  //   }
  //   //不存在沒有被訪問的鄰接點
  //   return -1;
  // }
  //
  // /// 廣度優選遍歷(BFS: Breadth First Search)
  // /// 廣度優先演算法，是從起點開始，找到這個點所有的鄰接點，到頭之後，從它的第一個鄰接點開始，繼續找一條最廣的路徑(每個節點只能訪問一次)。
  // //廣度優先搜尋，從第一個頂點開始遍歷
  // void BFS(){
  //   List<bool> visited = List.filled(vertexNameList.length, false);//頂點是否已被遍歷，預設為false
  //   List<int> path = List.filled(vertexNameList.length, 0);        //遍歷時，頂點出現的順序，按序記錄其下標
  //   int index = 0;                                                 //path[]的索引
  //
  //   /**
  //    * MyQueue:表示資料結構——佇列;先進先出
  //    * 佇列的基本操作：
  //    * 1） enqueue(T t)：元素入隊
  //    * 2）  T dequeue()：元素出隊，並把該元素從佇列中刪除。
  //    * 3）     T peek()：返回佇列頭元素，但不把該元素刪除。
  //    */
  //   Queue<int> queue = Queue();
  //
  //   for (int i = 0; i < visited.length; i++) {
  //     //利用佇列的先進先出特性，先找到一條最廣的路徑
  //     queue.enqueue(i);
  //
  //     if(!visited[i]) {
  //       visited[i] = true;                                     //下標i的頂點被遍歷
  //       path[index++] = i;                                     //第一個被遍歷的頂點，其下標是i
  //
  //       while(!queue.isEmpty()) {
  //         int v = getUnVisitedVertex(queue.peek(),visited);
  //         //如果不存在沒有訪問的鄰接點，就出隊
  //         if(v == -1) {
  //           queue.dequeue();
  //         } else {
  //           path[index++] = v;
  //           visited[v] = true;
  //           queue.enqueue(v);
  //         }
  //       }
  //     }
  //     else {
  //       queue.dequeue();
  //     }
  //   }
  //
  //   //列印BFS路徑
  //   LogUtil.e("BFS路徑:");
  //   for (int i = 0; i < path.length; i++) {
  //     LogUtil.e("${vertexNameList[path[i]].data} ");
  //   }
  //
  // }

}

/*
鄰接表(Adjacency List)
鄰接表的優點是節省空間，只儲存實際存在的邊。
缺點是關注頂點的度時，可能要遍歷一個連結串列。
 */