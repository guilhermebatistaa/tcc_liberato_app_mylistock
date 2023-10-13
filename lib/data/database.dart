import 'package:my_app/data/item_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'item.db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ItemDao.tableSql);
    },
    version: 1,
  );
}
