import 'package:flutter_practice2/algorithm/search_algorithm.dart';

class SearchUtil{

  final SearchAlgorithm _searchAlgorithm = SearchAlgorithm();

  /// 資料不須事先排序，僅需遍歷一一比對，發現有與鍵值相同的值就返回索引。
  /// 舉例說明: 有一陣列：{1, 8, 10, 89, 1000, 1234}，判斷陣列中是否包含此元素要求：如果找到了，就提示找到，並給出索引值。
  //線性搜尋法(Linear Search)
  String linear() {
    List<int> arr = [1, 8, 10, 89, 1000, 1234];
    return _searchAlgorithm.linear(arr, 10).toString();
    // 時間複雜度
    // (1+2+3+…+n)/n = (n+1)/2 ⇒ Ο(n)
  }

  /// 注意：使用二元搜尋的前提是該陣列是有序的。
  /// 兩種方式實現：遞迴、非遞迴，下面主要講遞迴的方式實現。
  /// 舉例說明
  /// 請對一個有序數組進行二分搜尋 {1,8, 10, 89, 1000, 1234} ，輸入一個數看看該數組是否存在此數，並且求出索引，如果沒有就提示"沒有這個數"。
  /// 思路
  /// 首先確定該陣列的中間索引 mid = (left + right) /2
  /// 然後讓需要搜尋的數 findVal 和 arr[mid] 比較
  /// 2.1 findVal > arr[mid] ，說明要搜尋的數在mid右邊，因此需要遞迴的向右搜尋。
  /// 2.2 findVal < arr[mid] ，說明要搜尋的數在mid左邊，因此需要遞迴的向左搜尋。
  /// 2.3 findVal == arr[mid]，說明找到，就返回。
  /// 什麼時候結束遞迴?
  /// 找到要搜尋的值。
  /// 遞迴完整個陣列，仍然沒有找到findVal，也需要結束遞迴(當left > right就需要退出)。
  ///
  /// 陣列中有多個相同數值
  /// 如果陣列中有多個相同的數值，那麼搜尋時只會返回第一個找到的索引，例如：
  ///
  /// 思路分析
  /// 在找到 mid 索引值不要馬上返回
  /// 向 mid 索引值的左邊遍歷，將所有滿足的元素的索引加入到ArrayList
  /// 向 mid 索引值的右邊遍歷，將所有滿足的元素的索引加入到ArrayList
  /// 將 ArrayList 返回
  /// 首先，我們把方法返回的型態從 int 改為 ArrayList<Integer>
  //二元搜尋法(Binary Search)
  String binary() {
    String s = '';
    List<int> arr = [1, 8, 10, 89, 1000, 1234];
    int index = _searchAlgorithm.binary(arr, 0, arr.length - 1, 8);
    s += "搜尋的數索引為1:$index\n";
    int index2 = _searchAlgorithm.binary(arr, 0, arr.length - 1, 1000);
    s += "搜尋的數索引為2:$index2\n";
    int index3 = _searchAlgorithm.binary(arr, 0, arr.length - 1, 5); // 沒有找到
    s += "搜尋的數索引為3:$index3\n";
    int index5 = _searchAlgorithm.leeCode(arr, 1000);
    s += "1000 在陣列中的索引為:$index5\n";
    arr.insert(4, 1000);
    arr.insert(4, 1000);
    int index4 = _searchAlgorithm.binary(arr, 0, arr.length - 1, 1000);
    s += "搜尋的數索引為4:$index4\n";
    List<int> list = _searchAlgorithm.binaryList(arr, 0, arr.length - 1, 1000);
    s += "1000 在陣列中的索引為:$list\n";
    return s;
    // 時間複雜度
    // T(n) = T(n/2) + Ο(1) = Ο(log2n)
  }

  /// 插值搜尋法(Interpolation search)是假設資料呈線性相關分布，利用斜率公式來計算猜測搜尋鍵值的位置。搜尋方式與二分搜尋相同。
  /// 回想一下剛剛二元搜尋法，假設我們今天有一陣列如下，並且要搜尋 1 ：
  /// 使用二元搜尋法我們搜尋 1 需要調用 4 次，實際上這樣並不是很有效率，因為我們需要找到中間值再去找到 1。那麼，我們需要一種能夠快速定位到我們想要搜尋的值的方法，插值搜尋法可以實現我們想要達到的效果。
  ///
  /// 原理說明
  /// 插值搜尋法其實和二元搜尋很類似，不一樣之處在於插值是每次從自訂的 mid 處開始搜尋。
  /// 將折半搜尋中的求 mid 索引的公式，low 表示左邊索引，high表示右邊索引。
  /// int mid = left + (right - left) * (findVal - arr[left]) / (arr[right] - arr[left]);
  /// 以下圖為例說明此公式是怎麼來的：
  /// left = x1 , right = x2
  /// arr[left] = arr[x1] , arr[right] = arr[x2]
  /// findVal = arr[m]
  ///
  /// 我們使用第三點的公式再回頭來算，我們需要幾次才能在這個陣列中搜尋到 1 呢？
  ///
  /// int arr[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
  /// List<Integer> resIndexList = insertSearch(arr, 0, arr.length - 1, 1);
  /// 計算 mid：int mid = 0 + (9 - 0) * (1 - 1) / (10 - 0) = 0
  /// 直接就找到 1 在arr[0]。
  /// 假設要搜尋 8
  /// 計算 mid：int mid = 0 + (9 - 0) * (8 - 1) / (10 - 0) = 6.3
  /// 直接就找到 8 在arr[7]。 *小數無條件進位
  /// 也因此，插值很適合用在數據量龐大並且陣列比較連續的情況。
  ///
  /// 注意事項
  /// 對於數據量較大，關鍵字分佈比較均勻的陣列來說，採用插值斯巡速度較快。
  /// 關鍵字分佈不均勻的情況下，該方法不一定比二元搜尋法要好。
  //插值搜尋法(Interpolation Search)
  String interpolation() {
    String s = '';
    List<int> arr = List.filled(100, 0);
    for(int i = 0; i < 100 ; i++) {
      arr[i] = i + 1;
    }
    s += "原陣列:$arr";
    int index = _searchAlgorithm.insertValueSearch(arr, 0, arr.length - 1, 55);
    s += "55 在陣列中索引為:$index";
    return s;
  }

  /// 和前面提到的二元搜尋和插值搜尋法類似，改變了中間節點 mid 的位置，mid不再是中間或插值得到，而是位於黃金分割點附近，搜尋時間為O(logn)。
  /// 基本介紹
  /// 大家應該都聽過費氏數列
  /// {1, 1, 2, 3, 5, 8, 13, 21, 34, 55}
  /// 2 = 1 + 1
  /// 3 = 2 + 1
  /// 5 = 3 + 2
  /// 8 = 5 + 3
  /// 費氏數列的兩個相鄰數的比例無限接近黃金比例 0.618
  ///
  /// 費氏搜尋法就是利用這個特性設計的。
  ///
  /// *用小算盤計算一下相鄰兩個值的比例都接近 0.618：
  /// 原理說明
  ///
  /// 和前面提到的二元搜尋和插值搜尋法類似，也是一樣改變了中間節點 mid 的位置，mid不再是中間或插值得到，而是位於黃金分割點附近，即 mid = left + F[k-1] - 1 (F代表費氏數列)
  ///
  /// F[k] = F[k-1] + F[k-2]
  /// F[k-1] = (F[k-1] - 1) + (F[k-2] - 1) + 1
  /// k = 黃金分割點
  /// 但順序表長度 n 不一定剛好等於 F[k]-1，所以需要將原來的順序表長度 n 增加至 F[k]-1。這裡的k值只要能使得 F[k]-1 恰好大於或等於 n 即可，由以下代碼得到，
  /// 順序表長度增加後，新增的位置(從 n+1 到 F[k]-1 位置)，都賦為 n 位置的值即可。
  //費氏搜尋法(Fibonacci Search)
  String fibSearch(){
    String s = '';
    List<int> arr = [1, 8, 10, 89, 1000, 1234];
    s += "index = ${_searchAlgorithm.fibSearch(arr, 1)}\n";
    s += "index = ${_searchAlgorithm.fibSearch(arr, 8)}\n";
    s += "index = ${_searchAlgorithm.fibSearch(arr, 555)}\n";
    s += "index = ${_searchAlgorithm.fibSearch(arr, 1000)}\n";
    return s;
  }


}