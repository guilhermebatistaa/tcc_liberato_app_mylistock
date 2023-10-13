import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:my_app/components/listagem/item.dart';
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

  salvarItem(Item item) async {
    print('Acessando o SalvarNoBancoDeDados:');

    final Database bancoDeDados = await getDatabase();

    var itemNomeExiste = await procurarItem(nome: item.nome);
    Map<String, dynamic> itemMap = transformarListParaMap(item);

    if (item.id == "" && itemNomeExiste.isEmpty) {
      print('O item não existia.');

      return await bancoDeDados.insert(_tablename, itemMap);
    }

    if (item.id != "") {
      var itemIdExists = await procurarItem(id: item.id);

      if (itemIdExists.isNotEmpty) {
        print('O item existe!');

        if (itemNomeExiste.isNotEmpty) {
          bool queroItemMapaComNome = true;
          itemMap = transformarListParaMap(item, !queroItemMapaComNome);
        }

        return await bancoDeDados.update(
          _tablename,
          itemMap,
          where: '$_id = ?',
          whereArgs: [item.id],
        );
      }
    }
    
    print('Já existe um item com esse nome!');
    
    return;
  }

  Map<String, dynamic> transformarListParaMap(Item item, [bool comNome = true]) {
    print('Convertendo item em Map:');

    final Map<String, dynamic> mapaDeItens = Map();

    if(comNome) {
      mapaDeItens[_name] = item.nome;
    }
    mapaDeItens[_compraCasual] = item.compraCasual;
    mapaDeItens[_estoqueAtual] = item.estoqueAtual;
    mapaDeItens[_precoMaximo] = item.precoMaximo;
    mapaDeItens[_precoMinimo] = item.precoMinimo;
    mapaDeItens[_estoqueMaximo] = item.estoqueMaximo;
    mapaDeItens[_estoqueMinimo] = item.estoqueMinimo;
    if (item.id != "") {
      mapaDeItens[_id] = item.id;
    }

    print('Mapa de Itens: $mapaDeItens');

    return mapaDeItens;
  }

  Future<List<Item>> buscarTodosOsItens() async {
    print('Acessando o BuscarTodosOsItens:');

    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tablename);

    print('Procurando dados no banco de dados... Encontrado: $result');

    return transformarMapParaList(result);
  }

  List<Item> transformarMapParaList(
      List<Map<String, dynamic>> listaDeMapasDeItens) {
    print('Convertendo item em List:');

    final List<Item> listaDeItens = [];

    for (Map<String, dynamic> linhaDoMapa in listaDeMapasDeItens) {
      final Item item = Item(
        linhaDoMapa[_name],
        linhaDoMapa[_compraCasual].toString(),
        linhaDoMapa[_estoqueAtual].toString(),
        linhaDoMapa[_precoMaximo].toString(),
        linhaDoMapa[_precoMinimo].toString(),
        linhaDoMapa[_estoqueMaximo].toString(),
        linhaDoMapa[_estoqueMinimo].toString(),
        linhaDoMapa[_id].toString());
      listaDeItens.add(item);
    }

    print('Finalizado conversão do item em List.');

    return listaDeItens;
  }

  Future<List<Item>> procurarItem({String? nome, String? id}) async {
    print('Acessando o ProcurarItemNoBancoDeDados:');

    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result;

    if(nome != null){
       result = await bancoDeDados.query(
        _tablename,
        where: '$_name = ?',
        whereArgs: [nome],
      );
    } else {
      result = await bancoDeDados.query(
        _tablename,
        where: '$_id = ?',
        whereArgs: [id],
      );
    }
    
    print('Item encontrado: ${transformarMapParaList(result)}');

    return transformarMapParaList(result);
  }

  excluirItem(String id) async {
    print('Deletando item: $id');

    final Database bancoDeDados = await getDatabase();

    print('Item deletado.');

    return bancoDeDados.delete(
      _tablename,
      where: '$_id = ?',
      whereArgs: [id],
    );
  }
}
