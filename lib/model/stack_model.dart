import 'dart:collection';

class StackModel<T> {
  final _stack = Queue<T>();

  int get length => _stack.length;
  bool get canPop => _stack.isNotEmpty;
  bool get cantPop => _stack.isEmpty;

  void clearStack(){
    while(canPop){
      _stack.removeLast();
    }
  }

  void push(T element) {
    _stack.addLast(element);
  }

  T pop() {
    if (cantPop) throw StackEmptyException;
    T lastElement = _stack.last;
    _stack.removeLast();
    return lastElement;
  }

  T top() {
    if (cantPop) throw StackEmptyException;
    return _stack.first;
  }

  T peak() {
    if (cantPop) throw StackEmptyException;
    return _stack.last;
  }

  @override
  String toString() => _stack.toString();

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