import 'package:my_app/Models/TabelaItem.dart';
import 'package:my_app/data/database.dart';
import 'package:sqflite/sqflite.dart';

class ItemDao {
  Future<List<Map<String, dynamic>>> buscarTodosOsItens() async {
    final Database bancoDeDados = await getDatabase();

    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(TabelaItem.nomeTabela);

    return result;
  }

  Future<List<Map<String, dynamic>>> procurarItem(
      {String? nome, String? id}) async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> retornoListaDeMapaDoItem;

    if (nome != null) {
      retornoListaDeMapaDoItem = await bancoDeDados.query(
        TabelaItem.nomeTabela,
        where: '${TabelaItem.nome} = ?',
        whereArgs: [nome],
      );
    } else {
      retornoListaDeMapaDoItem = await bancoDeDados.query(
        TabelaItem.nomeTabela,
        where: '${TabelaItem.id} = ?',
        whereArgs: [id],
      );
    }

    return retornoListaDeMapaDoItem;
  }

  Future<int> inserirItem(Map<String, dynamic> itemMap) async {
    final Database bancoDeDados = await getDatabase();

    return await bancoDeDados.insert(TabelaItem.nomeTabela, itemMap);
  }

  Future<int> alterarItem(Map<String, dynamic> mapaDeItem) async {
    final Database bancoDeDados = await getDatabase();

    String _tablename = TabelaItem.nomeTabela;
    String _id = TabelaItem.id;

    return await bancoDeDados.update(
      _tablename,
      mapaDeItem,
      where: '$_id = ?',
      whereArgs: [mapaDeItem[TabelaItem.id]],
    );
  }

  excluirItem(String id) async {
    final Database bancoDeDados = await getDatabase();

    return bancoDeDados.delete(
      TabelaItem.nome,
      where: '$TabelaItem.id = ?',
      whereArgs: [id],
    );
  }
}
