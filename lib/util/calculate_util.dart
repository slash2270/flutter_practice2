import 'dart:math' as math;

import '../az_listview/common/index.dart';

enum Status { WON, LOST, CONTINUE }

class Calculate{
  Calculate._internal();
  factory Calculate() => _instance;
  static late final Calculate _instance = Calculate._internal();
  String s = '';

  /// 從陣列中選擇最小元素，將它與陣列的第一個元素交換位置。再從陣列剩下的元素中選擇出最小的元素，將它與陣列的第二個元素交換位置。不斷進行這樣的操作，直到將整個陣列排序。
  String selectSort(List<int> arr){ // 選擇排序
    for (int i = 0; i < arr.length-1; i++) {
      int k = i;
      for (int j = i+1; j < arr.length; j++) {
        if (arr[j] < arr[k]) {
          k = j;
        }
      }
      if (k != i) {
        int temp = arr[i];
        arr[i] = arr[k];
        arr[k] = temp;
      }
    }
    return arr.toString();
  }

  /// 從左到右不斷交換相鄰逆序的元素，在一輪的迴圈之後，可以讓未排序的最大元素上浮到右側。在一輪迴圈中，如果沒有發生交換，那麼說明陣列已經是有序的，此時可以直接退出。
  // 氣泡排序
  String bubbleSort(List<int> arr) {
    // 設定每次冒泡的終止點
    for (int i = arr.length - 1; i > 0; i--) {
      bool change = false;
      // 從起點開始冒泡
      for (int j = 0; j < i; j++) {
        if (arr[j] > arr[j + 1]) {
          int temp = arr[j];
          arr[j] = arr[j + 1];
          arr[j + 1] = temp;
          if (change == false) {
            change = true;
          }
        }
      }
      // 如果本次無交換，則表示已有序，排序完成
      if (!change) {
        break;
      }
    }
    return arr.toString();
  }

  /// 通過構建有序序列，對於未排序資料，在已排序序列中從後向前掃描，找到相應位置並插入。每步將一個待排序的元素，按其排序碼大小插入到前面已經排好序的一組元素的適當位置上去，直到元素全部插入為止。
  // 插入排序
  String insertionSort(List<int> arr) {
    // 從第二個元素開始為它們找位置
    for (int i = 1; i < arr.length; i++) {
      // 記住當前元素
      int temp = arr[i];
      int j;
      // 從當前元素左邊第一個元素開始，向左找位置
      for (j = i - 1; j >= 0 && arr[j] > temp; j--) {
        arr[j + 1] = arr[j];
      }
      // 找到合適位置後，將當前元素插入
      arr[j + 1] = temp;
    }
    return arr.toString();
  }

  /// 改良插入排序
  /// 又稱“分組插入排序”，先將整個待排元素序列分割成若干個子序列（由相隔某個“增量”的元素組成的）分別進行直接插入排序，然後依次縮減增量再進行排序，待整個序列中的元素基本有序（增量足夠小）時，再對全體元素進行一次直接插入排序。
  // 希爾排序
  String shellSort(List<int> arr) {
    // 增量控制，每次減半
    int gap;
    for (gap = arr.length ~/ 2; gap > 0; gap = gap ~/ 2) {
      // 步長控制，從gap開始向後移動
      for (int i = gap; i < arr.length; i++) {
        int temp = arr[i];
        int j;
        // 起始指標控制，向左插入排序（找位置）
        for (j = i - gap; j >= 0 && arr[j] > temp; j -= gap) {
          arr[j + gap] = arr[j];
        }
        arr[j + gap] = temp;
      }
    }
    return arr.toString();
  }

  ///該演算法採用經典的分治（divide-and-conquer）策略，分：問題分成一些小的問題然後遞迴求解，治：將分的階段得到的各答案"修補"在一起，即分而治之。
  ///將序列遞迴拆半分成多個子序列，再將各個子序列排序後歸併疊加，最後歸併所有子序列，排序完成。
  // 歸併排序
  List<int> mergeSort(List<int> list) {
    if (list.length < 2) return list;
    ///分割數字
    var left = list.sublist(0, list.length ~/ 2);
    var right = list.sublist(list.length ~/ 2);
    ///開始遞歸，並接分割完成後合併數組
    return _mergeSortMerge(mergeSort(left), mergeSort(right));
  }

  List<int> _mergeSortMerge(List<int> left, List<int> right) {
    var merge = List<int>.filled(left.length + right.length, 0, growable: false);
    var leftIndex = 0;
    var rightIndex = 0;
    var mergeIndex = 0;
    ///合併數組（此時的數組已是有序的），遍歷兩個目標數組，取出最大（最小）的放到新數組中
    while (leftIndex < left.length && rightIndex < right.length) {
      if (left[leftIndex] >= right[rightIndex]) {
        merge[mergeIndex++] = left[leftIndex++];
      } else if (left[leftIndex] < right[rightIndex]) {
        merge[mergeIndex++] = right[rightIndex++];
      }
    }
    while (leftIndex < left.length) {
      merge[mergeIndex++] = left[leftIndex++];
    }
    while (rightIndex < right.length) {
      merge[mergeIndex++] = right[rightIndex++];
    }
    return merge;
  }

  /// 以第一個元素為基準，左右指標向中間移動掃描，小於基準元素的放到左邊，大於基準元素的放到右邊，最後將基準元素放到中間，這個位置也就是基準元素的合適位置。此時資料以基準元素為間隔，分為左右兩部分（不包括基準元素），
  /// 然後分別對左右兩部分資料分別執行此過程，直到資料不能再分，此時排序完成。
  // 快速排序
  List<int> quickSort(List<int> arr, int left, int right) {
    if (left < right) {
      int index = getIndex(arr, left, right);
      arr = quickSort(arr, left, index - 1);
      arr = quickSort(arr, index + 1, right);
    }
    return arr;
  }

  int getIndex(List<int> arr, int left, int right) {
    // 得到基準元素
    int item = arr[left];
    // 向中間移動，調整位置，找到基準元素的位置
    while (left < right) {
      while (left < right && arr[right] >= item) {
        right--;
      }
      arr[left] = arr[right];
      while (left < right && arr[left] <= item) {
        left++;
      }
      arr[right] = arr[left];
    }
    // 放置基準元素
    arr[left] = item;
    return left;
  }

  /// 改良選擇排序
  /// 將待排序序列構造成一個大頂堆，此時，整個序列的最大值就是堆頂的根節點。將其與末尾元素進行交換，此時末尾就為最大值。然後將剩餘n-1個元素重新構造成一個堆，這樣會得到n個元素的次小值。如此反覆執行，便能得到一個有序序列了。
  // 堆排序
  List<int> heapSort(List<int> arr) {
    // 1.構建大頂堆
    for (int i = (arr.length / 2 - 1).toInt(); i >= 0; i--) {
      adjust(arr, i, arr.length);
    }
    // 2.調整堆結構，交換頂元素與末尾元素
    for (int j = arr.length - 1; j > 0; j--) {
      int temp = arr[j];
      arr[j] = arr[0];
      arr[0] = temp;
      arr = adjust(arr, 0, j);
    }
    return arr;
  }

  List<int> adjust(List<int> arr, int i, int length) {
    int temp = arr[i];
    for (int k = 2 * i + 1; k < length; k = 2 * k + 1) {
      if (k + 1 < length && arr[k + 1] > arr[k]) {
        k++;
      }
      if (arr[k] > temp) {
        arr[i] = arr[k];
        i = k;
      } else {
        break;
      }
    }
    arr[i] = temp;
    return arr;
  }

  /// 計數排序要求輸入的資料必須是有確定範圍的整數。
  /// 找出待排序的陣列中最大和最小的元素；統計陣列中每個值為i的元素出現的次數，存入陣列C的第i項；對所有的計數累加（從C中的第一個元素開始，每一項和前一項相加）；反向填充目標陣列：將每個元素i放在新陣列的第C(i)項，
  /// 每放一個元素就將C(i)減去1。
  // 計數排序
  String countSort(List<int> list) {
    int max = list[0];
    for (var i = 1; i < list.length; i++) {
      if (list[i]>max) {
        max = list[i];
      }
    }
    //开辟内存空间，存储每个整数出现的次数
    List<int> counts = List.filled(max+1, 0);
    //统计每个整数出现的次数
    for (var i = 0; i < list.length; i++) {
      counts[list[i]]++;
    }
    //根据整数出现的次数，对整数进行排序
    //按顺序赋值
    int index = 0;
    for (var i = 0; i < counts.length; i++) {
      while(counts[i]-->0){
        list[index++] = i;
      }
    }
    return list.toString();
  }

  /// 桶排序是計數排序的擴充套件版本，計數排序可以看成每個桶只儲存相同元素，而桶排序每個桶儲存一定範圍的元素，通過對映函式，將待排序陣列中的元素對映到各個對應的桶中，對每個桶中的元素進行排序，最後將非空桶中的元素逐個放入原序列中。
  /// 桶排序需要儘量保證元素分散均勻，否則當所有資料集中在同一個桶中時，桶排序失效。
  // 桶排序
  String bucketSort(List<int> arr) {
    // 計算最大值與最小值
    int max = arr[arr.length - 1];
    int min = arr[0];
    int i;
    for (i = 0; i < arr.length; i++) {
      max = math.max(max, arr[i]);
      min = math.min(min, arr[i]);
    }

    // 計算桶的數量,並建立桶
    int bucketNum = (max - min) ~/ (arr.length + 1);
    //LogUtil.e('Calculate max:$max min:$min bucketNum:$bucketNum');
    List<List<int>> bucketArr = [[bucketNum]];
    //LogUtil.e('Calculate bucketArr1:$bucketArr');
    for (i = 0; i < bucketNum; i++) {
      bucketArr.add([]);
    }
    //LogUtil.e('Calculate bucketArr2r:$bucketArr');

    // 將每個元素放入桶
    bucketArr.first.clear();
    for (i = 0; i < arr.length; i++) {
      int num = (arr[i] - min) ~/ (arr.length);
      //LogUtil.e('Calculate num:$num');
      bucketArr[num].add(arr[i]);
      //LogUtil.e('Calculate bucketArr3:$bucketArr');
    }

    String array;
    // 對每個桶進行排序
    for (i = 0; i < bucketArr.length; i++) {
      bucketArr[i].sort();
    }
    array = bucketArr.toString();
    //LogUtil.e('Calculate arrLength:${arr.length} bucketArr:$bucketArr');

    int index = 0;
    for(i = 0; i < bucketArr.length; i++){
      for(int j = 0; j < bucketArr[i].length; j++){
        arr[index++] = bucketArr[i][j];
        //LogUtil.e('Calculate arrIn:$arr');
      }
    }
    array = '$array\n$arr';
    return array;
  }

  /// 基數排序可以看成是桶排序的擴充套件，以整數排序為例，主要思想是將整數按位數劃分，準備 arr.length 個桶，代表 0 - 9，根據整數個位數字的數值將元素放入對應的桶中，之後按照輸入賦值到原序列中，
  /// 依次對十位、百位等進行同樣的操作，最終就完成了排序的操作。
  // 基數排序
  String radixSort(List<int> arr) {
    int bit;
    int max = getMax(arr);
    for (bit = 1; max/bit > 0; bit *= 10) {
      arr = bitSort(arr, bit) as List<int>;
    }
    return arr.toString();
  }

  List bitSort(List<int> arr, int bit) {
    int length = arr.length;
    int i;

    List bitCounts = List.filled(10, null, growable: false);
    for (i = 0; i < 10; i++) {
      bitCounts[i] = 0;
    }
    for (i = 0; i < length; i++) {
      int pos = (arr[i] ~/ bit) % 10;
      bitCounts[pos]++;
    }
    for (i = 0; i < 10; i++) {
      if(i > 0){
        bitCounts[i] += bitCounts[i-1];
      }
    }

    List tmp = List.filled(length, null, growable: false);
    for (i = length - 1; 0 <= i; i--) {
      int pos = (arr[i] ~/ bit) % 10;
      tmp[bitCounts[pos]-1] = arr[i];
      bitCounts[pos]--;
    }
    for (i = 0; i < length; i++) {
      arr[i] = tmp[i];
    }

    return arr;
  }

  String RadixSort(List<int> array) {
    if (array.isEmpty || array.length < 2) return array.toString();
    // 1.先算出最大數的位數；
    int max = array[0];
    for (int i = 1; i < array.length; i++) {
      max = math.max(max, array[i]);
    }
    int maxDigit = 0;
    while (max != 0) {
      max = max ~/ array.length;
      maxDigit++;
    }
    int mod = 10, div = 1;
    List<List<int>> bucketList = [];
    for (int i = 0; i < array.length; i++) {
      bucketList.add([]);
    }
    for (int i = 0; i < maxDigit; i++, mod *= 10, div *= 10) {  // 更新基底：1->length, length平方
      for (int j = 0; j < array.length; j++) {
        int num = (array[j] % mod) ~/ div;
        bucketList[num].add(array[j]);
      }
      int index = 0;
      for (int j = 0; j < bucketList.length; j++) {
        for (int k = 0; k < bucketList[j].length; k++) {
          array[index++] = bucketList[j][k];
        }
        bucketList[j].clear(); // 歸0，以便下一回合使用
      }
    }
    return array.toString();
  }

  ///雙向氣泡排序法(Bidirectional Bubble Sort)、雞尾酒排序法(Cocktail Sort)、波浪排序法(Ripple Sort)、搖曳排序法(Shuffle Sort)、飛梭排序法(Shuttle Sort)、歡樂時光排序法(Happy Hour Sort)
  ///搖晃排序法為氣泡排序法的改良將資料分成未排序及已排序兩部份，利用left、right來識別已排序和未排序的資料
  //搖晃排序
  List<int> swap(List<int> arr, int i, int j) {
    final tmp = arr[i];
    arr[i] = arr[j];
    arr[j] = tmp;
    return arr;
  }

  String shakerSort(List<int> arr) {
    var left = 0;
    var right = arr.length - 1;
    var shift = 0;

    while (left < right) {
      for (var i = left; i < right; i++) {
        if (arr[i] > arr[i + 1]) {
          //將最大值往右排
          swap(arr, i, i + 1);
          shift = i;
        }
      }
      right = shift;
      for (var i = right; i > left; i--) {
        if (arr[i] < arr[i - 1]) {
          //將最小值往左排
          swap(arr, i, i - 1);
          shift = i;
        }
      }
      left = shift;
    }
    return arr.toString();
  }

  int getMax(List<int> arr) {
    int max = arr[0];
    for (var v in arr) {
      if (v > max) {
        max = v;
      }
    }
    return max;
  }

  int getMin(List<int> arr) {
    int min = arr[0];
    for (var v in arr) {
      if (v < min) {
        min = v;
      }
    }
    return min;
  }

//   // 冒泡排序
//   void BubbleSort(List<int> arr) {
//     for (var i = arr.length; i > 0; i--) {
//       for (var j = 0; j <  i - 1; j++) {
//         if (arr[j] > arr[j + 1]) {
//           var t = arr[j + 1];
//           arr[j + 1] = arr[j];
//           arr[j] = t;
//         }
//       }
//     }
//   }
//
// // 快速排序
//   void quickSort(List<int> alist, int first, int last) {
//     if (first < last) {
//       int splitPoint = partition(alist, first, last);
//       quickSort(alist, first, splitPoint-1);
//       quickSort(alist, splitPoint+1, last);
//     }
//   }
//   int partition(List<int> alist, int first, int last) {
//     int pivotVal = alist[first];
//
//     int left = first + 1;
//     int right = last;
//     int temp;
//     while (left <= right) {
//       while (left <= right) && (alist[left] <= pivotVal) {
//     left += 1;
//     }
//
//     while (left <= right) && (alist[left] >= pivotVal) {
//     right -= 1;
//     }
//
//     if (left <= right){
//     temp = alist[left];
//     alist[left] = alist[right];
//     alist[right] = temp;
//     }
//     }
//     temp = alist[first];
//     alist[first] = alist[right];
//     alist[right] = temp;
//
//     return right;
//   }
//
// // 选择排序
//   void SelectionSort(List<int> arr) {
//     for (var i = 0; i < arr.length - 1; i++) {
//       var pos = i;
//       for (var j = i + 1; j < arr.length; j++) {
//         if (arr[j] < arr[pos]) {
//           pos = j;
//         }
//       }
//       if (i != pos) {
//         var t = arr[i];
//         arr[i] = arr[pos];
//         arr[pos] = t;
//       }
//     }
//   }
//
//   List Heapify(List<int> arr, int m, int size) {
//     int tmp = arr[m];
//     for (int i = 2 * m; i <= size; i *= 2) {
//       if (i + 1 <= size && arr[i] < arr[i+1]) {
//         i++;
//       }
//       if (arr[i] < tmp) {
//         break;
//       }
//       arr[m] = arr[i];
//       m = i;
//     }
//     arr[m] = tmp;
//     return arr;
//   }
//   List BulidHeap(List<int> arr, int size) {
//     for (int m = size / 2; m > 0; m--) {
//       arr = Heapify(arr, m, size);
//     }
//     return arr
//   }
//   List swapH(List<int> arr, int i, int j) {
//     int tmp;
//     tmp = arr[i];
//     arr[i] = arr[j];
//     arr[j] = tmp;
//     return arr;
//   }
// // 堆排序
//   void HeapSort(List<int> arr, int size) {
//     arr = BulidHeap(arr, size);
//     for (int i = size; i > 1; i--) {
//       arr = swapH(arr, 1, i);
//       arr = Heapify(arr, 1, i - 1);
//     }
//   }
//
// // 插入排序
//   void InsertSort(List<int> arr) {
//     for (var i = 0; i < arr.length; i++) {
//       int j, t = arr[i];
//       for (j = i - 1; j >= 0; j--) {
//         if (t < arr[j]) {
//           arr[j+1] = arr[j];
//         }
//       }
//       if (j < i - 1) {
//         a [j + 1] = t;
//       }
//     }
//   }
//
//   int _initInterval<T>(List<T> arr) {
//     var interval = 1;
//     while (interval < arr.length ~/3) {
//       interval = 3 * interval + 1;
//     }
//     return interval;
//   }
// // 希尔排序
//   void ShellSort<T extends Comparable>(List<T> arr) {
//     for (var i = _initInterval(arr); i > 0; i = (i - 1) ~/3) {
//       for (var g = 0; g < i; g++) {
//         var k = j - i, t = arr[j];
//         while (k >= 0 && t.compareTo(arr[k]) < 0) {
//           arr[k+1] = arr[k];
//           k -= 1;
//         }
//         if (k < j - i) {
//           arr[k+1] = t;
//         }
//       }
//     }
//   }
//
// // 归并排序
//   void MergeSort(List<int> list) {
//     if (list.length > 1) {
//       int mid = list.length ~/ 2;
//       List<int> leftHalf = list.sublist(0, mid);
//       List<int> rightHalf = list.sublist(mid);
//
//       MergeSort(leftHalf);
//       MergeSort(rightHalf);
//
//       int i = 0;
//       int j = 0;
//       int k = 0;
//       while (i < leftHalf.length && j < rightHalf.length) {
//         if (leftHalf[i] < rightHalf[j]) {
//           list[k] = leftHalf[i];
//           i += 1;
//         } else {
//           list[k] = rightHalf[j];
//           j += 1;
//         }
//         k += 1;
//       }
//
//       while (i < leftHalf.length) {
//         list[k] = leftHalf[i];
//         i += 1;
//         k += 1;
//       }
//
//       while (j < rightHalf.length) {
//         list[k] = rightHalf[j];
//         j += 1;
//         k += 1;
//       }
//     }
//   }
//
// // 计数排序
//   List countingSort(List<int> arr) {
//     int i;
//     if (arr.isEmpty) {
//     return [];
//     }
//
//     int cntLstLen = getMax(arr) + 1;
//     List cntLst = List.filled(cntLstLen, null, growable: false);
//     for (i = 0; i < arr.length; i++) {
//       cntLst[i] = 0;
//     }
//
//     for (i = 0; i < arr.length; i++) {
//       cntLst[arr[i]]++;
//     }
//
//     List narr = [];
//     for (i = 0; i < cntLstLen; i++) {
//       while (cntLst[i] > 0) {
//         narr.add(i);
//         cntLst[i]--;
//       }
//     }
//     return narr;
//   }
//
// // 桶排序
//   List BucketSort(List<int> arr ) {
//     int i;
//     int max = getMax(arr);
//     int min = getMin(arr);
//     int bucketNum = (max - min) ~/ arr.length + 1;
//
//     List <List> bucketsLst = List(List(bucketNum));
//     for (i = 0; i < arr.length; i++) {
//       int pos = (arr[i] - min) ~/ arr.length;
//       bucketsLst[pos].add(arr[i]);
//     }
//
//     for (i = 0; i < bucketsLst.length; i++) {
//       if (bucketsLst[i].isEmpty) {
//         continue;
//       }
//       bucket = countingSort(bucketsLst[i])
//       for (j = 0; j < bucket.length; j++) {
//         arr[j] = bucket[j];
//       }
//     }
//     return arr;
//   }


  /// 蒙地卡羅為摩洛哥王國之首都，該國位於法國與義大利國境，以賭博聞名。蒙地卡羅法是一種隨機演算，是指使用隨機亂數來解決計算問題的方法。
  /// 例如，以亂數散佈點配合面積公式，可以求得近似的 PI，是簡單的蒙地卡羅法運用。隨機演算雖然會有精確度等方面的疑慮，然而有些需求可能無最佳解，或者需要耗費大量運算才能得到理想解答，
  /// 若隨機演算可以快速求得某個可接受的結果，就可能採取這類演算。
  // 現在我們隨機求得正方形中的點,這些點有的在1/4圓內,假如在1/4圓內的點數為c,總點數為n,則PI/4:1=c:n,從而我們可以求出PI=4*c/n。
  // 如何判斷點落在圓內呢,涉及一點數學知識:對於圓,其函式為x的平方+y的平方等於1,對於某點座標的x和y,x的平方和y的平方和小於1時,說明在圓內。
  // 假設散佈了 n 個點，在圓內的點有 c 個，依比例來算，就會得到以下的公式：
  String monteCarloRandom(){
    double random = math.Random().nextDouble();
    int n = 100001;
    int count = 0;
    for (int i = 1; i < n; i++) {
      if((random * random + random * random) < 1) { // 判斷正方形是否小於圓
        count++;
        //LogUtil.e('Calculate "PI = ":${(4.0 * count/(n - 1))}');
      }
    }
    return "PI(四分之一圓面積) = ${(4 * count/(n - 1))}";
  }

  List<Card> shuffleRandom() {
    List<Card> cards = [];
    for (int i = 0; i < 52; i++) {
      cards.add(Card(suit: suit(i + 1),symbol: symbol(i + 1)));
    }
    for (int i = 0; i < cards.length; i++) {
      cards.shuffle();
    }
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
  // 螃蟹遊戲
  String crapsRandom() {
    LogUtil.e('Calculate craps3:$s');
    Status status = Status.CONTINUE;
    if (s.split('點數') == true) {
      int point = dice();
      //out.printf("玩家點數：%d%n", point);
      status = reRoll(0, point);
      LogUtil.e('Calculate craps2:${status.name}');
      if (status == Status.WON) {
        s = "點數:$point 玩家勝";
      } else if (status == Status.CONTINUE) {
        s = "繼續";
      } else {
        s = "玩家輸";
      }
    } else {
      int firstPoint = dice();
      //out.printf("玩家點數：[%d]%n", firstPoint);
      status = initRoll(firstPoint);
      LogUtil.e('Calculate craps1:${status.name}');
      if (status == Status.WON) {
        s = "點數:$firstPoint 玩家勝";
        return s;
      } else if (status == Status.CONTINUE) {
        s = "點數:$firstPoint 繼續";
      } else {
        s = "點數:$firstPoint 玩家輸";
      }
    }
    return s;
  }

  int dice() {
    double random = math.Random().nextDouble();
    return (random * 6).toInt() + (random * 6).toInt() + 2;
  }

  Status initRoll(int firstPoint) {
    switch(firstPoint) {
      case 7: case 11:         return Status.WON;
      case 2: case 3: case 12: return Status.LOST;
      default:                 return Status.CONTINUE;
    }
  }

  Status reRoll(int firstPoint, int point) {
    return firstPoint == point ? Status.WON : (7 == point ? Status.LOST : Status.CONTINUE);
  }

}

class Card {
  String? suit;
  String? symbol;

  Card({this.suit, this.symbol});

  @override
  String toString() => "$suit$symbol";
}