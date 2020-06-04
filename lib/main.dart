import 'package:flutter/material.dart';
import 'package:my_learn/functions/file_operation.dart';
import 'package:my_learn/functions/log.dart';
import 'package:my_learn/functions/net_work_request.dart';
import 'package:my_learn/learn_dart/learn_dart_1.dart';
import 'package:my_learn/learn_dart/learn_dart_2.dart';
import 'package:my_learn/learn_dart/learn_dart_3.dart';
import 'package:my_learn/learn_dart/learn_dart_4.dart';
/*
1. dart的入口是main函数
2. 在dart中打印内容使用print

main() {
  ...
}

*/

/*
完整的main函数

函数的返回值类型  函数名称（参数列表） {
  函数体
}

List-> 数组
泛型，这个参数一般在命令行运行dart文件时传递参数使用
void main (List<String> args) {

}
*/


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Log.startWriteLog();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: getHome(context),//MyHomePage(title: 'Flutter Demo For My Learn'),
    );
  }
}

Widget getHome(BuildContext context) {

  print("Hellow word");
  Log.w('get home');

One.run();
Two.run();
Three.run();
Four.run();



  return Scaffold(
      appBar: AppBar(
        title: Text('text'),
      ),
      body: Center(
        child: Text('MyLearn'),
      ),
    );
}


































class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FlatButton(child: Text('网络请求'), onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return NetWorkRequestPage();
              }));
            },),
             FlatButton(child: Text('文件操作'), onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return FileOperationPage();
              }));
            },),
          ],
        ),
      ),
    );
  }
}
