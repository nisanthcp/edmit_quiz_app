import 'dart:io';

import 'package:edmit_quiz_app/const/const.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// ignore: missing_return
Future<Database> copyDB() async {
  var dbPath = await getDatabasesPath;
  // ignore: unused_local_variable
  var path = join(dbPath, dbName);

  var exists = databaseExists(path);
  if( exists != null ){
    try{
      await Directory(dirname(path)).create(recursive: true);
    }catch(_){}
  }
}
