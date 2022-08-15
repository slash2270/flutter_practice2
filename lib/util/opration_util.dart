//返回一個運算子對應的優先級
import '../az_listview/common/index.dart';

class Operation {

  //返回運算子的優先級，優先級是programmer來定的
  //優先級使用數字表示，數字越大，則優先級越高
  static int priority(String operator) {
    int result = -1;
    if (operator == '*' || operator == '/') {
      result = 1;
      return result;
    } else if (operator == '+' || operator == '-') {
      result = 0;
      return result;
    } else {
      LogUtil.e("operation:運算子有誤");
      return result; //假定目前的表達式只有 +-*/
    }
  }

  //判斷是不是一個運算子
  static bool isOperator(String val) {
    return val == '+' || val == '-' || val == '*' || val == '/';
  }

  //計算方法
  static int calculate(int num1, int num2, String operator) {
    int res = 0; //用於存放計算結果
    switch (operator) {
      case '+':
        res = num1 + num2;
        break;
      case '-':
        res = num2 - num1; //注意順序
        break;
      case '*':
        res = num1 * num2;
        break;
      case '/':
        res = (num2 / num1) as int;
        break;
      default:
        LogUtil.e("operation:運算子有誤");
        break;
    }
    return res;
  }

  //判断是否为数字
  static bool isNumber(String number){
    RegExp regExp = RegExp(r"(\d)");
    if(regExp.hasMatch(number)){
      return true;
    }else {
      return false;
    }
  }

}