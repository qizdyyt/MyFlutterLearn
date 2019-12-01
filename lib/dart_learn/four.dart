/*
函数：

基本定义：
返回值 函数名称 (参数列表) {
  函数体
}

函数的参数：
1、必传参数
2、可选参数
*/

class Four {
  static void run() {
    print(sum(1, 2));

    printInfo('msg');
  }
}

int sum(int num1, int num2) {
  return num1 + num2;
}

void printInfo(String msg){
print(msg);
}

