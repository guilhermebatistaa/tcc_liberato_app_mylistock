import 'package:flutter/material.dart';
import 'package:my_app/components/listagem/itemWidget.dart';

class ItemInherited extends InheritedWidget {
  ItemInherited({
    super.key,
    required this.child,
  }) : super(child: child);

  final Widget child;

  final List<ItemWidget> itemList = [];

  static ItemInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ItemInherited>();
  }

  @override
  bool updateShouldNotify(ItemInherited oldWidget) {
    return oldWidget.itemList.length != itemList.length;
  }
}
