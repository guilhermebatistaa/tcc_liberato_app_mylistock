import 'package:flutter/material.dart';
import 'package:my_app/components/listagem/item.dart';

class ItemInherited extends InheritedWidget {
  ItemInherited({
    super.key,
    required this.child,
  }) : super(child: child);

  final Widget child;

  final List<Item> itemList = [
    Item('Feijão','3' , '2', '10', '7', '9', '4', '1'),
    Item('Massa','4' , '6', '5', '4', '8', '2', '2'),
    Item('Arroz','6' , '5', '22', '18', '10', '1', '3'),
  ];

  //nome, estoqueAtual, precoMax, precoMin, estoqueMax, estoqueMin

  void newItem(String nome, String compraCasual, String estoqueAtual, String precoMax, String precoMin,
      String estoqueMax, String estoqueMin, String id) {
    itemList.add(Item(nome, compraCasual, estoqueAtual, precoMax, precoMin, estoqueMax, estoqueMin, id));
  }

  static ItemInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ItemInherited>();
  }

  @override
  bool updateShouldNotify(ItemInherited oldWidget) {
    return oldWidget.itemList.length != itemList.length;
  }
}
