import 'dart:io';
// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileOperationPage extends StatefulWidget {
  @override
  State<FileOperationPage> createState() {
    return _FileOperationPageState();
  }
}

class _FileOperationPageState extends State<FileOperationPage> {
  String _data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('文件操作'),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: <Widget>[
            FlatButton(
              child: Text('文件路径'),
              onPressed: () {
                List<Directory> directoryList = List();
                getLibraryDirectory().then((Directory directory) {
                  directoryList.add(directory);
                  getApplicationDocumentsDirectory()
                      .then((Directory directory) {
                    directoryList.add(directory);
                    getTemporaryDirectory().then((Directory directory) {
                      directoryList.add(directory);
                      setState(() {
                        _data = directoryList.toString();
                      });
                    });
                  });
                });
              },
            ),
            FlatButton(
              child: Text('创建文件'),
              onPressed: () async {
                try {
                  Directory doc = await getApplicationDocumentsDirectory();
                  String myFilePath = doc.path + '/myFile.txt';
                  File file = File(myFilePath);
                  // file.exists().then((exist){
                  //   _data = exist.toString();
                  //   print(_data);
                  // });
                  bool exist = await file.exists();
                  if (!exist) {
                    await file.writeAsString('contents'); //这就创建了。。。
                  }
                  exist = await file.exists();
                  _data = exist.toString();
                } catch (e) {
                  _data = e.toString();
                } finally {
                  setState(() {
                    print('setstate');
                  });
                }
              },
            ),
            FlatButton(
              child: Text('编辑文件'),
              onPressed: () async{
                Directory doc = await getApplicationDocumentsDirectory();
                  String myFilePath = doc.path + '/myFile.txt';
                  File file = File(myFilePath);
                  await file.writeAsString('contents');
              },
            ),
            FlatButton(
              child: Text('移动文件-复制到新的地址，并把原有文件删除'),
              onPressed: () async {
                try {
                  Directory doc = await getApplicationDocumentsDirectory();
                  String myFilePath = doc.path + '/myFile.txt';
                  File myFile = File(myFilePath);
                  Directory sdoc = await getApplicationSupportDirectory();
                  String myNewFilePath = sdoc.path + '/myFile.txt';
                  await myFile.copy(myNewFilePath);
                  await myFile.delete();
                } catch (e) {
                  _data = e.toString();
                } finally {
                  setState(() {});
                }
              },
            ),
            FlatButton(
              child: Text('删除文件'),
              onPressed: () async{
                Directory doc = await getApplicationDocumentsDirectory();
                  String myFilePath = doc.path + '/myFile.txt';
                  File myFile = File(myFilePath);
                  await myFile.delete();
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  '$_data',
                  style: TextStyle(fontSize: 32),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
