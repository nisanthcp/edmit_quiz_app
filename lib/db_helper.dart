import 'dart:io';

import 'package:edmit_quiz_app/const/const.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// ignore: missing_return
Future<Database> copyDB() async {
  var dbPath = await getDatabasesPath;
  // ignore: unused_local_variable
  var path = join(dbPath, dbName);

  var exists = databaseExists(path);
  if (exists != null) {
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}
    ByteData data = await rootBundle.load(join("assets/db", dbName));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes, flush: true);
  } else {
    print('DB already exists');
  }
  return await openDatabase(path, readOnly: true);
}
