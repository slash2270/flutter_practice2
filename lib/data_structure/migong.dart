import 'dart:math' as math;

import '../az_listview/common/index.dart';

class MiGong{

  MiGong({required this.row, required this.col});

  late List<List<int>> map;
  int row, col, n = 0, m = 0;
  List<int> gateRow = List.generate(8, (index) => 0);
  List<int> gateCol = List.filled(8, 0);

  //地圖產生
   buildMap() {
    map = List.generate(row, (index) => List.generate(col, (index) => 0));

    if(row < col) {
      m = row;
    } else {
      m = col;
    }

    //檔板產生
    for(int i = 0; i < m - 3 ; i++) {
      do{
        int random = math.Random().nextInt(m);
        n = (random * row - 1);
        gateRow[i] = n;
        n = (random * col - 1);
        gateCol[i] = n;
      } while(gateRow[i] == 0 || gateCol[i] == 0 || gateRow[i] == row || gateCol[i] == col || (gateRow[i] == 1 && gateCol[i] == 1)  || (gateRow[i] == row-2 && gateCol[i] == col-2));
    }

    //使用 1 表示牆
    //上下皆為牆(第一列和最後一列)全部設置為 1
    for(int i = 0; i < col; i++) {
      map[0][i] = 1;
      map[col - 1][i] = 1;
    }

    //左右皆為牆(第一行和最後一行)全部設置為 1
    for(int i = 1; i < row - 1; i++) {
      map[i][0] = 1;
      map[i][row - 1] = 1;
    }
    // LogUtil.e("migong showMap m:$m n:$n\nmap:$map");
    //檔板
    for(int i = 0; i < m - 3 ; i++) {
      // LogUtil.e("migong showMap getRow:$gateRow getCol:$gateCol mapRow:${gateRow[i]} mapCol:${gateCol[i]}");
      map[i][i] = 1;
    }
  }

  //輸出地圖
  String showMap() {
    // for(int i = 0; i < row; i++) {
    //   for(int j = 0; j < col; j++) {
    //     // LogUtil.e("migong showMap map:${map[i][j]} ");
    //   }
    //   // LogUtil.e("\n");
    // }
    List<String> arr = map.join().split(',');
    LogUtil.e("migong showMap arr:$arr");
    for (int i = 0; i < arr.length; i++) {
      if (i > 0 && i % 9 == 0) {
        arr.removeAt(i);
        arr.insert(i, '1]\n');
        // LogUtil.e("migong showMap i:$i arr[i]:${arr[i]}");
      }
    }
    String s = '';
    for (int i = 0; i < arr.length; i++) {
      if (i > 0 && i % 10 == 0) {
        arr.insert(i, '[1');
        // LogUtil.e("migong showMap i:$i arr[i]:${arr[i]}");
      }
      s += arr[i];
    }
    return s;
  }

  /** 使用遞迴回溯來給小球找路
   * 說明:
   * 1. map 表示地圖
   * 2. i,j 表示從地圖的哪個位置開始出發
   * 3. 如果小球能到 map[6][5]位置,則說明通路找到
   * 4. 約定: 當map[i][j] 為 0 表示該點沒有走過, 當為1 表示牆, 2表示可以走, 3表示該位置已經走過但是走不通
   * 5. 在走迷宮時,需要確定一個策略,下->右->上->左,如果該點走不通再回溯*/

  /**
   * @param map 表示地圖
   * @param i 從哪個位置開始找
   * @param j
   * @return 如果找到通路就返回true,否則返回false*/

  bool setWay(int i, int j) {
    if(map[row-2][col-2] == 2){ //通路已經找到
      return true;
    } else {
      if(map[i][j] == 0) { //當前點還沒走過
        //按照策略 下->右->上->左 走
        map[i][j] = 2; //假定該點能走通

        if(setWay(i+1 ,j )) { //向下走
          return true;
        } else if(setWay(i ,j+1 )) { //向右走
          return true;
        } else if(setWay(i-1 ,j )) { //向上走
          return true;
        } else if(setWay(i ,j-1 )) { //向左走
          return true;
        } else {
          // 說明該點是走不通,是死路
          map[i][j] = 3;
          return false;
        }
      } else { // 如果map[i][j] != 0,可能是 1,2,3
        return false;
      }
    }
  }

}