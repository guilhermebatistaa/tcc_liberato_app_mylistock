import 'dart:ffi';
import 'package:flutter/foundation.dart';
import 'package:my_app/Models/TabelaItem.dart';
import 'package:my_app/components/listagem/ItemWidget.dart';
import 'package:my_app/data/database.dart';
import 'package:sqflite/sqflite.dart';

class ItemDao {
  static const String _tablename = 'ItemTable';
  static const String _name = 'name';
  static const String _compraCasual = 'compraCasual';
  static const String _estoqueAtual = 'estoqueAtual';
  static const String _precoMinimo = 'precoMinimo';
  static const String _precoMaximo = 'precoMaximo';
  static const String _estoqueMaximo = 'estoqueMaximo';
  static const String _estoqueMinimo = 'estoqueMinimo';
  static const String _id = 'id';

  static const String tableSql = 'CREATE TABLE IF NOT EXISTS $_tablename('
      '$_id INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$_name TEXT, '
      '$_compraCasual INTEGER, '
      '$_estoqueAtual INTEGER, '
      '$_precoMaximo REAL, '
      '$_precoMinimo REAL, '
      '$_estoqueMaximo INTEGER, '
      '$_estoqueMinimo INTEGER)';

  Future<List<Map<String, dynamic>>> buscarTodosOsItens() async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tablename);

    return result;
  }

  Future<List<Map<String, dynamic>>> procurarItem(
      {String? nome, String? id}) async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> retornoListaDeMapaDoItem;

    if (nome != null) {
      retornoListaDeMapaDoItem = await bancoDeDados.query(
        _tablename,
        where: '$_name = ?',
        whereArgs: [nome],
      );
    } else {
      retornoListaDeMapaDoItem = await bancoDeDados.query(
        _tablename,
        where: '$_id = ?',
        whereArgs: [id],
      );
    }

    return retornoListaDeMapaDoItem;
  }

  Future<int> inserirItem(
      String nomeTabela, Map<String, dynamic> itemMap) async {
    final Database bancoDeDados = await getDatabase();

    return await bancoDeDados.insert(nomeTabela, itemMap);
  }

  Future<int> alterarItem(Map<String, dynamic> itemMap) async {
    final Database bancoDeDados = await getDatabase();

    return await bancoDeDados.update(
      TabelaItem.name,
      itemMap,
      where: '$TabelaItem.id = ?',
      whereArgs: [itemMap[TabelaItem.id]],
    );
  }

  excluirItem(String id) async {
    final Database bancoDeDados = await getDatabase();

    return bancoDeDados.delete(
      TabelaItem.name,
      where: '$TabelaItem.id = ?',
      whereArgs: [id],
    );
  }
}
