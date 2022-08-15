import 'dart:core';
import 'dart:io';
import 'package:flutter_practice2/data_structure/adjacency_matrix.dart';
import 'package:flutter_practice2/data_structure/edge1.dart';
import 'package:flutter_practice2/data_structure/four_arithmetic.dart';
import 'package:flutter_practice2/data_structure/migong.dart';
import 'package:path_provider/path_provider.dart';
import '../az_listview/common/index.dart';
import '../data_structure/adjacency_list.dart';
import '../data_structure/array_queue1.dart';
import '../data_structure/binary_tree.dart';
import '../data_structure/circular_single_linked_list.dart';
import '../data_structure/double_linked_list.dart';
import '../data_structure/eight_queen.dart';
import '../data_structure/emp.dart';
import '../data_structure/graph.dart';
import '../data_structure/hash_table.dart';
import '../data_structure/hero_node.dart';
import '../data_structure/hero_node2.dart';
import '../data_structure/hero_node3.dart';
import '../data_structure/node2.dart';
import '../data_structure/search_binary_tree.dart';
import '../data_structure/single_linked_list.dart';
import '../data_structure/threaded_binary_tree.dart';
import '../data_structure/tree_node.dart';

class DataStructureUtil{

  /// 五子棋程序如何存取盤的下棋情況？
  /// A：可以使用二維陣列，將黑棋白棋記錄下來。
  ///
  /// 思考
  /// Q：該二維陣列很多值默認為0，因此記錄了很多沒意義的數據，該如何去解決？
  /// A：可以使用稀疏矩陣來保存該陣列。
  ///
  /// 稀疏矩陣的處理方法
  /// 記錄陣列一共有幾行幾列，有多少個不同的值。
  /// 把具有不同值的元素的行列及值記錄在一個小規模的陣列中，從而縮小程式的規模。
  /// 以下圖為例，我們可以將原先 6*7 = 42 的陣列縮減為 9*3 = 27 的陣列：
  ///
  /// 【小結】
  /// 使用稀疏矩陣的情況：
  /// 當一個陣列有很多沒意義數據(0)或相同數據。
  /// 處理方法：
  ///
  /// 第一行記錄陣列共幾列幾行並且有幾個非0的值。
  /// 第二行開始用於紀錄每個非0值在陣列第幾列第幾行、值為多少。
  /// 二維陣列 轉 稀疏矩陣
  ///
  /// 思路
  /// 遍歷原始的二維陣列，得到有效數據的個數(sum)。
  /// 根據sum 就可以創建稀疏矩陣parseMatrix int[sum+1][3]
  /// 將二維陣列的有效數據存入到稀疏矩陣。
  /// 稀疏矩陣 轉 二維陣列
  ///
  /// 思路
  /// 先讀取稀疏矩陣第一行，根據第一行的數據創建原始的二維陣列，比如上方圖示chessArr = int[11][11]
  /// 再讀取稀疏矩陣後幾行的數據，並賦給原始的二維陣列。

  //稀疏矩陣
  Future<String> sparseMatrix() async{
    //創建原始的二維陣列 11*11
    //0: 沒有旗子, 1:黑子, 2:藍子
    List<List<int>> chessArr1 = List.generate(11, (i) => List.generate(11, (j) => 0));
    chessArr1[1][2] = 1;
    chessArr1[2][3] = 2;
    //輸出原始二維陣列
    for (List row in chessArr1) {
      for (int data in row) {
        //LogUtil.e("data origin:$data");
      }
    }

    //1.先遍歷二維陣列,獲取非0數據個數
    int sum = 0;
    for (int i = 0; i < 11; i++) {
      for (int j = 0; j < 11; j++) {
        if (chessArr1[i][j] != 0) sum++;
      }
    }

    //2.創建對應的稀疏矩陣
    List<List<int>> sparseArr = List.generate(sum + 1, (i) => List.generate(3, (j) => 0)); //列:sum為非0值的個數+1列存放原始二維陣列資訊 行:列,行,非0值
    // LogUtil.e("sparseArrLength:${sparseArr.length}");
    //給稀疏矩陣賦值
    sparseArr[0][0] = 11;
    sparseArr[0][1] = 11;
    sparseArr[0][2] = sum;

    //遍歷二維陣列,將非0值存放到稀疏矩陣中
    int count = 0; //用於紀錄是第幾個非0數據
    for (int i = 0; i < 11; i++) {
      for (int j = 0; j < 11; j++) {
        if (chessArr1[i][j] != 0) {
          count++;
          sparseArr[count][0] = i;
          sparseArr[count][1] = j;
          sparseArr[count][2] = chessArr1[i][j];
        }
      }
    }

    //輸出稀疏矩陣
    for (List<int> row in sparseArr) {
      for (int data in row) {
        // LogUtil.e("data:$data");
      }
    }

    //恢復原始二維陣列
    List<List<int>> chessArr2 = List.generate(sparseArr[0][0], (i) => List.generate(sparseArr[0][1], (j) => 0)); // 10 & 3
    //從稀疏矩陣第二行開始讀取數據,並賦給原始二維陣列
    for (int i = 1; i < sparseArr.length; i++) {
      //LogUtil.e("sparseArr[i][0]:${sparseArr[i][0]} sparseArr[i][1]:${sparseArr[i][1]} sparseArr[i][2]:${sparseArr[i][2]}");
      chessArr2[sparseArr[i][0]][sparseArr[i][1]] = sparseArr[i][2];
    }

    for (List<int> row in chessArr2) {
      for (int data in row) {
        //LogUtil.e("data chess:$data");
      }
    }

    final File file = await _setLocalFile();
    String content = '';
    //寫入稀疏矩陣內容
    for (int i = 0; i < sum + 1; i++) {
      for (int j = 0; j < 3; j++) {
        // LogUtil.e("data sparse:${sparseArr[i][j]}\t");
        content += "${sparseArr[i][j]}\t";
      }
      content += '\r\n';
    }
    file.writeAsString(jsonEncode(content));

    //讀取稀疏矩陣內容
    String read = await file.readAsString();
    read = json.decode(read);
    // LogUtil.e("data file:$file read:$read");
    List<List<int>> arr = List.generate(sum + 1, (i) => List.generate(3, (j) => 0));
    // LogUtil.e("data sum:${sum+1}");

    //逐行讀取,並將每個陣列放入到陣列中
    int row = 0;
    List<String> line = []; //一行資料
    List<String> temp = read.split("\t");
    temp.removeAt(temp.length - 1);
    for(int i = 0; i < read.length;i++){
      if(read[i].contains('\n')){
        line.add((row++).toString());
      }
    }
    // LogUtil.e("data line:${line.length} tempLength:${temp.length} temp:$temp");
    row = 0;
    List<int> listRow = [];
    for (int k = 0; k < temp.length; k++) { // 10
      listRow.add(int.parse(temp[k]));
      // LogUtil.e("data listRow:$listRow temp[k]:${int.parse(temp[k])}");
      if ((k + 1) % line.length == 0) {
        arr[row] = listRow;
        row++;
        // LogUtil.e("data arr:$arr");
      }
      if (listRow.length == 3) listRow = [];
    }
    return arr.toString();
  }

  Future<File> _setLocalFile() async{
    final Directory directory = await getApplicationDocumentsDirectory();
    final bool isDirExist = await directory.exists();
    if (!isDirExist) Directory(directory.path).create();
    final String dirPath = '${directory.path}/Flutter';
    await Directory(dirPath).create(recursive: true);
    return File('$dirPath/data.txt');
  }

  ///    使用場景: 排隊買票
  ///    特徵
  ///
  ///    先進先出(FIFO)
  ///    有序列表，可以用陣列或連結串列來實現。
  ///    Queue兩個指針：rear 佇列的尾部(含)、front 佇列的頭部(不含)。
  ///    新增數據時，front不動rear動；刪除數據時，rear不動front動 => 由尾端加入數據，由頭部取出。
  ///    我們可以以排隊買票為例，將排隊的隊列視作Queue，先排隊的人先買票，後到的人排在後面等待買票，並且先買票的人買完票之後就離開隊伍；我們將第一個買票的人稱之為front，隊伍最後一個等待買票的人為rear。
  ///    當1號買完票離開換2號買票時，此時的front變為2號。
  ///    Queue 取出數據 示意圖
  ///    當又有下一個人(5號)要買票，此時rear從4號變到5號身上。
  ///    Queue 新增數據 示意圖
  ///    因此我們可以得出，當新增數據時，front不動rear動；刪除數據時，rear不動front動。
  ///    陣列模擬佇列
  ///    當我們將數據存入佇列時稱為addQueue，addQueue的處理須要有兩個步驟：
  ///    將尾指針往後移：rear+1，當 front == rear 為空。
  ///   若尾指針 rear < maxSize-1 則將數據存入rear所指的陣列元素中；若 rear == maxSize-1 為佇列已滿。
  // 佇列(Queue)與環形佇列
  String queue(int count) {
    List<int> arr = List.filled(5, 0);
    List<int> newArr = List.filled(5, 0);
    ArrayQueue1 queue = ArrayQueue1(arr: arr, maxSize: arr.length, front: arr.last, rear: arr.first);
    String getQueue = '';
    getQueue += "s(show)顯示佇列\t${queue.showQueue()}\n";
    newArr = queue.addQueue(count);
    if(arr == newArr) {
      getQueue += "佇列已滿,無法添加\n";
    } else {
      arr = newArr;
      getQueue += "a(add)添加數據到佇列\n請輸入要添加的數據:\n$arr\n";
    }
    try {
      newArr = queue.getQueue();
      if(arr == newArr) {
        getQueue += "佇列為空,無值可取\n";
      } else {
        arr = newArr;
        getQueue += "g(get)從佇列取出數據\n取出的數據是:\n$arr\n";
      }
    } on Exception catch (e, stackTrace) {
      getQueue += "$stackTrace $e";
    }
    try {
      newArr = queue.getHeadQueue();
      if(arr == newArr) {
        getQueue += "佇列為空,無值可取\n";
      } else {
        arr = newArr;
        getQueue += "h(head)查看佇列頭的數據\n佇列頭的數據是:$arr\n";
      }
    } on Exception catch (e, stackTrace) {
      getQueue += "$stackTrace $e";
    }
    getQueue += "e(exit)退出程序\t${false}\n";
    return getQueue;
  }

  /// 鏈結串列以節點(node)來儲存資料，每個節點中包含兩個域：資料域(data)、指標域(next)，指標域用於指向下一個節點，將這些節點串連起來形成 Linked List，而最後一個節點則指向一個空值。
  /// 鏈結串列的各個節點不一定是連續存放的。
  ///
  /// 實際應用案例
  ///
  /// 客戶端發來好友編號21、1、19、38、5，要求按照編號大小順序將這幾位的資訊傳回來，為了速度不允許經過數據庫，那我們可以使用鏈結串列來解決。
  /// 新增鏈結串列數據
  /// 使用帶head的單向鏈結串列實現 - 水滸英雄排行榜管理。
  ///
  /// 目標：完成對英雄人物的增、刪、改、查操作。
  /// 第一種方法在添加英雄時，直接添加到鏈結串列的尾部
  /// 第二種方式在添加英雄時，根據排名將英雄插入指定位置（如果有這個排名，則添加失敗，並給出提示）
  ///
  /// 單向鏈結串列的缺點
  /// 1.單向鏈結串列查找的方向只能是一個方向，而雙向鏈結串列可以向前或向後查找。
  /// 2.單向鏈結串列不能自我刪除，需要靠輔助節點，而雙向鏈結串列則可以自我刪除。
  /// 因此下一節我們將來學習雙向鏈結串列。
  //單向鏈結串列
  String singleLinkedList(){
      HeroNode hero1 = HeroNode(no: 1, name: "宋江", nickname: "及時雨");
      HeroNode hero2 = HeroNode(no: 2, name: "盧俊", nickname: "玉麒麟");
      HeroNode hero3 = HeroNode(no: 3, name: "吳用", nickname: "智多星");
      HeroNode hero4 = HeroNode(no: 4, name: "林沖", nickname: "豹子頭");
      HeroNode hero5 = HeroNode(no: 5, name: "秦明", nickname: "霹靂火");
      // HeroNode hero6 = HeroNode(no: 6, name: "花榮", nickname: "小李廣");
      // HeroNode hero7 = HeroNode(no: 7, name: "榮進", nickname: "小炫風");
      // HeroNode hero8 = HeroNode(no: 8, name: "董平", nickname: "雙槍將");

      String s = '';

      SingleLinkedList singleLinkedList = SingleLinkedList();

      //按照編號順序添加
      singleLinkedList.add(hero1);
      singleLinkedList.add(hero2);
      //singleLinkedList.addByOrder(hero3);  //試著加入已經存在的編號的英雄
      s += "==========3/4不照排序插入==========\n";
      singleLinkedList.addByOrder(hero4);
      singleLinkedList.addByOrder(hero3);
      // singleLinkedList.add(hero6);
      // singleLinkedList.add(hero7);
      // singleLinkedList.add(hero8);
      s += singleLinkedList.list();
      s += "==========更新之後==========\n";

      HeroNode newHeroNode = HeroNode(no: 4, name: "張清", nickname: "沒羽箭");
      singleLinkedList.update(newHeroNode);
      s += singleLinkedList.list();

      s += "==========刪除之後==========\n";
      singleLinkedList.delete(hero4); //被刪除的節點不會有其他引用指向，會被垃圾回收機制回收。
      s += singleLinkedList.list();

      final head = singleLinkedList.getHead();
      String n = singleLinkedList.getLength(head).toString();
      s += "==========求鏈結串列中有效節點的個數:$n==========\n";

      n = singleLinkedList.findLastIndexNode(head, 1).toString();
      s += "==========查找鏈結串列中的倒數第k個結點==========\n";
      s += n;

      s += "==========鏈結串列的反轉==========\n";
      singleLinkedList.reverseList(head);
      s += singleLinkedList.list();

      s += "======鏈結串列的反轉Stack======\n";
      s += singleLinkedList.reverseStack(head);

      return s;
  }

  /// 遍歷、添加、修改、刪除的操作思路
  /// 遍歷方式和單向鏈結串列一樣，只是可以向前也可以向後查找
  /// 添加(默認加到雙向鏈結串列的最後)
  /// – 先找到雙向鏈結串列的最後節點
  /// – temp.next = newHeroNode
  /// – newHeroNode.prev = temp
  /// 修改的思路和原來的單向鏈結串列一樣
  /// 刪除
  /// – 因為是雙向，因此我們可以實現自我刪除某個節點
  /// – 直接找到要刪除的節點，比如 temp
  /// – temp.prev.next = temp.next
  /// – temp.next.prev = temp.prev
  //雙向鏈結串列

  String doubleLinkedList() {

    HeroNode2 hero1 = HeroNode2(no: 1, name: "宋江", nickname: "及時雨");
    HeroNode2 hero2 = HeroNode2(no: 2, name: "盧俊", nickname: "玉麒麟");
    HeroNode2 hero3 = HeroNode2(no: 3, name: "吳用", nickname: "智多星");
    HeroNode2 hero4 = HeroNode2(no: 4, name: "林沖", nickname: "豹子頭");
    HeroNode2 hero5 = HeroNode2(no: 5, name: "秦明", nickname: "霹靂火");
    // HeroNode2 hero6 = HeroNode2(no: 6, name: "花榮", nickname: "小李廣");
    // HeroNode2 hero7 = HeroNode2(no: 7, name: "榮進", nickname: "小炫風");
    // HeroNode2 hero8 = HeroNode2(no: 8, name: "董平", nickname: "雙槍將");

    String s = '';

    DoubleLinkedList doubleLinkedList = DoubleLinkedList();

    doubleLinkedList.add(hero1);
    doubleLinkedList.add(hero4);
    doubleLinkedList.add(hero2);
    doubleLinkedList.add(hero3);
    s += doubleLinkedList.list();

    s += "==========更新測試==========\n";
    HeroNode2 newHeroNode = HeroNode2(no: 4, name: "張清", nickname: "沒羽箭");
    doubleLinkedList.update(newHeroNode);
    s += doubleLinkedList.list();

    s += "==========刪除測試==========\n";
    doubleLinkedList.delete(2);
    s += doubleLinkedList.list();

    return s;

  }

  /// 約瑟夫問題(Josephus Problem)
  /// 設編號為1,2,…n的n個人圍坐一圈，約定編號為k(1<=k<=n)的人從1開始報數，數到m的人出列，依此類推直到所有人出列為止，由此產生一個出隊編號的序列。
  ///
  /// 提示：
  /// 用一個不帶頭結點的循環鏈結串列來處理，先構成一個有n個結點的單循環鏈結串列，然後由k結點起從1開始計數，計到m時，對應結點從鏈結串列中刪除，然後再從被刪除結點的下一個結點又從1開始報數，直到最後一個結點從鏈結串列中刪除演算法結束。
  /// 設 n = 5 , k = 1(從1開始數), m = 2(數到第2個出隊列)
  /// 如下圖所示，出隊列順序為：
  /// 2 -> 4 -> 1 -> 5 -> 3
  ///
  /// 構建一個單項的環形鏈結串列
  ///
  /// 思路
  ///
  /// 先創建第一個節點，讓 first 指向該節點，並形成一個環形
  /// 後面當我們每創建一個新的節點，就把該節點加入到已有的環形鏈結串列中
  /// (每個節點的next指向下一個節點，最後一個節點的next指向第一個節點形成一個環)
  /// 遍歷環形鏈結串列
  ///
  /// 先讓一個輔助變數指向 first 節點
  /// 然後通過一個 while 循環遍歷該環形鏈結串列 cur.next == first
  /// 根據使用者的輸入，生成一個節點出隊列的順序：
  ///
  /// 需求創建一個輔助變數 helper，事先應該指向環形鏈結串列的最後節點
  /// 先讓 first 和 helper移動 k-1 次
  /// 當節點報數時，讓first和helper指針同時移動 m-1 次
  /// 這時就可以將first 指向節點出隊列
  /// – first = first.next
  /// – helper.next = first
  /// 原先first 指向的節點就沒有任何引用(出隊列了)，被垃圾回收。
  ///
  /// first 指向第一個數的節點
  /// helper 用於遍歷節點
  /// 假設今天n = 5 (總共5個節點), k = 1 (從1開始數) , m = 2 (數到2出隊列)
  ///
  /// 那麼first要指向第一個數的節點，所以是 1，helper 也先設為 first
  /// 然後將 first,helper 遍歷 2-1次
  /// 為什麼first也要跟著遍歷，它不是要指向第一個節點嗎?
  ///
  /// 那是因為當你數到 2 節點出隊列後，下一次就是從出隊列的後一個節點開始數，
  /// 所以 first 也需要跟著 helper 一起遍歷，如此一來，當 2 號節點出隊列後，first會指向 3，而helper也指向3 重新開始遍歷。
  /// 以此類推。
  /// 為什麼明明要數 2 次(m = 2)，卻只需要遍歷 2-1(m - 1)次?
  /// 如果會有這個疑惑就是對約瑟夫問題還沒理解，這裡的 m 代表數到幾出隊列，而開始數的那個節點也要計算，所以從 1節點 開始數，數到 2 就是 2號節點。
  /// 這些問題搞清楚之後回去看程式碼應該會很容易理解。
  //約瑟夫圈
  String josephusProblem(){
    String s = '';
    CircularSingleLinkedList circularSingleLinkedList = CircularSingleLinkedList();
    circularSingleLinkedList.addNode(41);

    // 加入5個節點
    s += "==========節點順序==========\n";
    s += circularSingleLinkedList.showNode();
    s += "==========出隊列順序==========\n";
    s += circularSingleLinkedList.countNode(1, 3, 41);

    return s;
  }

  /// 棧的介紹
  /// 先進後出(FILO)的有序列表
  /// 是限制線性表中元素的插入和刪除只能在線性表的同一端進行的一種特殊線性表。允許插入和刪除的一端，為變化的一端，稱為棧頂(top)，另一端為固定的一端，稱為棧底(bottom)。
  /// 入棧稱為PUSH，出棧稱為POP，PUSH和POP的順序和現實生活中堆書本是一樣的。
  ///
  /// 棧的應用場景
  /// 子程序的調用：在跳往子程序前，會先將下個指令的地址存在棧中，直到子程序執行完後再將地址取出，以回到原來的程序中。
  /// 處理遞歸調用：和子程序的調用類似，只是除了儲存下一個指令的地址外，也將參數、區域變數等數據存入到棧中。
  /// 表達式的轉換[中綴表達式轉後綴表達式]與求值
  /// 二元樹的遍歷
  /// 圖形的深度優先搜尋法(DFS)
  ///
  /// 棧的快速入門
  /// 思路分析
  /// 使用陣列來模擬棧
  /// 定義一個top 來表示棧頂，初始化為-1
  /// 入棧的操作，當有數據加入到棧時，top++; stack[top] = data;
  /// 出棧的操作，int value = stack[top];top--, return value
  //堆疊
  String stack() {
    String s = '';
    FourArithmetic fourArithmetic = FourArithmetic();
    //1. 1+((2+3)*4)-5 => 123+4*+5-
    //2. 直接對str進行操作並不方便，因此先將字串轉成一個中綴表示法的list
    //3. 即 1+((2+3)*4)-5 => ArrayList [1,+,(,(,2,+,3,),*,4,),-,5]
    String expression = "1+((2+3)*4)-5";
    List<String> infixExpressionList = fourArithmetic.toInfixExpressionList(expression);
    s += "中輟運算:$infixExpressionList\n";
    // LogUtil.e("stack infixExpressionList:$infixExpressionList"); //[1,+,(,(,2,+,3,),*,4,),-,5]

    List<String> prefixExpressionList = fourArithmetic.prefixExpressionList(infixExpressionList);
    s += "前輟運算:$prefixExpressionList\n";
    // LogUtil.e("stack prefixExpressionList:$prefixExpressionList"); //[+,+,1,2,3,*,4,-,5]

    //4. 將得到的中綴表達式對應的List => 後綴表達式對應的List
    //即 [1,+,(,(,2,+,3,),*,4,),-,5] => [1,2,3,+,4,*,+,5,-] , 小括號被消除掉了
    List<String> postFixExpressionList = fourArithmetic.postFixExpressionList(infixExpressionList);
    s += "後啜運算:$postFixExpressionList\n";
    // LogUtil.e("stack postfixExpressionList:$postFixExpressionList"); //[1,2,3,+,4,*,+,5,-]

    //計算後綴表達式結果
    int calculate = fourArithmetic.calculate(postFixExpressionList);
    s += "結果:$calculate";
    // LogUtil.e("stack expression:$calculate");
    return s;
  }

  /// 遞迴就是一個函式直接或間接的呼叫自己本身，用相同的方法解決重複性的問題，有助於programmer解決複雜的問題，同時可以讓代碼變得簡潔。
  ///
  /// 遞迴調用規則
  /// 當程序執行到一個方法時，就會開闢一個獨立的空間(棧)
  /// 每個空間的數據(局部變數)是獨立的。
  /// 如果方法中使用的是引用類型變數(比如陣列)，就會共享該引用類型的數據，即每個棧用的數據指向同一份數據空間
  /// 遞迴必須向退出遞迴的條件逼近，否則就是無限遞迴 StackOverfloweError(棧溢出)
  /// 當一個方法執行完畢後，或者遇到return，就會返回，遵守誰調用就將結果返回誰，同時當方法執行完畢或者返回時，該方法也就執行完畢。
  ///
  /// 遞迴能解決什麼問題?
  /// 各種數學問題如：八皇后問題、河內塔、階乘問題、迷宮問題、球和籃子的問題
  /// 各種演算法中也會使用到遞迴，比如：快速排序法、合併排序法、二分搜尋法、分治法…等。
  /// 將用棧解決的問題改為遞迴，程式碼會比較簡潔。
  ///
  /// 八皇后問題分析和實現
  /// 八皇后問題是一個古老而著名的問題，是回溯演算法的典型案例。該問題是國際西洋棋手馬克思於1848年提出：在8*8格的國際象棋上擺放八個皇后，使其不能互相攻擊。
  /// 規則
  /// 西洋棋中的皇后可以攻擊棋盤上同行、同列、同對角線的位置，所以要如何在 8*8 棋盤上擺放八個皇后並且每個皇后不會攻擊到彼此是一個需要去思考的問題。
  /// 總的來說，就是每個皇后的同行、同列、同對角線不能有別的皇后。
  //遞迴
  String recursion() {
    String s = '';
    MiGong miGong = MiGong(row: 10, col: 10);
    miGong.buildMap();

    //使用遞迴給小球找路
    s += "遞迴輸出新的地圖:\n";
    s += "show:\n${miGong.showMap()}\n";
    s += "小球走的位置(7,7):\n";
    s += "${miGong.setWay(7, 7)}\n";

    EightQueen eightQueen = EightQueen();
    s += eightQueen.checkPosition(0);
    // s += "8皇后:一共有$count種解法";

    return s;
  }

  /// 基本介紹
  /// 雜湊表是根據 鍵(key) 直接查詢在記憶體儲存位置的資料結構。
  /// 鍵 如：剛剛舉例的 id
  /// 它通過把鍵值映射到表中一個位置來訪問記錄，以加快搜尋的速度。
  /// 這個映射函數叫做雜湊函數，存放記錄的陣列叫做雜湊表。
  /// 一個通俗的例子是，為了查找電話簿中某人的號碼，可以創建一個按照人名首字母順序排列的表(即建立人名 x 到首字母 F(x) 的一個函數關係)，在首字母為W的表中查找「王」姓的電話號碼，顯然比直接查找就要快得多。這裡使用人名作為關鍵字，「取首字母」是這個例子中雜湊函數的函數法則F()，存放首字母的表對應雜湊表。
  /// 關鍵字和函數法則理論上可以任意確定。
  ///
  /// 應用場景
  /// 我們常常會需要去資料庫抓取資料然後返回，但有些數據沒有必要每次都去資料庫抓取，所以一般來說會加一個cache，將常用的數據存在cache，直接在cache抓取數據。
  /// 通常來說我們可以用常見的Redis、Memcache來實現，但我們也可以自己寫出，比如利用雜湊表，可以把數據先放入到雜湊表中，取數據先在雜湊表中取，這樣取數據的時候便無須到資料庫取，節省了部分時間。
  ///
  /// 舉例說明
  /// 因為目前還沒提到二元樹的部分，所以我們雜湊表的實現是以陣列加鏈結串列為主。
  /// 陣列放的是鏈結串列 => 鏈結串列陣列
  /// 用雜湊函數得到這個數據在哪個鏈結串列。
  /// 比如這張圖，有 16 個鏈結串列，我要找到 111 這個值，只需要 111 % 16 = 15 就能知道 111 在第十五個鏈結串列中。
  //雜湊表
  String hashTable(){
    // 創建雜湊表
    HashTable hashTable = HashTable(7);
    final List<String> listName = List.generate(7, (index) => '');

    int i;
    String s = '';

    s += 'add 添加員工資訊:\n';
    for(i = 0; i < listName.length; i++) {
      if(i == 1){
        listName[i] = 'Sandy';
      }else if(i == 6){
        listName[i] = 'Tom';
      }
      hashTable.add(Emp(id: i+1, name: listName[i]));
      s += '輸入員工id:${i+1}\t輸入員工名字:${listName[i]}';
      if(i == listName.length - 1){
        s += '\n';
      }else{
        s += '\t';
      }
    }

    s += 'find 搜尋員工資訊:\n';
    for(i = 0; i < hashTable.size; i++){
      s += '請輸入要搜尋的id:${i+1}';
      s += hashTable.findById(i+1);
      if(i != hashTable.size - 1){
        s += '\t';
      }
    }

    s += 'delete 刪除員工資訊:\n';
    for(i = 0; i < hashTable.size; i++){
      s += '請輸入要刪除的id:${i+1}';
      s += hashTable.deleteById(i+1);
      if(i == hashTable.size - 1){
        s += '\n';
      }else{
        s += '\t';
      }
    }

    s += 'list 顯示員工資訊:\n${hashTable.list()}\n';
    s += 'exit 退出系統';
    return s;
  }

  /// 在樹狀結構中的基本單位，稱為節點（Node）。
  /// 節點之間的連結，稱為分支（branch）。
  /// 節點與分支形成樹狀，結構的開端，稱為根（root），或根節點。
  /// 根節點之外的節點，稱為子節點（child）。
  /// 沒有連結到其他子節點的節點，稱為葉子節點（Leaf）。
  /// 也就是說，雖然稱之為樹，但是其上下顛倒，根節點指的是最上面資料的開頭，而葉子節點是最下面沒有子節點的資料。
  ///
  /// 定義與特性
  /// 由 1 個以上的節點所構成的集合，不可為空。
  /// 至少有一個特殊節點，稱為根節點。
  /// 一個節點可以有多個子節點。
  /// 無左右次序。
  /// 為什麼需要樹結構
  ///
  /// 我們先來回顧一下之前提到過的儲存方式
  ///
  ///【陣列】
  /// 優點：可以通過索引訪問元素，速度快，對於有序陣列還可以用二元搜尋找提高搜尋速度。
  /// 缺點：當要搜尋具體某個值，或者插入、刪除元素會整體移動，效率較低。
  /// 因為陣列大小是固定的，若想要插入新的值，需要陣列擴容：每次在底層都需要創建新陣列，並將原來的陣列數據 copy 回去並插入新的數據。
  ///
  ///【鏈結串列】
  /// 優點：一定程度上對陣列儲存方式有優化，插入和刪除元素只需要修改鏈結即可。
  /// 缺點：在進行搜尋時效率仍然較低，比如要搜尋某個值，需要從頭節點開始遍歷。
  ///
  ///【樹】
  /// 能提高數據存儲、讀取的效率，比如利用二元排序樹(Binary Sort Tree)，既可以保證數據的搜尋速度，同時也可以保證數據的插入、刪除、修改的速度。
  ///
  ///二元樹
  /// Binary Search Tree、Heap、Huffman Tree、BSP Tree這些通通都是二元樹，二元樹的應用相當廣泛，在今年前後端和資料工程師LeetCode 面試調查中一致選出幫助最大的演算法就是二元樹。
  /// 樹分很多種，二元樹是每個節點最多只有兩個分支的樹結構，節點左邊稱為左子樹，節點右邊稱為右子樹，二元樹的分支具有左右次序，不能隨意顛倒。
  ///
  /// 二元樹的遍歷
  /// 二元樹的遍歷分為三種順序：
  /// 前序：先輸出父節點，再遍歷左子樹和右子樹。
  /// 中序：先遍歷左子樹，再輸出父節點，再遍歷右子樹。
  /// 後序：先遍歷左子樹，再遍歷右子樹，最後輸出父節點。
  /// 小結：看輸出父節點的順序就能確定是前序、中序還是後序。
  ///
  /// 思路
  /// 創建一顆二元樹
  /// 前序遍歷
  /// 2.1 先輸出當前節點(初始的時候是根節點)
  /// 2.2 如果左子節點不為空，則遞迴前序遍歷
  /// 2.3 如果右子節點不為空，則遞迴前序遍歷
  /// 中序遍歷
  /// 3.1 如果當前節點的左子節點不為空，則遞迴中序遍歷
  /// 3.2 輸出當前節點
  /// 3.3 如果當前節點的右子節點不為空，則遞迴中序遍歷
  /// 後序遍歷
  /// 4.1 如果當前節點的左子節點不為空，則遞迴後序遍歷
  /// 4.2 如果當前節點的右子節點不為空，則遞迴後序遍歷
  /// 4.3 輸出當前節點
  ///
  /// 運算式的二元樹
  /// 補充一個運算式的二元樹，使用二元樹前序後序遍歷應該就能快速的得知前綴後綴如何表式。
  /// 中綴為：[((6 + 4) / 2) * (9 + (4 - 3))]
  /// 前序：* / + 6 4 2 + 9 - 4 3 即為前綴表示法
  /// 後序：6 4 + 2 / 9 4 3 - + * 即為後綴表示法
  ///
  /// 二元樹的搜尋
  /// 思路
  ///
  /// 前序搜尋
  /// 先判斷當前節點的 no 是否等於要搜尋的。
  /// 如果相等 返回當前節點。
  /// 如果不等，則判斷當前節點的左子節點是否為空，如果不為空，則遞迴前序搜尋。
  /// 如果左遞迴搜尋，找到節點則返回，否則繼續判斷，當前節點的右子節點是否為空，如果不空，則繼續向右遞迴前序搜尋。
  ///
  /// 中序搜尋
  /// 判斷當前節點的左子節點是否為空，如果不為空，則遞迴中序搜尋。
  /// 如果找到，則返回，如果沒找到就和當前節點比較，如果是則返回當前節點，否則繼續進行右遞迴的中序搜尋。
  /// 如果右遞迴中序搜尋，找到就返回，否則返回 null。
  ///
  /// 後序搜尋
  /// 判斷當前節點的左子節點是否為空，如果不為空，則遞迴後序搜尋。
  /// 如果找到，則返回，如果沒找到就判斷當前節點的右子節點是否為空，如果不為空則右遞迴進行後序搜尋，如果找到就返回。
  /// 就和當前節點進行比較，比如，如果是則返回，否則返回 null。
  ///
  ///思路
  /// 考慮如果樹是空樹，或只有一個root節點，則等於將二元樹置空。
  /// 因為二元樹是單向的，所以我們是判斷當前節點的子節點是否需要刪除節點，而不能去判斷當前這個節點是不是需要刪除節點。
  /// 如果當前節點的左子節點不為空，並且左子節點就是要刪除節點，就將this.left = null; 並且就返回(結束遞迴刪除)。
  /// 如果當前節點的右子節點不為空，並且右子節點就是要刪除節點，就將this.right = null; 並且就返回(結束遞迴刪除)。
  /// 如果第三第四步都沒有刪除節點，就需要向左子樹進行遞迴刪除。
  /// 如果第五步也沒有刪除節點，則應向右子樹進行遞迴刪除。
  /// 首先需要先處理第一點，如果這個二元樹並非空樹或者僅有一個root節點才需要去考慮 2 ~ 6 步。
  //二元樹
  String binaryTree(){
    String s = '看Log\n';

    BinaryTree binaryTree = BinaryTree();
    HeroNode3 root = HeroNode3(1, "宋江");
    HeroNode3 node2 = HeroNode3(2, "吳用");
    HeroNode3 node3 = HeroNode3(3, "盧俊");
    HeroNode3 node4 = HeroNode3(4, "林沖");
    HeroNode3 node5 = HeroNode3(5, "關勝");

    root.setLeft(node2);
    root.setRight(node3);
    node3.setLeft(node4);
    node3.setRight(node5);
    binaryTree.setRoot(root);

    // s += "==========前序遍歷==========\n";
    // binaryTree.preOrder();
    // s += _getBinaryTree(binaryTree);
    s += "==========中序遍歷==========\n";
    binaryTree.inOrder();
    s += _getBinaryTree(binaryTree);
    // s += "==========後序遍歷==========\n";
    // binaryTree.postOrder();
    // s += _getBinaryTree(binaryTree);

    HeroNode3 resNode;
    // s += "~~~~~~~~~~前序搜尋~~~~~~~~~~\n";
    // resNode = binaryTree.preOrderSearch(5);
    // final no = resNode.no;
    // final name = resNode.name;
    // if(resNode != null) {
    //   s += "訊息為 no = $no , name = $name\n";
    //   LogUtil.e("訊息為 no = $no , name = $name\n");
    // } else {
    //   s += "preOrderSearch:找不到資訊";
    //   LogUtil.e("dataStructure binaryTree preOrderSearch:找不到資訊");
    // }

    s += "~~~~~~~~~~中序搜尋~~~~~~~~~~\n";
    resNode = binaryTree.infixOrderSearch(5);
    final no = resNode.no;
    final name = resNode.name;
    if(resNode != null) {
      s += "訊息為 no = $no , name = $name\n";
      LogUtil.e("訊息為 no = $no , name = $name\n");
    } else {
      s += "infixOrderSearch:找不到資訊";
      LogUtil.e("dataStructure binaryTree infixOrderSearch:找不到資訊");
    }

    // s += "~~~~~~~~~~後序搜尋~~~~~~~~~~\n";
    // resNode = binaryTree.postOrderSearch(5);
    // if(resNode != null) {
    //   s += "訊息為 no = $no , name = $name\n";
    //   LogUtil.e("訊息為 no = $no , name = $name\n");
    // } else {
    //   s += "postOrderSearch:找不到資訊";
    //   LogUtil.e("dataStructure binaryTree postOrderSearch:找不到資訊");
    // }

    binaryTree.deleteNode(no);
    // s += "##########前序刪除##########\n";
    // binaryTree.preOrder();
    // s += _getBinaryTree(binaryTree);
    s += "----------中序刪除----------\n";
    binaryTree.inOrder();
    s += _getBinaryTree(binaryTree);
    // s += "----------後序刪除----------\n";
    // binaryTree.postOrder();
    // s += _getBinaryTree(binaryTree);

    return s;
  }

  String _getBinaryTree(BinaryTree binaryTree){
    return "${binaryTree.getRoot()}"
           "${binaryTree.getRoot().getLeft()}${binaryTree.getRoot().getRight()}"
           "${binaryTree.getRoot().getRight().getLeft()}${binaryTree.getRoot().getRight().getRight()}";
  }

  /// 一個二元樹通過線索連起來。所有原本為空的右(孩子)指針改為指向該節點在中序序列中的後繼，所有原本為空的左(孩子)指針改為指向該節點的中序序列的前驅。
  /// 假設該二元樹中序遍歷為 A B C D E F G H I，根據上述說明試著解讀為何這些節點的線索是這樣連的。
  ///
  /// 線索二元樹能線性地遍歷二元樹，從而比遞迴的中序遍歷更快，並且建立線索並不影響時間複雜度。
  /// 使用線索二元樹也能夠方便的找到一個節點的父節點，這比多宣告一個父親節點指針來找 或者用 棧 效率更高。
  /// 這在棧空間有限、無法使用存儲父節點的棧時很有作用(對於通過深度優先搜索DFS來搜尋父節點而言)。
  /// 因此，當使用線索二元樹時，Node節點的left和right屬性有以下情況需要考慮：
  ///
  /// left 指向的是左子樹，也可能是指向前驅節點。
  /// right 指向的是右子樹，也可能是指向後繼節點。
  ///
  /// 線索二元樹的遍歷
  /// 在前面二元樹的部分有提到過遍歷，但是因為線索化後各個節點指向有變化，因此原來的遍歷方式不能使用，需要使用新的方式遍歷線索化二元樹。
  /// 各個節點可以通過線性方式遍歷，無需使用遞迴方式，提高了遍歷的效率。遍歷的次序應當和中序遍歷保持一致。
  //線索二元樹
  String threadedBinaryTree(){
    String s = '';

    TreeNode root = TreeNode(1, "Tom");
    TreeNode node2 = TreeNode(3, "Jack");
    TreeNode node3 = TreeNode(6, "Smith");
    TreeNode node4 = TreeNode(8, "Mary");
    TreeNode node5 = TreeNode(10, "King");
    TreeNode node6 = TreeNode(14, "Candy");

    // 簡單處理使用手動創建
    root.setLeft(node2);
    root.setRight(node3);
    node2.setLeft(node4);
    node2.setRight(node5);
    node3.setLeft(node6);

    ThreadedBinaryTree threadedBinaryTree = ThreadedBinaryTree();
    threadedBinaryTree.setRoot(root);
    threadedBinaryTree.infixThreadedNodes(root);

    // 原本 10 的左指針為空 , 線索化後左指針指向前驅節點 3
    TreeNode leftNode = node5.getLeft();
    s += '10號節點的前驅節點為:$leftNode';
    // 原本 10 的右指針為空 , 線索化後右指針指向後繼節點 1
    TreeNode rightNode = node5.getRight();
    s += '10號節點的後驅節點為:$rightNode';
    LogUtil.e("10號節點的前後驅節點為:$leftNode$rightNode");

    // 測試中序線索化
    s += '=====中序遍歷線索化二元樹=====\n';
    LogUtil.e("=====中序遍歷線索化二元樹=====\n");
    s += threadedBinaryTree.infixThreadedList(); //中:8, 3, 10, 1, 14, 6
    // 測試前序線索化
    s += '=====前序遍歷線索化二元樹=====\n';
    LogUtil.e("======前序遍歷線索化二元樹=====\n");
    threadedBinaryTree.preThreadedNodes(root);
    s += threadedBinaryTree.preThreadedList(); //前:1, 3, 8, 10, 6, 14

    LogUtil.e("----------前序遍歷----------\n");
     s += threadedBinaryTree.preOrderSearch(3).toString();
    // LogUtil.e("----------中序遍歷----------\n");
    // threadedBinaryTree.infixOrderSearch(3);
    // LogUtil.e("----------後序遍歷----------\n");
    // threadedBinaryTree.postOrderSearch(3);

    return s;
  }

  /// 對於二元搜尋樹的任何一個非葉子節點，要求左子節點的值比當前節點的值小，右子節點的值比當前節點的值大。如果有相同的值，可以將該節點放在左子節點或右子節點。
  ///
  /// 二元搜尋樹的刪除
  /// 需要考慮的情況：
  /// 刪除葉子節點(ex: 2, 5, 9, 12)
  /// 刪除只有一棵子樹的節點(ex: 1)
  /// 刪除有兩棵子樹的節點(ex: 7, 3, 10)
  ///
  /// 刪除葉子節點
  /// 思路
  /// 需要先去找到要刪除的節點 targetNode
  /// 找到 targetNode 的父節點 parent (考慮是否存在父節點)
  /// 確定 targetNode 是 parent的左子節點還是右子節點
  /// 根據前面的情況來對應刪除
  /// 左子節點 parent.left = null , 右子節點 parent.right = null
  ///
  /// 刪除只有一棵子樹的節點
  /// 思路
  /// 需要先去找到要刪除的節點 targetNode
  /// 找到 targetNode 的父節點 parent (考慮是否存在父節點)
  /// 確定 targetNode 的子節點是左子節點還是右子節點
  /// targetNode 是 parent 的左子節點還是右子節點
  /// 如果 targetNode 是 parent 的左子節點
  /// 5.1 targetNode 的子節點是左子節點 parent.left = targetNode.left
  /// 5.2 targetNode 的子節點是右子節點 parent.left = targetNode.right
  /// 如果 targetNode 是 parent 的右子節點
  /// 5.1 targetNode 的子節點是左子節點 parent.right = targetNode.left
  /// 5.2 targetNode 的子節點是右子節點 parent.right = targetNode.right
  ///
  /// 刪除有兩棵子樹的節點
  /// 思路
  /// 需要先去找到要刪除的節點 targetNode
  /// 找到 targetNode 的父節點 parent (考慮是否存在父節點)
  /// 從 targetNode 的右子樹找到最小的節點 (或者左子樹最大的節點)
  /// 用一個臨時變數，將最小節點的值保存 temp
  /// 刪除該最小節點
  /// targetNode.value = temp
  //二元搜尋樹
  String searchBinaryTree(){
    String s = '';

    List<int> arr = [7, 3, 10, 12, 5, 1, 9, 2];
    SearchBinaryTree binarySearchTree = SearchBinaryTree();
    // 循環添加節點到二元搜尋樹
    for(int i = 0; i < arr.length; i++) {
      binarySearchTree.add(Node2(arr[i]));
    }

    s += '看Log';
    // 中序遍歷二元搜尋樹
    LogUtil.e("=====中序遍歷二元搜尋樹=====");
    binarySearchTree.infixOrder(); // 1, 2, 3, 5, 7, 9, 10, 12

    LogUtil.e("=======刪除節點 2=======");
    binarySearchTree.deleteNode0(2);
    binarySearchTree.infixOrder(); // 1, 3, 5, 7, 9, 10, 12

    LogUtil.e("=======刪除節點 1=======");
    binarySearchTree.deleteNode1(1);
    binarySearchTree.infixOrder(); // 3, 5, 7, 9, 10, 12

    LogUtil.e("=======刪除節點 7=======");
    binarySearchTree.deleteNode2(7);
    binarySearchTree.infixOrder(); // 3, 5, 9, 10, 12

    return s;
  }

  /// 我們知道，前面討論的資料結構都有一個框架，而這個框架是由相應的演演算法實現的，比如二元樹搜尋樹，左子樹上所有結點的值均小於它的根結點的值，右子樹所有結點的值均大於它的根節點的值，
  /// 類似這種形狀使得它容易搜尋資料和插入資料，樹的邊表示了從一個節點到另一個節點的快捷方式。而圖通常有個固定的形狀，這是由物理或抽象的問題所決定的
  /// ①、鄰接：
  /// 如果兩個頂點被同一條邊連線，就稱這兩個頂點是鄰接的，如上圖 I 和 G 就是鄰接的，而 I 和 F 就不是。有時候也將和某個指定頂點鄰接的頂點叫做它的鄰居，比如頂點 G 的鄰居是 I、H、F。
  /// ②、路徑：
  /// 路徑是邊的序列，比如從頂點B到頂點J的路徑為 BAEJ，當然還有別的路徑 BCDJ，BACDJ等等。
  /// ③、連通圖和非連通圖：
  /// 如果至少有一條路徑可以連線起所有的頂點，那麼這個圖稱作連通的；如果假如存在從某個頂點不能到達另外一個頂點，則稱為非聯通的。
  /// ④、有向圖和無向圖：
  /// 如果圖中的邊沒有方向，可以從任意一邊到達另一邊，則稱為無向圖；比如雙向高速公路，A城市到B城市可以開車從A駛向B，也可以開車從B城市駛向A城市。但是如果只能從A城市駛向B城市的圖，那麼則稱為有向圖。
  /// ⑤、有權圖和無權圖：
  /// 圖中的邊被賦予一個權值，權值是一個數位，它能代表兩個頂點間的物理距離，或者從一個頂點到另一個頂點的時間，這種圖被稱為有權圖；反之邊沒有賦值的則稱為無權圖。
  /// 本篇部落格我們討論的是無權無向圖。
  //圖
  String graph(){
    String s = '';

    Graph graph = Graph();
    graph.addVertex('A');
    graph.addVertex('B');
    graph.addVertex('C');
    graph.addVertex('D');
    graph.addVertex('E');
    graph.addEdge(0, 1);//AB
    graph.addEdge(1, 2);//BC
    graph.addEdge(0, 3);//AD
    graph.addEdge(3, 4);//DE
    s += "深度優先搜尋演算法:\n";
    // LogUtil.e("深度優先搜尋演演算法:\n");
    s += "${graph.depthFirstSearch()}\n";//ABCDE
    LogUtil.e("\n----------------------\n");
    s += "廣度優先搜尋演算法:\n";
    // LogUtil.e("廣度優先搜尋演演算法:\n");
    s += "${graph.breadthFirstSearch()}\n";//ABCDE
    s += "最小升成樹:\n";
    s += "${graph.mst()}\n";

    List<String> listVertex = ['A', 'B', 'C', 'D', 'E'];//頂點
    List<Edge1> edges = [
      //邊//起點//終點//權
      Edge1('A', 'B', 5.6),
      Edge1('A', 'C', 1.0),
      Edge1('A', 'D', 4.2),
      Edge1('B', 'C', 2.7),
      Edge1('C', 'A',  1.0),
      Edge1('C', 'B',  2.7),
      Edge1('E', 'B',  -3.0)
    ];
    AdjacencyList adjacencyList = AdjacencyList(listVertex, edges);
    final list = adjacencyList.getList;
    s += "鄰接表:\n";
     for (int i = 0; i < list.length; i++) {
       s += "Index:${list[i].index}\tWeight:${list[i].weight}\t";
       if(i == list.length - 1){
         s += "\n";
       }
     }
    AdjacencyMatrix adjacencyMatrix = AdjacencyMatrix(edges.length);
    s += "鄰接陣列:\n";
    s += "edges:${adjacencyMatrix.getNumOfEdges()}\tvertexs:${adjacencyMatrix.getNumOfVertexs()}\tfirst:${adjacencyMatrix.getFirstNeighbor(0)}\tnext:${adjacencyMatrix.getNextNeighbor(0, 1)}";

    return s;
  }

}