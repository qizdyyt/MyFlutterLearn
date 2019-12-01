//数据类型

/*
int double

布尔类型：没有非0即真或者非空即真

字符串

*/

class Two {
  static void run() {
    int num = 123; //十进制
    num = 0x123; //十六进制

//字符串类型
//1、字符串的定义方式
    var str1 = 'Hello';
    var str2 = "222";
    var str3 = '''a//3引号可以换行
as
ss''';
    print(str1 + str2 + str3);


    //2、字符串的拼接
    //可以省略{}:$后面直接跟一个变量
    //不可以省略：后面是一个表达式
  final name = "my";
  final age = 12;
  final height = 1.22;
  
  print("$name$age$height");
  print("$name${age.runtimeType}$height");
  }
  

}
