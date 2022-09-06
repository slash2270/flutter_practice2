class SearchAlgorithm{

  int linear(List<int> arr, int value) {
    //逐一比對，發現有相同值就返回索引
    for(int i = 0; i < arr.length; i++){
      if(arr[i] == value) {
        return i;
      }
    }
    return -1;
  }

  //注意：使用二元搜尋的前提是該陣列是有序的。
  /// @param arr 陣列
  /// @param left 左邊的索引
  /// @param right 右邊的索引
  /// @param findVal 要搜尋的值
  /// @return 如果找到就返回索引,如果沒找到就返回 -1
  int binary(List<int> arr, int left, int right, int findVal) {
    int mid = (left + right) ~/ 2;
    int midVal = arr[mid];
    // 當 left > right 代表遞迴整個陣列但是沒有找到
    if (left > right) {
      return -1;
    }

    if (findVal > midVal) { // 向右遞迴
      return binary(arr, mid + 1, right, findVal);
    } else if (findVal < midVal) {
      return binary(arr, left, mid - 1, findVal);
    } else {
      return mid;
    }

  }

  List<int> binaryList(List<int> arr, int left, int right, int findVal) {
    int mid = (left + right) ~/ 2;
    int midVal = arr[mid];
    // 還有搜尋的數找不到原先是返回 -1 ，現在因為返回型態改為 ArrayList 所以我們改成返回一個空list。
    if (left > right) {
      return [];
    }

    if (findVal > midVal) {
      // 向右遞迴
      return binaryList(arr, mid + 1, right, findVal);
    } else if (findVal < midVal) {
      return binaryList(arr, left, mid - 1, findVal);
    } else {
      List<int> resIndexList = [];

      int temp = mid - 1;
      while (true) {
        if (temp < 0 || arr[temp] != findVal) {
          // 向左掃到底還是沒找到
          break;
        }
        // 否則,把 temp 放入 resIndexList
        resIndexList.add(temp);
        temp -= 1;
      }
      resIndexList.add(mid);

      // 向 mid 索引值的右邊掃描, 將所有滿足的元素索引加入到 resIndexList
      temp = mid + 1;
      while (true) {
        if (temp > right || arr[temp] != findVal) {
          // 向右掃到底還是沒找到
          break;
        }
        // 否則,把 temp 放入 resIndexList
        resIndexList.add(temp);
        temp += 1;
      }

      return resIndexList;
    }
  }

  int leeCode(List<int> numS, int target) {
    int left = 0;
    int right = numS.length - 1;
    int mid = (left + right) ~/ 2;

    while (left <= right) {
      if (target < numS[mid]) {
        // 向左
        right = mid - 1;
        mid = (left + right) ~/ 2;
      } else if (target > numS[mid]) {
        // 向右
        left = mid + 1;
        mid = (left + right) ~/ 2;
      } else if (target == numS[mid]) {
        return mid;
      }
    }

    return -1;
  }

  /*
   運行時間：0 毫秒，比二進制搜索的 Java 在線提交速度快 100.00%。
   內存使用：51.7 MB，不到 Java 在線提交的二分搜索的 7.04%。
   時間複雜度
   T(n) = T(n/2) + Ο(1) = Ο(log2n)
   */

  /// 插值搜尋要求陣列有序
  /// @param arr 傳入的陣列
  /// @param left 左邊索引
  /// @param right 右邊索引
  /// @param findVal 搜尋的值
  /// @return 找到返回對應的索引, 否則返回 -1
  int insertValueSearch(List<int> arr, int left, int right, int findVal) {
    if (left > right || findVal < arr[0] || findVal > arr[arr.length - 1]) {
      // 沒找到 或 搜尋的值大於小於陣列數值範圍
      return -1;
    }

    int mid = left + (right - left) * (findVal - arr[left]) ~/ (arr[right] - arr[left]);
    int midVal = arr[mid];

    if (findVal > midVal) {
      // 向右遞迴
      return insertValueSearch(arr, mid + 1, right, findVal);
    } else if (findVal < midVal) {
      // 向左遞迴
      return insertValueSearch(arr, left, mid - 1, findVal);
    } else {
      return mid;
    }

  }

  /// 非遞迴方式寫費氏搜尋
  /// @param arr 陣列
  /// @param key 需要搜尋的值
  /// @return 返回對應的索引, 如果沒有則返回 -1
  int fibSearch(List<int> arr, int key) {
    int low = 0;
    int high = arr.length - 1;
    int k = 0; // 表示費氏分割數值的索引, 也就是 k
    int mid = 0;
    List<int> f = fib(); // 獲取費氏數列

    // 獲取費氏分割數值的索引
    while (high > f[k] - 1) {
      k++;
    }

    // 因為f[k] 值可能大於 arr 的長度, 因此需要構建一個新的陣列指向arr Copy.of(array, length)
    // 使用 arr 最後的數填充temp
    // {1, 8, 10, 89, 1000, 1234, 0, 0, 0...} => {1, 8, 10, 89, 1000, 1234, 1234, 1234, 1234...}
    int length = f[k] - arr.length;
    List<int> temp = arr;
    if(length > 0){
      for(int i = 0; i < length; i++){
        temp.add(arr[high]);
      }
    }
    // LogUtil.e("BinarySearch fib temp:$temp");

    // 使用while來循環處理, 找到 key
    while (low <= high) {
      mid = low + f[k - 1] - 1;
      if (key < temp[mid]) {
        // 應該繼續向左尋找
        high = mid - 1;
        k--;
      } else if (key > temp[mid]) {
        low = mid + 1;
        k -= 2;
      } else {
        // 找到
        if (mid <= high) {
          return mid;
        } else {
          return high;
        }
      }
    }

    return -1;
  }

  int maxSize = 20;
  // 非遞迴方式得到一個費氏數列
  List<int> fib() {
    List<int> fib = List.filled(maxSize, 0);
    fib[0] = 1;
    fib[1] = 1;

    for(int i = 2; i < maxSize; i++) {
      fib[i] = fib[i - 1] + fib[i - 2];
    }

    return fib;
  }

}