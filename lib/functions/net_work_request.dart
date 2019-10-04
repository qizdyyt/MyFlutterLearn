import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class NetWorkRequestPage extends StatefulWidget {
  @override
  State<NetWorkRequestPage> createState() {
    return _NetWorkRequestPageState();
  }
}

class _NetWorkRequestPageState extends State<NetWorkRequestPage> {
  String _data;
  bool _loading;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('网络请求'),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                FlatButton(
                  child: Text('请求百度'),
                  onPressed: _loading ? null : getBaiduData,
                ),
                FlatButton(
                  child: Text('请求网易'),
                  onPressed: _loading ? null : getWangyiData,
                ),
                FlatButton(
                  child: Text('post请求'),
                  onPressed: _loading ? null : postRequest,
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Text('$_data'),
              ),
            ),
          ],
        ),
      ),
    );
  }

/*
 * idleTimeout对应请求头中的keep-alive字段值，为了避免频繁建立连接，
httpClient在请求结束后会保持连接一段时间，超过这个阈值后才会关闭连接。

 * connectionTimeout	和服务器建立连接的超时，如果超过这个值则会抛出SocketException异常。
 * 
 * maxConnectionsPerHost	同一个host，同时允许建立连接的最大数量。
 * 
 * autoUncompress	对应请求头中的Content-Encoding，如果设置为true，
则请求头中Content-Encoding的值为当前HttpClient支持的压缩算法列表，目前只有"gzip"

 * userAgent	对应请求头中的User-Agent字段。
 * 
 * 可以发现，有些属性只是为了更方便的设置请求头，对于这些属性，
 你完全可以通过HttpClientRequest直接设置header，
 不同的是通过HttpClient设置的对整个httpClient都生效，而通过HttpClientRequest设置的只对当前请求生效
 */
  Future getBaiduData() async {
    setState(() {
      _loading = true;
      _data = 'loading';
    });

    try {
      //创建一个HTTPClient
      HttpClient httpClient = new HttpClient();
      //打开HTTP链接
      HttpClientRequest request =
          await httpClient.getUrl(Uri.parse('https://www.baidu.com'));
      //使用iPhone的UA
      request.headers.add("user-agent",
          "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1");
      //等待连接服务器--会把请求信息发送给服务器
      HttpClientResponse response = await request.close();
      //读取响应内容
      _data = await response.transform(utf8.decoder).join();
      //输出响应
      print(response.headers);
      //关闭client后所有请求都会终止
      httpClient.close();
    } catch (e) {
      _data = '请求失败：$e';
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

///主要使用Dio框架
  Future getWangyiData() async {
    setState(() {
      _data = 'loading';
      _loading = true;
    });
    Response response;
    try {
      Dio dio = new Dio();
    response = await dio.get('https://music.163.com/');
    _data = response.data.toString();
    }on DioError catch (e) {
      _data = e.toString();
    }finally {
      setState(() {
      _loading = false;
      
    });
    }
    
    /*
    有参数的
    直接拼到URL里面
    response = await dio.get("/test?id=12&name=wendu");
    或者
    response = await dio.get("/test", queryParameters: {"id": 12, "name": "wendu"});
    */
    
  }

///上传数据，上传文件都是通过post上传
  Future postRequest() async {
    setState(() {
      _data = 'loading';
      _loading = true;
    });
    try {
      Dio dio = new Dio();
      Response response;
      response = await dio.post('https://www.baidu.com',data: {"id": 12, "name": "wendu"});
      _data = response.data.toString();
    }on DioError catch(e) {
      _data = e.toString();
    }finally {
      setState(() {
        _loading = false;
      });
    }
  }

  
}
