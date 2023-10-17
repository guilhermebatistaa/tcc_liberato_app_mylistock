import 'package:my_app/Models/TabelaItem.dart';
import 'package:my_app/components/listagem/ItemWidget.dart';
import 'package:my_app/data/item_dao.dart';
import 'package:my_app/Models/Item.dart';

class ItemService {
  Future<List<ItemWidget>> buscarTodosOsItens() async {
    List<Map<String, dynamic>> listaDeMapasDeItens =
        await ItemDao().buscarTodosOsItens();

    return transformarMapParaList(listaDeMapasDeItens);
  }

  Future<List<ItemWidget>> procurarItem({String? nome, String? id}) async {
    List<Map<String, dynamic>> listaDeMapaDoItem =
        await ItemDao().procurarItem();

    return transformarMapParaList(listaDeMapaDoItem);
  }

  List<ItemWidget> transformarMapParaList(
      List<Map<String, dynamic>> listaDeMapasDeItens) {
    final List<ItemWidget> retornoListaDeItens = [];

    for (Map<String, dynamic> linhaDoMapa in listaDeMapasDeItens) {
      Item item = Item();
      item.nome = linhaDoMapa[TabelaItem.name];
      item.compraCasual = linhaDoMapa[TabelaItem.compraCasual];
      item.estoqueAtual = linhaDoMapa[TabelaItem.estoqueAtual];
      item.precoMaximo = linhaDoMapa[TabelaItem.precoMaximo];
      item.precoMinimo = linhaDoMapa[TabelaItem.precoMinimo];
      item.estoqueMaximo = linhaDoMapa[TabelaItem.estoqueMaximo];
      item.estoqueMinimo = linhaDoMapa[TabelaItem.estoqueMinimo];
      item.id = linhaDoMapa[TabelaItem.id];

      final ItemWidget itemWidget = ItemWidget(item);

      retornoListaDeItens.add(itemWidget);
    }

    return retornoListaDeItens;
  }

  salvarItem(ItemWidget itemWidget) async {
    var itemNomeExiste = await procurarItem(nome: itemWidget.nome);

    if (itemWidget.id == "" && itemNomeExiste.isEmpty) {
      Map<String, dynamic> itemMap = transformarListParaMap(itemWidget);

      return await ItemDao().inserirItem(TabelaItem.name, itemMap);
    }

    if (itemWidget.id != "") {
      var itemIdExists = await procurarItem(id: itemWidget.id);

      if (itemIdExists.isNotEmpty) {
        if (itemNomeExiste.isNotEmpty) {
          bool queroItemMapaComNome = true;
          Map<String, dynamic> itemMapSemNome =
              transformarListParaMap(itemWidget, !queroItemMapaComNome);

          return await ItemDao().alterarItem(itemMapSemNome);
        }
      }
    }

    return;
  }

  Map<String, dynamic> transformarListParaMap(ItemWidget itemWidget,
      [bool comNome = true]) {
    final Map<String, dynamic> retornoMapaDeItens = Map();

    if (comNome) {
      retornoMapaDeItens[TabelaItem.name] = itemWidget.nome;
    }
    retornoMapaDeItens[TabelaItem.compraCasual] = itemWidget.compraCasual;
    retornoMapaDeItens[TabelaItem.estoqueAtual] = itemWidget.estoqueAtual;
    retornoMapaDeItens[TabelaItem.precoMaximo] = itemWidget.precoMaximo;
    retornoMapaDeItens[TabelaItem.precoMinimo] = itemWidget.precoMinimo;
    retornoMapaDeItens[TabelaItem.estoqueMaximo] = itemWidget.estoqueMaximo;
    retornoMapaDeItens[TabelaItem.estoqueMinimo] = itemWidget.estoqueMinimo;
    if (itemWidget.id != "") {
      retornoMapaDeItens[TabelaItem.id] = itemWidget.id;
    }

    return retornoMapaDeItens;
  }

  excluirItem(String id) async {

    return await ItemDao().excluirItem(id);
  }
}
