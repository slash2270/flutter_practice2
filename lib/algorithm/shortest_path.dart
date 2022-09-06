// @dart = 2.9

class ShortestPath {

  dijkstra(List<List<int>> graph, List<int> dis, List<bool> visited) {
    while (true) {
      int min = double.maxFinite.toInt();
      int index = -1;
      for (int i = 0; i < dis.length; i++) {
        if (visited[i]) {
          continue;
        } else {
          if (dis[i] < min) {
            index = i;
            min = dis[i];
          }
        }
      }
      if (index == -1) break;
      visited[index] = true;
      for (int i = 0; i < graph.length; i++) {
        if (graph[index][i] != double.maxFinite.toInt()) {
          dis[i] = dis[i] < (min + graph[index][i]) ? dis[i] : min + graph[index][i];
        }
      }
    }
  }

}
