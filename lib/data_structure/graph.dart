// @dart = 2.9
import 'package:flutter_practice2/data_structure/array_queue2.dart';
import 'package:flutter_practice2/data_structure/stackx.dart';
import 'package:flutter_practice2/data_structure/vertex1.dart';

class Graph {
  final int maxVertex = 20; //表示頂點的個數
  List<Vertex1> vertexList; //用來儲存頂點的陣列
  List<List<int>> adjacencyMatrix; //用鄰接矩陣來儲存 邊,陣列元素0表示沒有邊界，1表示有邊界
  int numberVertex; //頂點個數
  StackX theStack; //用棧實現深度優先搜尋
  ArrayQueue2 arrayQueue2; //用佇列實現廣度優先搜尋

  /// 頂點類
  /// 圖(Graph)是一些頂點的集合，頂點之間通過邊連線。
  /// 邊可以有權重(weight),即每條邊可以被賦值，正負皆可。
  /// 邊分為有向邊(Directed Edge)、無向邊(Undirected Edge)。
  /// 頂點的度指連線該頂點的邊的數目。
  Graph() {
    theStack = StackX();
    arrayQueue2 = ArrayQueue2();
    vertexList = List.filled(maxVertex, Vertex1(''));
    adjacencyMatrix = List.generate(maxVertex, (index) => List.generate(maxVertex, (index) => 0));
    numberVertex = 0; //初始化頂點個數為0
    //初始化鄰接矩陣所有元素都為0，即所有頂點都沒有邊
    for (int i = 0; i < maxVertex; i++) {
      for (int j = 0; j < maxVertex; j++) {
        adjacencyMatrix[i][j] = 0;
      }
    }
  }

  //將頂點新增到陣列中，是否存取標誌置為wasVisited=false(未存取)
  void addVertex(String lab) {
    vertexList[numberVertex++] = Vertex1(lab);
  }

  //注意用鄰接矩陣表示邊，是對稱的，兩部分都要賦值
  void addEdge(int start, int end) {
    adjacencyMatrix[start][end] = 1;
    adjacencyMatrix[end][start] = 1;
  }

  //列印某個頂點表示的值
  String displayVertex(int v) {
    //LogUtil.e("頂點值:${vertexList[v].label}");
    return "頂點值:${vertexList[v].label}";
  }

  /// 深度優先搜尋演演算法:
  /// 1、用peek()方法檢查棧頂的頂點
  /// 2、用getAdjUnvisitedVertex()方法找到當前棧頂點鄰接且未被存取的頂點
  /// 3、第二步方法返回值不等於-1則找到下一個未存取的鄰接頂點，存取這個頂點，併入棧如果第二步方法返回值等於 -1，則沒有找到，出棧
  String depthFirstSearch() {
    String s = '';
    //從第一個頂點開始存取
    vertexList[0].wasVisited = true; //存取之後標記為true
    s += displayVertex(0); //列印存取的第一個頂點
    theStack.push(0); //將第一個頂點放入棧中
    while (!theStack.isEmpty()) {
      //找到棧當前頂點鄰接且未被存取的頂點
      int v = getAdjUnvisitedVertex(theStack.peek());
      if (v == -1) { //如果當前頂點值為-1，則表示沒有鄰接且未被存取頂點，那麼出棧頂點
        theStack.pop();
      } else { //否則存取下一個鄰接頂點
        vertexList[v].wasVisited = true;
        s += displayVertex(v);
        theStack.push(v);
      }
    }
    //棧存取完畢，重置所有標記位wasVisited=false
    for (int i = 0; i < numberVertex; i++) {
      vertexList[i].wasVisited = false;
    }
    return s;
  }

  //找到與某一頂點鄰接且未被存取的頂點
  int getAdjUnvisitedVertex(int v) {
    for (int i = 0; i < numberVertex; i++) {
      //v頂點與i頂點相鄰（鄰接矩陣值為1）且未被存取 wasVisited==false
      if (adjacencyMatrix[v][i] == 1 && vertexList[i].wasVisited == false) {
        return i;
      }
    }
    return -1;
  }

  /// 廣度優先搜尋演演算法：
  /// 1、用remove()方法檢查棧頂的頂點
  /// 2、試圖找到這個頂點還未存取的鄰節點
  /// 3、如果沒有找到，該頂點出列
  /// 4、如果找到這樣的頂點，存取這個頂點，並把它放入佇列中
  String breadthFirstSearch() {
    String s = '';
    vertexList[0].wasVisited = true;
    s += displayVertex(0);
    arrayQueue2.insert(0);
    int v2;
    while (!arrayQueue2.isEmpty()) {
      // LogUtil.e("Graph queue:$arrayQueue2");
      int v1 = arrayQueue2.remove();
      while ((v2 = getAdjUnvisitedVertex(v1)) != -1) {
        vertexList[v2].wasVisited = true;
        s += displayVertex(v2);
        arrayQueue2.insert(v2);
      }
    }
    //搜尋完畢，初始化，以便於下次搜尋
    for (int i = 0; i < numberVertex; i++) {
      vertexList[i].wasVisited = false;
    }
    return s;
  }

  /// 對於圖的操作，還有一個最常用的就是找到最小生成樹，最小生成樹就是用最少的邊連線所有頂點。對於給定的一組頂點，可能有很多種最小生成樹，但是最小生成樹的邊的數量 E 總是比頂點 V 的數量小1，即：
  /// V = E + 1
  /// 這裡不用關心邊的長度，不是找最短的路徑（會在帶權圖中講解），而是找最少數量的邊，可以基於深度優先搜尋和廣度優先搜尋來實現。
  /// 比如基於深度優先搜尋，我們記錄走過的邊，就可以建立一個最小生成樹。因為DFS 存取所有頂點，但只存取一次，它絕對不會兩次存取同一個頂點，但她看到某條邊將到達一個已存取的頂點，
  /// 它就不會走這條邊，它從來不遍歷那些不可能的邊，因此，DFS 演演算法走過整個圖的路徑必定是最小生成樹。
  //基於深度優先搜尋找到最小生成樹
  String mst() {
    String s = '';
    vertexList[0].wasVisited = true;
    theStack.push(0);
    while(!theStack.isEmpty()){
      int currentVertex = theStack.peek();
      int v = getAdjUnvisitedVertex(currentVertex);
      if(v == -1){
        theStack.pop();
      }else{
        vertexList[v].wasVisited = true;
        theStack.push(v);
        s += displayVertex(currentVertex);
        s += displayVertex(v);
        s += ' ';
      }
    }
    //搜尋完畢，初始化，以便於下次搜尋
    for(int i = 0; i < numberVertex; i++) {
      vertexList[i].wasVisited = false;
    }
    return s;
  }

}