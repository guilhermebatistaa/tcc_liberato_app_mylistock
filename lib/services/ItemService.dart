import 'package:intl/intl.dart';
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

    //Pré Primeira Parte - Compra Casual
    List<ItemWidget> itensSemNome = listaDeItens
        .where((item) => item.item.nome == "Item sem nome")
        .toList();

    List<ItemWidget> retornoListaItensOrdemPrioridade = [];
    for (var item in itensSemNome) {
      item.item.nivel = 4;
      retornoListaItensOrdemPrioridade.add(item);
      listaDeItens.remove(item);
    }

    //Primeira Parte - Compra Casual
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

    for (var item in itensComCompraCasual) {
      item.item.nivel = 0;
      retornoListaItensOrdemPrioridade.add(item);
      listaDeItens.remove(item);
    }

    //Segunda Parte - Estoque com Urgência
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
      item.item.nivel = 1;
      retornoListaItensOrdemPrioridade.add(item);
      listaDeItens.remove(item);
    }

    //Terceira Parte - Estoque Médio
    List<ItemWidget> listaItensComEstoqueMedio = listaDeItens.where((item) {
      int estoqueAtual = int.tryParse(item.item.estoqueAtual)!;
      int estoqueMaximo = int.tryParse(item.item.estoqueMaximo)!;
      return estoqueAtual < estoqueMaximo;
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
      item.item.nivel = 2;
      retornoListaItensOrdemPrioridade.add(item);
      listaDeItens.remove(item);
    }

    //Quarta Parte - Estoque Cheio
    List<ItemWidget> listaItensComEstoqueAlto = listaDeItens.where((item) {
      int estoqueAtual = int.tryParse(item.item.estoqueAtual)!;
      int estoqueMaximo = int.tryParse(item.item.estoqueMaximo)!;
      return estoqueAtual >= estoqueMaximo;
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
      item.item.nivel = 3;
      retornoListaItensOrdemPrioridade.add(item);
      listaDeItens.remove(item);
    }

    if (ordenadoPorPrioridade) {
      return retornoListaItensOrdemPrioridade;
    } else {
      List<ItemWidget> retornolistaItensOrdemAlfabetica =
          retornoListaItensOrdemPrioridade;

      retornolistaItensOrdemAlfabetica.sort((a, b) {
        return a.item.nome.compareTo(b.item.nome);
      });

      return retornolistaItensOrdemAlfabetica;
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

    conferirCampos(itemWidget);

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

  conferirCampos(ItemWidget itemWidget) {
    itemWidget.item.nome =
        itemWidget.item.nome == "" ? "Item sem nome" : itemWidget.item.nome;
    itemWidget.item.compraCasual == ""
        ? itemWidget.item.compraCasual = "0"
        : itemWidget.item.compraCasual;
    itemWidget.item.estoqueAtual == ""
        ? itemWidget.item.estoqueAtual = "0"
        : itemWidget.item.estoqueAtual;
    itemWidget.item.precoMaximo == ""
        ? itemWidget.item.precoMaximo = "0"
        : itemWidget.item.precoMaximo;
    itemWidget.item.precoMinimo == ""
        ? itemWidget.item.precoMinimo = "0"
        : itemWidget.item.precoMinimo;
    itemWidget.item.estoqueMaximo == ""
        ? itemWidget.item.estoqueMaximo = "0"
        : itemWidget.item.estoqueMaximo;
    itemWidget.item.estoqueMinimo == ""
        ? itemWidget.item.estoqueMinimo = "0"
        : itemWidget.item.estoqueMinimo;

    itemWidget.item.precoMaximo.replaceAll('.', '');
    itemWidget.item.precoMinimo.replaceAll('.', '');

    NumberFormat formatacao = NumberFormat("0.00", "pt_BR");

    double valorDouble =
        formatacao.parse(itemWidget.item.precoMaximo).toDouble();
    itemWidget.item.precoMaximo = (valorDouble).toString();

    valorDouble = formatacao.parse(itemWidget.item.precoMinimo).toDouble();
    itemWidget.item.precoMinimo = (valorDouble).toString();
  }
}
