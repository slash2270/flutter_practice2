// @dart = 2.9

import 'dart:collection';

import 'package:flutter/material.dart';

class StackQueue<T> {
  final stack = Queue<T>();

  int get length => stack.length;
  bool get canPop => stack.isNotEmpty;
  bool get cantPop => stack.isEmpty;

  void clearStack(){
    while(canPop){
      stack.removeLast();
    }
  }

  void push(T element) {
    stack.addLast(element);
  }

  T pop() {
    // if (cantPop) throw StackEmptyException;
    T lastElement = stack.last;
    stack.removeLast();
    return lastElement;
  }

  T top() {
    // if (cantPop) throw StackEmptyException;
    return stack.first;
  }

  T peak() {
    // if (cantPop) throw StackEmptyException;
    return stack.last;
  }

  String list() {
    if (cantPop) throw StackEmptyException;
    String s = '';
    List list = stack.toList();
    for(int i = list.length - 1; i >= 0; i--){
      s += list[i];
    }
    return s;
  }

  @override
  String toString() => stack.toString();

}

class StackOverFlowException implements Exception {
     const StackOverFlowException();
     @override
     String toString() => 'StackOverFlowException';
}

class StackEmptyException implements Exception {
     const StackEmptyException();
     @override
     String toString() => 'StackEmptyException';
}

class StackE<E> {
  final List<E> _stack;
  final int capacity;
  int _top;
  StackE(this.capacity): _top = -1, _stack = List<E>(capacity);
  bool get isEmpty => _top == -1;
  bool get isNotEmpty => _top > -1;
  bool get isFull => _top == capacity - 1;
  int get size => _top + 1;

  void push(E e) {
    if (isFull) throw StackOverFlowException;
    _stack[++_top] = e;
  }

  E pop() {
    if (isEmpty) throw StackEmptyException;
    return _stack[_top--];
  }

  // E get top {
  //   if (isEmpty) throw StackEmptyException;
  //   return _stack[_top];
  // }

  E peak() {
    if (isEmpty) throw StackEmptyException;
    return _stack[_top];
  }

  List<String> list() {
    if (isEmpty) throw StackEmptyException;
    List<String> list = [];
    list.addAll(_stack as List<String>);
    return list;
  }

}

class StackString {
  int maxSize; //棧的大小
  List<String> stack; //陣列,模擬棧
  int top = -1; //棧頂,初始化為-1

  StackString({@required this.maxSize, @required this.stack});

  //返回棧頂值
  String peek() {
    return stack[top];
  }

  //判斷棧滿
  bool isFull() {
    return top == maxSize -1;
  }

  //判斷棧空
  bool isEmpty() {
    return top == -1;
  }

  //入棧
  void push(String value) {
    top++;
    stack[top] = value;
  }

  //出棧
  String pop() {
    String value = stack[top];
    top--;
    return value;
  }

}
