/*
函数：

基本定义：
返回值类型 函数名称 (参数列表) {
  函数体
}
注意：虽然dart中函数支持返回类型不写明，但是dart规范建议写明返回值类型。


函数的参数：
1、必传参数
2、可选参数:位置可选参数  和  命名可选参数
3、 默认值  只有可选参数能有默认值，必传参数不能


函数是第一公民：
函数既可以作为一个函数的参数
也可以作为一个函数的返回值
类似OCblock

匿名函数

也有箭头函数

函数如果没有返回值，那么会return null, 隐式的加到函数最外面

*/

import 'package:flutter/material.dart';

class Four {
  static void run() {
    print(sum(1, 2));

    printInfo('msg');
    printInfo('msg1', );

    test(foo);
    print(getFunc().toString());

    var list = [1, 2, 3];
    //具体怎么将有参数的函数作为参数可以看forEach的实现
    //实现思想类似OC的block
    //传入一段代码（函数1），并可能包含参数，在函数2中可能调用

    //非匿名函数（有参数）作为参数，
    list.forEach(printElement);

    //匿名函数作为参数
    list.forEach((int ele){
      print(ele);
    });
    
    print(foo());//null
  }
}

//必传参数
int sum(int num1, int num2) {
  return num1 + num2;
}

//可选参数： 位置可选参数  和  命名可选参数

//位置可选参数：  使用[]，要对应位置一个一个传，参数名可省
void printInfo(String msg, [int age]){
print(msg);
}

void runCallback(void f(dynamic element)) {
    
}

//命名可选参数:   使用{}        默认值
void printInfo2(String msg, {int age = 12, @required double height}){
print(msg);
}
 foo() {
  print("调用了foo");
}

void test(Function fun) {
  fun();
}

Function getFunc(){
  return foo;
}

void printElement(int element) {
  print(element);
}