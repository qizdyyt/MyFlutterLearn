/*
// 定义变量
Dart是强类型的语言
声明方式：
1、明确声明
2、类型推导:
var const final dynamic

*/



// 定义变量
class One {
  
  static void run(){
    //1. 明确的类型声明方式
    String name = 'zd';
    // name = 110;//报错，类型不匹配
    int age = 11;
    double height = 1.2;
    print('$name $age $height');

    //打印、拿到变量的类型
    print(name.runtimeType);


//2. 类型推导的方式

var message = '(*´▽｀)ノノaaa';
// message = 123;//报错，类型推导认为是字符串
print(message);
print(message.runtimeType); // Stirng
message = '123';//message可以修改

// 声明常量
//const、final
const message1 = '常量1';
final message2 = '常量2';
// message1 = 'aaa';//报错。不可修改
// message2 = '222';//报错。不可修改
print(message1.runtimeType);
//两者主要区别：
//const 必须直接赋值常量，final可以通过运行时赋值
// const num1 = getNum();//const这里会报错，需要运行时调用函数才能获得值
final num1 = getNum(); //支持

// dynamic:动态的类型，允许变量中间赋值其他类新
dynamic bb = '123';
bb = 123;
print(bb.runtimeType);





  }
}

int getNum() {
  return 10;
}

