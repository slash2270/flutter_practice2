import 'dart:core';
import 'package:flutter_practice2/data_structure/stack_model.dart';
import '../util/opration_util.dart';

class FourArithmetic {

  //方法：將得到的前綴表達式對應的list => 中綴表達式的list
  List<String> prefixExpressionList(List<String> list) {
    ///从右向左扫描
    //int index = list.length - 1;
    //用来存放前缀表达式
    List<String> resultList = [];
    //用来存放运算符
    StackE<String> stack = StackE<String>(list.length);
     //用来拼接数字，多位数字
    String joint = "";
    for (int index = list.length - 1; index >= 0; index--) {
    //当扫描完毕后，退出循环
     //如果扫描到是操作数，直接将结果加入到结果list中
     //如果是多位数的问题已经解决
     //  LogUtil.e("stack prefixExpressionList index:$index list:$list isNumber:${Operation.isNumber(list[index])}");
      if (Operation.isNumber(list[index])){
     //由于是从右向左扫描，所以拼接要从右侧开始拼接
        joint = list[index] + joint;
     //判断是否越界，如果越界则不需要比较
        if(index > 1){
     //判断下一个字符是否为数字
          if(!Operation.isNumber(list[index - 1])){
            resultList.add(joint);
            joint="";
     //执行完成后让index加一，不然会陷入死循环
          }
     //已经是最后一位数了，不需要看下一位了
        }else {
          resultList.add(joint);
          joint="";
        }
      //如果是运算符，根据运算符优先级判断运算符是否进入运算符栈
      }else if(Operation.isOperator(list[index])){
        String operator = list[index];
      //如果为空，则直接加入到运算符中
        if (stack.isEmpty){
          stack.push(operator);
      //如果优先级大于运算符栈顶运算符的优先级，将运算符加入到运算符栈中
        }else if(Operation.priority(operator) > Operation.priority(stack.peak())){
          stack.push(operator);
      //将运算符栈栈顶的运算符加入到List数组中
        }else {
          resultList.add(stack.pop());
        }
      //如果是右括号，将右括号放入运算符栈中
      }else if(list[index] == ')'){
        stack.push(list[index]);
      //根据右括号来去除左括号
      } else if(list[index] == '('){
        while (stack.isNotEmpty && stack.peak() != ")"){
          resultList.add(stack.pop());
        }
      //丢弃右括号
        stack.pop();
      }
      // LogUtil.e("stack prefixExpressionList index:$index for:$resultList");
    }
     //将运算符栈中的运算符弹到list中
    while (stack.isNotEmpty){
      resultList.add(stack.pop());
    }
    // LogUtil.e("stack prefixExpressionList before:$resultList");
     //将结果反转
    resultList = resultList.reversed.toList();
    // LogUtil.e("stack prefixExpressionList after:$resultList");
    return resultList;
  }

  //方法：將中綴表達式轉為對應的list
  List<String> toInfixExpressionList(String s) {
    //定義一個list,存放中綴表達式
    List<String> ls = [];
    int i = 0; //用於遍歷expression
    do{
      //如果 c 非數字, 需要加入到ls
      String c = s.substring(i,i+1);
      //LogUtil.e("stack toInfixExpressionList c:$c ls:$ls");
      ls.add(c);
      i++;
    } while(i < s.length);
    return ls;
  }

  //方法：將得到的中綴表達式對應的list => 後綴表達式的list
  List<String> postFixExpressionList(List<String> ls) {
    //定義數棧和運算子棧
    StackE<String> s1 = StackE<String>(ls.length); //運算子棧
    //由於s2這個棧在整個過程中沒有push & pop 並且最後我們還需要逆序 因此不使用stack , 直接使用list
    List<String> s2 = []; //儲存中間結果
    for (String item in ls) {
      //數, 加入s2
      RegExp exp = RegExp(r"(\d)+");
      // LogUtil.e("stack parseSuffixExpressionList item:$item exp:${exp.hasMatch(item)} s2:$s2");
      if(exp.hasMatch(item)) { // 數字+
        s2.add(item);
      } else if(item == "(") { //左括號
        s1.push(item);
      } else if(item == ")") { //右括號
        while(s1.peak() != "(") { //遇到左括號前將s1 pop到s2
          s2.add(s1.pop());
        }
        s1.pop(); //將左括號消除
      } else {
        //當item的優先級小於等於s1棧頂運算子
        while(s1.isNotEmpty && (Operation.priority(s1.peak()) >= Operation.priority(item))) {
          s2.add(s1.pop());
        }
        //還需要將item push入棧
        s1.push(item);
      }
    }
    //將s1中剩餘的運算子依次pop出並加入s2
    while(s1.isNotEmpty) {
      s2.add(s1.pop());
    }
    return s2; //因為是存在list中, 所以按順序輸出就是對應的後綴表達式
  }

  //完成對後綴表示法的運算
  int calculate(List<String> ls) {
    //創建棧
    StackE<String> stack = StackE<String>(ls.length);
    //遍歷 ls
    for (String item in ls) {
      //使用正則取出數
      RegExp regExp = RegExp(r"(\d)+");
      // LogUtil.e("stack calculate item:$item exp:${regExp.hasMatch(item)}}");
      if(regExp.hasMatch(item)) { // +:匹配多位數
        //入棧
        stack.push(item);
      } else {
        int num2 = int.parse(stack.pop());
        int num1 = int.parse(stack.pop());
        int res = 0;
        if(item == "+") {
          res = num1 + num2;
        } else if(item == "-") {
          res = num1 - num2;
        } else if(item == "*") {
          res = num1 * num2;
        } else if(item == "/") {
          res = (num1 / num2) as int;
        } else {
          throw UnimplementedError("運算子有誤");
        }
        // 把res入棧
        stack.push("$res");
      }
    }
    //最後留在stack中的數據為運算結果
    return int.parse(stack.pop());
  }
}