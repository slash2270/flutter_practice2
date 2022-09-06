import 'dart:collection';
import 'dart:math' as math;
import '../algorithm/shortest_path.dart';

enum Status { WON, LOST, CONTINUE }

class AlgorithmUtil{
  AlgorithmUtil._internal();
  factory AlgorithmUtil() => _instance;
  static late final AlgorithmUtil _instance = AlgorithmUtil._internal();

  /**
   * 隨機演算法是一種利用一定程度的隨機性作為其邏輯或過程一部分的演算法。 該演算法通常使用均勻的隨機位作為輔助輸入來指導其行為，希望在“平均情況下”中對隨機位決定的所有可能的隨機選擇實現良好的效能；
   * 因此，執行時間或輸出（或兩者）都是隨機變數。
   */

  /// 蒙地卡羅為摩洛哥王國之首都，該國位於法國與義大利國境，以賭博聞名。蒙地卡羅法是一種隨機演算，是指使用隨機亂數來解決計算問題的方法。
  /// 例如，以亂數散佈點配合面積公式，可以求得近似的 PI，是簡單的蒙地卡羅法運用。隨機演算雖然會有精確度等方面的疑慮，然而有些需求可能無最佳解，或者需要耗費大量運算才能得到理想解答，
  /// 若隨機演算可以快速求得某個可接受的結果，就可能採取這類演算。
  ///
  /// 通常不能保證計算出來的結果總是正確的， 一般只能斷定所給解的正確性不小於p （ 1/2＜p＜1）
  /// 通過演算法的反覆執行（即以增大演算法的執行時間為代價），能夠使發生錯誤的概率 小到可以忽略的程度 (越算越好）
  /// 由於每次執行的演算法是獨立的，故k次執行均發生錯誤的概率為(1-p)k
  /// 對於判定問題（回答只能是“Yes”或 “No”）
  /// 帶雙錯的（two-sided error）: 回答”Yes”或”No”都 有可能錯
  /// 帶單錯的（one-sided error）：只有一種回答可能錯
  ///
  /// 現在我們隨機求得正方形中的點,這些點有的在1/4圓內,假如在1/4圓內的點數為c,總點數為n,則PI/4:1=c:n,從而我們可以求出PI=4*c/n。
  /// 如何判斷點落在圓內呢,涉及一點數學知識:對於圓,其函式為x的平方+y的平方等於1,對於某點座標的x和y,x的平方和y的平方和小於1時,說明在圓內。
  /// 假設散佈了 n 個點，在圓內的點有 c 個，依比例來算，就會得到以下的公式：
  // 蒙地卡羅
  String monteCarloRandom() {
    int n = 100001; // 機率
    int count = 0;
    for (int i = 1; i < n; i++) {
      double random = math.Random().nextDouble(); // 0~1
      if((random * random + random * random) < 1) { // 判斷正方形是否小於圓 x2+y2 = 1圓
        count++;
        // LogUtil.e('Calculate "PI = ":${(4.0 * count/(n - 1))} random:$random');
      }
    }
    return "PI(四分之一圓面積) = ${(4.0 * count/(n - 1))}";
  }

  /// 設計隨機演算法，使得演算法的效能和具體的輸入值無關，演算法的效能 =平均效能 + 一個很小的隨機值。
  /// 舍伍德演算法是為了得到好的平均效能。
  /// 準確的說：它是一種思想，並不是一個具體的實現案例。
  // 撲克牌洗牌
  List<Card> sherwoodRandom() {
    List<Card> cards = [];
    for (int i = 0; i < 52; i++) {
      cards.add(Card(suit: suit(i + 1),symbol: symbol(i + 1)));
    }
    cards.shuffle();
    return cards;
  }

  String suit(int number) {
    switch ((number - 1) ~/ 13) {
      case 0 :
        return "桃";
      case 1 :
        return "心";
      case 2 :
        return "磚";
      default:
        return "梅";
    }
  }

  String symbol(int number) {
    int remain = number % 13;
    switch (remain) {
      case 0 :
        return 'K';
      case 1 :
        return 'A';
      case 11:
        return 'J';
      case 12:
        return 'Q';
      default:
        return remain.toString();
    }
  }

  /// Craps 是個簡單的賭博遊戲，玩家擲兩個骰子，點數為 1 到 6，如果第一次點數和為 7 或 11，玩家勝，若點數和為 2、3 或 12，玩家輸，如果和為其他點數，記錄第一次的點數和，然後繼續擲骰，直至點數和等於第一次擲出的點數和，玩家勝，
  /// 若在這之前擲出了點數和為 7，玩家輸。
  // 螃蟹擲骰
  String s = '';
  int firstPoint = 0;
  String crapsRandom() {
    String strPoint = '點數';
    // LogUtil.e('Calculate craps3:$s indexOf:${s.indexOf('點數')} contains:${s.contains('點數')}');
    Status status = Status.CONTINUE;
    if (s.contains('點數')) {
      int secondPoint = dice();
      // LogUtil.e('Calculate secondPoint:$secondPoint');
      status = reRoll(firstPoint, secondPoint);
      // LogUtil.e('Calculate craps2:${status.name}');
      if (status == Status.WON) {
        s = "玩家勝";
      } else if (status == Status.CONTINUE) {
        s = "繼續";
      } else {
        s = "玩家輸";
      }
    } else {
      firstPoint = dice();
      status = initRoll(firstPoint);
      // LogUtil.e('Calculate firstPoint:$firstPoint craps1:${status.name}');
      if (status == Status.WON) {
        s = "$strPoint:$firstPoint 玩家勝";
        return s;
      } else if (status == Status.CONTINUE) {
        s = "$strPoint:$firstPoint 繼續";
      } else {
        s = "$strPoint:$firstPoint 玩家輸";
      }
    }
    return s;
  }

  int dice() {
    int random = math.Random().nextInt(5) + 1; // <= 0~5 + 1
    return random + random;
  }

  Status initRoll(int firstPoint) {
    switch(firstPoint) {
      case 7: case 11:         return Status.WON;
      case 2: case 3: case 12: return Status.LOST;
      default:                 return Status.CONTINUE;
    }
  }

  Status reRoll(int firstPoint, int point) => firstPoint == point ? Status.WON : (7 == point ? Status.LOST : Status.CONTINUE);

  /// 少數應用時會出現求不出解的情況，但一旦找到一個解，則一定是正確的
  /// 求不出解的時候需再次呼叫演算法計算，直到獲得解對於此類演算法，主要是分析演算法的時間複雜度的期望值，以及呼叫一次產生失敗的概率
  /// 可以看成是單錯概率為0的 Monte Carlo演算法
  ///
  /// 在n×n格的棋盤上放置彼此不受攻擊的n 個皇后。
  /// 按照國際象棋的規則，皇后可以攻擊與之處在同一 行或同一列或同一斜線上的棋子。n後問題等價於 在n×n格的棋盤上放置n個皇后，任何2個皇后不放 在同一行或同一列或同一斜線上。
  /// n後問題的Las Vegas演算法思路：各行隨機放置皇后，使新放的與已有的互不攻擊，until (n皇后放好||無可供下一皇后放置的位置)
  ///
  /// 總是給出正確的結果；也就是說，它總是產生正確的結果或告知失敗。 然而，拉斯維加斯演算法的執行時間因輸入而異。
  /// 拉斯維加斯演算法的通常定義包括預期執行時有限的限制，即期望在演算法中使用的隨機資訊或熵空間上進行。
  /// 另一個定義要求拉斯維加斯演算法始終終止（有效），但可以輸出不屬於解決方案空間的符號，以指示在找到解決方案時失敗。
  /// 拉斯維加斯演算法的性質使其適合於可能解決方案數量有限，驗證候選解決方案的正確性相對容易，而找到解決方案很複雜的情況。
  // 拉斯維加斯
  String lasVegasRandom() {
    List queens = [];
    queens.addAll(findOne());
    // LogUtil.e('Calculate queens:$queens');
    if(queens.isEmpty){
      queens.add('演算法失敗');
    }
    return queens.toString();
  }

  List findOne() {
    List queens = [];
    int count = 0, num = 8;
    math.Random r = math.Random();
    for(int i = 1; i < 9; i++) {
      while(queens.length < i) {
        int a = r.nextInt(num) + 1;
        int b =r.nextInt(num) + 1;
        int j = a*10 + b;
        count++;
        if (notConflict(j, queens)) {
          queens.add(j);
          count = 0;
        }
        if(count == 8) {
          queens = [];
          break;
        }
      }
    }
    return queens;
  }

  bool notConflict(int j, List queens) {
    for(int q in queens) {
      if(j%10 == q%10 || j/10 == q/10 || j/10 - j%10 == q/10 - q%10 || j/10 + j%10 == q/10 + q%10) {
        return false;
      }
    }
    return true;
  }

  /// 據說著名猶太歷史／數學家約瑟夫（Josephus）有過以下的故事：在羅馬人佔領喬塔帕特後，40 個猶太士兵與約瑟夫躲到一個洞中，眼見脫逃無望，一群人決定集體自殺，然而私下約瑟夫與某個傢伙並不贊成，於是約瑟夫建議自殺方式，
  /// 41 個人排成圓圈，由第 1 個人開始報數，每報數到 3 的人就必須自殺，然後由下一個重新報數，直到所有人都自殺身亡為止。約瑟夫與不想自殺的那個人分別排在第 16 個與第 31 個位置，於是逃過了死亡。
  ///
  /// 解法思路
  /// 只要畫兩個圓圈就可以讓約瑟夫與不想死的傢伙免於死亡，這兩個圓圈內圈是排列順序，而外圈是自殺順序
  // 約瑟夫環
  String josephusRandom() {
    String s = '';
    Josephus josephus = Josephus();
    List<int> away = josephus.away(41, 3);
    s += "剩餘位置:${josephus.indexPeople}";
    s += "\n自殺順序:";
    for(int number in away) {
      s += '$number\t';
    }
    s += "\n約瑟夫環:";
    for(int number in josephus.circle(away)) {
      s += '$number\t';
    }
    return s;
  }

  String circle() {
    List<Person> list = [];
    num totalPerson = 41;
    num count = 3;
    for (int i = 0; i < totalPerson; i++) {
      list.add(Person("約瑟夫$i號", i + 1, false));
    }
    int position = 0, c = 0, k = 0;
    while (k < list.length) {
      if (!list[position].killed) {
        c++;
      }
      if (c == count) {
        list[position].killed = true;
        c = 0;
        k++;
        var name = list[position].name;
        var po = list[position].position;
        // LogUtil.e("當前被殺:$name位於$po號位置");
      }
      if (position >= list.length - 1) {
        position = 0;
        // LogUtil.e("新一輪:\n");
      } else {
        position++;
      }
    }
    return list.toString();
  }

  /// 主要內容是指定一個點 (源點) 到其餘各個頂點的最短路徑，也稱作「單源最短路徑」。
  /// 總結一下：
  /// 將所有頂點分為兩個部分：已知最短路徑的頂點集合 P 和未知最短路徑的頂點集合 Q。一開始，P 中只有一個源點為已知點，所以用另一個 book[i] 陣列來將源點做記號為 1，
  /// 表示在 P 之中為已知。若 book[i] = 0 的話表示這個頂點 i 為未知，還在 Q 之中。
  /// 設定源點 s 到自己的最短路徑為 0 (dis[s] = 0)。如果 s 能到其他點 i，則把路徑 e[s][i] 存到 dis[i] 之中。若 s 不能到的頂點，路徑 e[s][i] = ∞。
  /// 在集合 Q 中找一個頂點 u 離源點 s 最近，將 u 加入到 P 為已知中。並以 u 為起點對其他邊進行鬆弛，比較從 s → u → v 的路徑能否比 s → v 短，可以的話則更新。
  /// 重複步驟 3 直到集合 Q 為 0。最終的 dis 陣列就是源點到所有頂點的最短路徑了。
  // 戴克斯特拉
  String dijkstra() {
    String s = '';
    List<int> a = [0,double.maxFinite.toInt(),10,double.maxFinite.toInt(),30,100];
    List<int> b = [double.maxFinite.toInt(),0,5,double.maxFinite.toInt(),double.maxFinite.toInt(),double.maxFinite.toInt()];
    List<int> c = [double.maxFinite.toInt(),double.maxFinite.toInt(),0,50,double.maxFinite.toInt(),double.maxFinite.toInt()];
    List<int> d = [double.maxFinite.toInt(),double.maxFinite.toInt(),double.maxFinite.toInt(),0,double.maxFinite.toInt(),10];
    List<int> e = [double.maxFinite.toInt(),double.maxFinite.toInt(),double.maxFinite.toInt(),20,0,60];
    List<int> f = [double.maxFinite.toInt(),double.maxFinite.toInt(),double.maxFinite.toInt(),double.maxFinite.toInt(),double.maxFinite.toInt(),0];
    List<List<int>> graph = [a, b, c, d, e, f];
    List<int> dis = List.filled(6, 0);
    List<bool> visited = List.filled(6, false);

    visited[0] = true;

    for(int i = 0; i < 6; i++){
       dis[i] = graph[0][i];
       ShortestPath().dijkstra(graph, dis, visited);
    }

    for(int i=0; i < dis.length; i++){
       s += '${dis[i]}\t';
       // LogUtil.e('Dijkstra dis:${dis[i]}\t');
    }

    return s;
  }

}

class Card {
  String? suit;
  String? symbol;

  Card({this.suit, this.symbol});

  @override
  String toString() => "$suit$symbol";
}

class Person {
  String name;
  int position;
  bool killed;

  Person(this.name, this.position, this.killed);
  @override
  String toString() {
    return position % 2 == 0 ? "姓名:$name 位置$position 是否被殺:$killed\n" : "姓名:$name 位置$position 是否被殺:$killed\t";
  }
}

class Linked {
  int? val;
  Linked? next;
  Linked(this.val);
}

class Josephus {

  Set<int> indexPeople = {};

  List<int> away(int len, int k) {
    for(int i = 1; i <= len; i++) {
      indexPeople.add(i);
    }
    List<int> away = [len];
    int i = 2;
    for(i;;) {
      if(indexPeople.length > 2) {
        // LogUtil.e('Calculate list1:$list');
        away.add(indexPeople.elementAt(i));
        indexPeople.remove(indexPeople.elementAt(i));
        // LogUtil.e('Calculate list2:$indexPeople away:$away');
        if (indexPeople.isEmpty) {
          break;
        }
        i = (i + k - 1) % indexPeople.length;
      }else {
        break;
      }
    }
    return away;
  }

  List<int> circle(List<int> awayOrder) {
    List<int> josephus = [awayOrder.length];
    for(int i = 1; i <= awayOrder.length; i++) {
      josephus.add(awayOrder.indexOf(i) + 1);
    }
    return josephus;
  }
}

class Entry<T> extends LinkedListEntry<Entry<T>> {
  T value;
  Entry(this.value);
  @override
  String toString() {
    return '$value';
  }
}

class LinkedListEntryImpl<T> extends LinkedListEntry<LinkedListEntryImpl<T>> {
  final T value;
  LinkedListEntryImpl(this.value);
  @override
  String toString() {
    return "value:$value";
  }
}

