import 'package:common_utils/common_utils.dart';

class ArrayQueue1 {
  //創建佇列的構造函數
  ArrayQueue1({required this.maxSize, required this.arr, required this.front, required this.rear});
  //指向佇列頭部,分析出front是指向佇列頭部的前一個位置
  //指向佇列尾部,指向佇列尾部的數據(佇列最後一個數據)

  int maxSize, front, rear;
  List<int> arr;

  //判斷佇列是否滿
  bool isFull() {
    return rear == maxSize - 1;
  }

  //判斷佇列是否為空
  bool isEmpty() {
    return rear == front;
  }

  //添加數據到佇列
  List<int> addQueue(int n) {
    //判斷佇列是否滿
    if(!isFull()){
      arr[rear] = n;
      rear++;
    }else{
      rear = 0;
    }
    LogUtil.e("ArrayQueue1 rear:$rear");
    return arr;
  }

  //獲取佇列數據出佇列
  List<int> getQueue() {
    //判斷佇列是否空
    if (!isEmpty()) {
      front++;
    }
    LogUtil.e("ArrayQueue1 front:$front");
    return arr;
    //throw UnimplementedError("佇列為空,無值可取"); //throw本身造成代碼return 不須另外寫return
  }

  List<int> getHeadQueue() {
    if (!isEmpty()) {
      arr[front % arr.length];
      //throw UnimplementedError("佇列為空,無值可取");
    }
    LogUtil.e("ArrayQueue1 headQueue:${arr[front % arr.length]}");
    return arr;
  }

  //顯示佇列數據
  List<int> showQueue() {
    if(!isEmpty()){
      for(int i=0;i<arr.length;i++){
        "ArrayQueue1 arr:${arr[i]} index:$i\n";
      }
    }
    return arr;
  }
}