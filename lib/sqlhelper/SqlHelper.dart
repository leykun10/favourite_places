import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class SqlHelper {


  static Future<Database> openDatabases() async {
    final entryPath = await getDatabasesPath ();
    return openDatabase (path.join (entryPath, 'places'), version: 1,
        onCreate: (Database newDb, int version) async {
          newDb.execute
            (
              'CREATE TABLE places(id Text PRIMARY KEY,title Text,image Text)');
        });
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await SqlHelper.openDatabases ();
         db.insert (
        table, data);
  }


  static Future<List<Map<String,dynamic>>> placeList(String table) async{
  final db =await SqlHelper.openDatabases();
  return db.query(table);
  }
}

