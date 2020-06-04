import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:flutter/material.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:path_provider/path_provider.dart';
import 'package:synchronized/synchronized.dart' as Lock;

//主要实现思路就是向文件写入要保存的日志信息
//借鉴了file_lumberdash
/*
  lumberdash: ^2.1.1
  synchronized: ^2.2.0
  archive: ^2.0.13
  */
class Log {
  static final inProduction = bool.fromEnvironment("dart.vm.product");
  static p(Object obj) {
    if (!inProduction) {
      print(obj);
    }
  }

  static Future<String> startWriteLog() async {
    EMLogManager _logManager = EMLogManager();
    return await _logManager.startLog();
  }

  static w(Object obj) {
    if (obj is String) {
      logMessage(obj);
    } else {
      logMessage(obj.toString());
    }
  }

  static error(Object obj) {
    if (obj is String) {
      logError(obj);
    } else {
      logError(obj.toString());
    }
  }

  static warning(Object obj) {
    if (obj is String) {
      logWarning(obj);
    } else {
      logWarning(obj.toString());
    }
  }

  static String _zipLogs() {
    var logDic = Directory(EMLogManager.logDicPath);
    ZipFileEncoder encoder = ZipFileEncoder();
    var zipFileName = 'LogsForUpload.zip';
    var zipPath = '${logDic.parent.path}/$zipFileName';
    encoder.create(zipPath);
    encoder.addDirectory(logDic, includeDirName: false);
    encoder.close();
    return zipPath;
  }
}

const String _fileNameSeparator = '-';

class EMLogManager {
  static const String logDicName = 'Logs';

  EMLogManager._internal();

  static EMLogManager _singleton = new EMLogManager._internal();
  factory EMLogManager() => _singleton;

  static String logDicPath = '';

  Future<String> startLog() async {
    String logFilePath = await getLogFilePath();
    deleteUselessLogFile();
    putLumberdashToWork(withClients: [EMLogClient(filePath: logFilePath)]);
    return logFilePath;
  }

  void deleteUselessLogFile() async {
    if (logDicPath.length != 0) {
      Directory logDir = Directory(logDicPath);
      var logList = logDir.listSync();
      if (logList.length >= 15) {
        logList.sort((log1, log2) {
          String log1Name = log1.path.split('/').last;
          String log2Name = log2.path.split('/').last;
          return log2Name.compareTo(log1Name);
        });
        var deleteList = List<FileSystemEntity>();
        deleteList = logList.sublist(15);
        for (var logInfo in deleteList) {
          logInfo.delete();
        }
      }
    }
  }

  Future<String> getLogFilePath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    Directory logDic = Directory(appDocPath + '/' + logDicName);
    logDicPath = logDic.path;
    String logFileName = DateTime.now().year.toString() +
        _fileNameSeparator +
        DateTime.now().month.toString() +
        _fileNameSeparator +
        DateTime.now().day.toString();
    String logFilePath =
        appDocPath + '/' + logDicName + '/' + logFileName + '.log';

    bool logDicExists = await logDic.exists();
    if (logDicExists) {
      print(logFilePath);
      return logFilePath;
    } else {
      await logDic.create(recursive: false);
      return logFilePath;
    }
  }
}

class EMLogClient extends LumberdashClient {
  File _logFile;
  static final _lock = Lock.Lock();

  EMLogClient({@required String filePath}) : assert(filePath != null) {
    _logFile = File(filePath);
  }

  @override
  void logMessage(String message, [Map<String, String> extras]) {
    if (extras != null) {
      _log('$message, extras:$extras');
    } else {
      _log('$message');
    }
  }

  @override
  void logError(exception, [stacktrace]) {
    if (stacktrace != null) {
      _log('❗️❗️❗️$exception, extras:$stacktrace');
    } else {
      _log('❗️❗️❗️$exception');
    }
  }

  @override
  void logFatal(String message, [Map<String, String> extras]) {
    if (extras != null) {
      _log('$message, extras:$extras');
    } else {
      _log('$message');
    }
  }

  @override
  void logWarning(String message, [Map<String, String> extras]) {
    if (extras != null) {
      _log('Warning: $message, extras:$extras');
    } else {
      _log('Warning: $message');
    }
  }

  Future<void> _log(String data) async {
    try {
      _lock.synchronized(() async{
        final date = DateTime.now();

        String path = _logFile.path;
        String fileName = path.split('/').last;
        String fileDateDay =
            fileName.split('.').first.split(_fileNameSeparator).last;

        if (date.day != int.parse(fileDateDay)) {
          String newPath = path.replaceAll(new RegExp(fileName),
              '${date.year}$_fileNameSeparator${date.month}$_fileNameSeparator${date.day}.log');
          _logFile = File(newPath);
        }

        await _logFile.writeAsString('$date -- $data\n',
            mode: FileMode.writeOnlyAppend, flush: true);
      });
    } catch (e) {
      print("Log exception: $e");
    }
  }
}




