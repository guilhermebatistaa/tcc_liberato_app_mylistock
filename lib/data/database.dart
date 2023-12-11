import 'package:my_app/Models/Constants.dart';
import 'package:my_app/Models/TabelaItem.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  Constants.usuario = Constants.usuario.split('@').first;

  final String path =
      join(await getDatabasesPath(), 'item${Constants.usuario}.db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(TabelaItem.tableSqlCreate);
    },
    version: 1,
  );
}
