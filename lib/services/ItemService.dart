import 'package:my_app/Models/TabelaItem.dart';
import 'package:my_app/components/listagem/ItemWidget.dart';
import 'package:my_app/data/item_dao.dart';
import 'package:my_app/Models/Item.dart';

class ItemService {
  Future<List<ItemWidget>> buscarTodosOsItens(
      [bool ordenadoPorPrioridade = true]) async {
    List<Map<String, dynamic>> listaDeMapasDeItens =
        await ItemDao().buscarTodosOsItens();

    List<ItemWidget> listaDeItens = transformarMapParaList(listaDeMapasDeItens);

    if (ordenadoPorPrioridade) {

      //Primeira Parte
      List<ItemWidget> itensComCompraCasual =
          listaDeItens.where((item) => item.item.compraCasual != "0").toList();

      itensComCompraCasual.sort((a, b) {
        int comparacaoCompraCasual =
            a.item.compraCasual.compareTo(b.item.compraCasual);
        if (comparacaoCompraCasual != 0) {
          return comparacaoCompraCasual;
        }

        return a.item.nome.compareTo(b.item.nome);
      });

      List<ItemWidget> listaDeItensOrdenadaPrioridade = [];
      for (var item in itensComCompraCasual) {
        listaDeItensOrdenadaPrioridade.add(item);
        listaDeItens.remove(item);
      }
      

      //Segunda Parte
      List<ItemWidget> listaItensComEstoqueBaixo = listaDeItens.where((item) {
        int estoqueAtual = int.tryParse(item.item.estoqueAtual)!;
        int estoqueMinimo = int.tryParse(item.item.estoqueMinimo)!;
        return estoqueAtual <= estoqueMinimo;
      }).toList();

      listaItensComEstoqueBaixo.sort((a, b) {
        int valorDiferencaA = int.tryParse(a.item.estoqueAtual)! -
            int.tryParse(a.item.estoqueMinimo)!;
        int valorDiferencaB = int.tryParse(b.item.estoqueAtual)! -
            int.tryParse(b.item.estoqueMinimo)!;

        if (valorDiferencaA != valorDiferencaB) {
          return valorDiferencaA.compareTo(valorDiferencaB);
        }

        return a.item.nome.compareTo(b.item.nome);
      });

      for (var item in listaItensComEstoqueBaixo) {
        listaDeItensOrdenadaPrioridade.add(item);
        listaDeItens.remove(item);
      }


      //Terceira Parte
      List<ItemWidget> listaItensComEstoqueMedio = listaDeItens.where((item) {
        int estoqueAtual = int.tryParse(item.item.estoqueAtual)!;
        int estoqueMaximo = int.tryParse(item.item.estoqueMaximo)!;
        return estoqueAtual <= estoqueMaximo;
      }).toList();

      listaItensComEstoqueMedio.sort((a, b) {
        int valorDiferencaA = int.tryParse(a.item.estoqueAtual)! -
            int.tryParse(a.item.estoqueMaximo)!;
        int valorDiferencaB = int.tryParse(b.item.estoqueAtual)! -
            int.tryParse(b.item.estoqueMaximo)!;

        if (valorDiferencaA != valorDiferencaB) {
          return valorDiferencaA.compareTo(valorDiferencaB);
        }

        return a.item.nome.compareTo(b.item.nome);
      });

      for (var item in listaItensComEstoqueMedio) {
        listaDeItensOrdenadaPrioridade.add(item);
        listaDeItens.remove(item);
      }


      //Quarta Parte
      List<ItemWidget> listaItensComEstoqueAlto = listaDeItens.where((item) {
        int estoqueAtual = int.tryParse(item.item.estoqueAtual)!;
        int estoqueMaximo = int.tryParse(item.item.estoqueMaximo)!;
        return estoqueAtual > estoqueMaximo;
      }).toList();

      listaItensComEstoqueAlto.sort((a, b) {
        int valorDiferencaA = int.tryParse(a.item.estoqueAtual)! -
            int.tryParse(a.item.estoqueMaximo)!;
        int valorDiferencaB = int.tryParse(b.item.estoqueAtual)! -
            int.tryParse(b.item.estoqueMaximo)!;

        if (valorDiferencaA != valorDiferencaB) {
          return valorDiferencaA.compareTo(valorDiferencaB);
        }

        return a.item.nome.compareTo(b.item.nome);
      });

      for (var item in listaItensComEstoqueAlto) {
        listaDeItensOrdenadaPrioridade.add(item);
        listaDeItens.remove(item);
      }

      return listaDeItensOrdenadaPrioridade;
    }

    return listaDeItens;
  }


  Future<List<ItemWidget>> procurarItem({String? nome, String? id}) async {
    List<Map<String, dynamic>> listaDeMapaDoItem = [];

    if (nome != null) {
      listaDeMapaDoItem = await ItemDao().procurarItem(nome: nome);
    } else if (id != null) {
      listaDeMapaDoItem = await ItemDao().procurarItem(id: id);
    }

    return transformarMapParaList(listaDeMapaDoItem);
  }

  List<ItemWidget> transformarMapParaList(
      List<Map<String, dynamic>> listaDeMapasDeItens) {
    final List<ItemWidget> retornoListaDeItens = [];

    for (Map<String, dynamic> linhaDoMapa in listaDeMapasDeItens) {
      Item item = Item();
      item.nome = linhaDoMapa[TabelaItem.nome];
      item.compraCasual = linhaDoMapa[TabelaItem.compraCasual].toString();
      item.estoqueAtual = linhaDoMapa[TabelaItem.estoqueAtual].toString();
      item.precoMaximo = linhaDoMapa[TabelaItem.precoMaximo].toString();
      item.precoMinimo = linhaDoMapa[TabelaItem.precoMinimo].toString();
      item.estoqueMaximo = linhaDoMapa[TabelaItem.estoqueMaximo].toString();
      item.estoqueMinimo = linhaDoMapa[TabelaItem.estoqueMinimo].toString();
      item.id = linhaDoMapa[TabelaItem.id].toString();

      final ItemWidget itemWidget = ItemWidget(item);

      retornoListaDeItens.add(itemWidget);
    }

    return retornoListaDeItens;
  }


  salvarItem(ItemWidget itemWidget) async {
    var itemNomeExiste = await procurarItem(nome: itemWidget.item.nome);

    if (itemWidget.item.id == "" && itemNomeExiste.isEmpty) {
      Map<String, dynamic> mapaDeItem = transformarListParaMap(itemWidget);

      return await ItemDao().inserirItem(mapaDeItem);
    }

    if (itemWidget.item.id != "") {
      var itemIdExists = await procurarItem(id: itemWidget.item.id);

      if (itemIdExists.isNotEmpty) {
        Map<String, dynamic> itemMap = Map();
        if (itemNomeExiste.isNotEmpty) {
          bool queroItemMapaComNome = true;
          itemMap = transformarListParaMap(itemWidget, !queroItemMapaComNome);
        } else {
          itemMap = transformarListParaMap(itemWidget);
        }
        return await ItemDao().alterarItem(itemMap);
      }
    }

    return;
  }

  Map<String, dynamic> transformarListParaMap(ItemWidget itemWidget,
      [bool comNome = true]) {
    final Map<String, dynamic> retornoMapaDeItens = Map();

    if (comNome) {
      retornoMapaDeItens[TabelaItem.nome] = itemWidget.item.nome;
    }
    retornoMapaDeItens[TabelaItem.compraCasual] = itemWidget.item.compraCasual;
    retornoMapaDeItens[TabelaItem.estoqueAtual] = itemWidget.item.estoqueAtual;
    retornoMapaDeItens[TabelaItem.precoMaximo] = itemWidget.item.precoMaximo;
    retornoMapaDeItens[TabelaItem.precoMinimo] = itemWidget.item.precoMinimo;
    retornoMapaDeItens[TabelaItem.estoqueMaximo] =
        itemWidget.item.estoqueMaximo;
    retornoMapaDeItens[TabelaItem.estoqueMinimo] =
        itemWidget.item.estoqueMinimo;
    if (itemWidget.item.id != "") {
      retornoMapaDeItens[TabelaItem.id] = itemWidget.item.id;
    }

    return retornoMapaDeItens;
  }


  excluirItem(String id) async {
    return await ItemDao().excluirItem(id);
  }
}
