import 'dart:core';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../az_listview/common/index.dart';
import '../data_structure/array_queue.dart';
import '../data_structure/circular_single_linked_list.dart';
import '../data_structure/double_linked_list.dart';
import '../data_structure/single_linked_list.dart';

class DataStructureUtil{

  /// 五子棋程序如何存取盤的下棋情況？
  ///
  /// A：可以使用二維陣列，將黑棋白棋記錄下來。
  ///
  ///
  /// 思考
  /// Q：該二維陣列很多值默認為0，因此記錄了很多沒意義的數據，該如何去解決？
  /// A：可以使用稀疏矩陣來保存該陣列。
  ///
  /// 稀疏矩陣的處理方法
  ///
  /// 記錄陣列一共有幾行幾列，有多少個不同的值。
  /// 把具有不同值的元素的行列及值記錄在一個小規模的陣列中，從而縮小程式的規模。
  /// 以下圖為例，我們可以將原先 6*7 = 42 的陣列縮減為 9*3 = 27 的陣列：
  ///
  /// 【小結】
  ///
  /// 使用稀疏矩陣的情況：
  ///
  /// 當一個陣列有很多沒意義數據(0)或相同數據。
  /// 處理方法：
  ///
  /// 第一行記錄陣列共幾列幾行並且有幾個非0的值。
  /// 第二行開始用於紀錄每個非0值在陣列第幾列第幾行、值為多少。
  /// 二維陣列 轉 稀疏矩陣
  ///
  /// 思路
  ///
  /// 遍歷原始的二維陣列，得到有效數據的個數(sum)。
  /// 根據sum 就可以創建稀疏矩陣parseMatrix int[sum+1][3]
  /// 將二維陣列的有效數據存入到稀疏矩陣。
  /// 稀疏矩陣 轉 二維陣列
  ///
  /// 思路
  ///
  /// 先讀取稀疏矩陣第一行，根據第一行的數據創建原始的二維陣列，比如上方圖示chessArr = int[11][11]
  /// 再讀取稀疏矩陣後幾行的數據，並賦給原始的二維陣列。
  ///

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
  ///
  // 佇列(Queue)與環形佇列
  String queue(int count) {
    List<int> arr = List.filled(5, 0);
    List<int> newArr = List.filled(5, 0);
    ArrayQueue queue = ArrayQueue(arr: arr, maxSize: arr.length, front: arr.last, rear: arr.first);
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
    circularSingleLinkedList.addNode(41); // 加入5個節點
    s += "==========節點順序==========\n";
    s += circularSingleLinkedList.showNode();
    s += "==========出隊列順序==========\n";
    s += circularSingleLinkedList.countNode(1, 3, 41);
    return s;
  }


}