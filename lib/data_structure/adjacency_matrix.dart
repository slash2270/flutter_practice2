// @dart = 2.9
///鄰接矩陣的實現
class AdjacencyMatrix {

  List<String> vertex;//頂點名的集合
  List<List<int>> edges;//鄰接矩陣，儲存邊
  int numOfEdges;//邊的個數

  AdjacencyMatrix(int n){
    edges = List.generate(n, (index) => List.generate(n, (index) => 0));
    vertex = List.filled(n, '');
  }

  //頂點的個數
  int getNumOfVertexs() => vertex.length;

  //邊的數目
  int getNumOfEdges() => numOfEdges;

  //獲取序號v1頂點到序號v2頂點的權值
  int getWeight(int v1, int v2) => edges[v1][v2];

  //插入一條邊
  void insertEdge(int v1, int v2, int weight){
    edges[v1][v2] = weight;
    numOfEdges++;
  }

  //獲取某頂點下標v的第一個鄰接點在vertex陣列的下標
  int getFirstNeighbor(int v){
    for (int i = 0; i < vertex.length; i++) {
      if(edges[v][i] != 0) {
        return i;
      }
    }
    return -1;
  }

  //根據頂點下標v1的前一個鄰接點下標v2,獲取v1的下一個鄰接點
  int getNextNeighbor(int v1, int v2){
    for (int i = v2+1; i < vertex.length; i++) {
      if(edges[v1][i] != 0) {
        return i;
      }
    }
    return -1;
  }

}