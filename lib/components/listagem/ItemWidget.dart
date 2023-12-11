import 'package:flutter/material.dart';
import 'package:my_app/Models/Item.dart';
import 'package:my_app/components/listagem/quantidadeValor.dart';
import 'package:my_app/components/shared/legenda.dart';
import 'package:my_app/components/listagem/mensagem.dart';
import 'package:my_app/components/listagem/quantidade.dart';
import 'package:my_app/screens/form_screen.dart';

class ItemWidget extends StatefulWidget {
  Item item;

  ItemWidget(this.item, {super.key});

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (contextNew) => FormScreen(
                    nome: widget.item.nome,
                    compraCasual: widget.item.compraCasual,
                    estoqueAtual: widget.item.estoqueAtual,
                    precoMaximo: widget.item.precoMaximo,
                    precoMinimo: widget.item.precoMinimo,
                    estoqueMaximo: widget.item.estoqueMaximo,
                    estoqueMinimo: widget.item.estoqueMinimo,
                    id: widget.item.id,
                  ),
                ),
              ).then((value) {
                if (value != null) {
                  setState(() {
                    print('Recarregando a tela inicial');
                  });
                }
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: widget.item.nivel == 0
                      ? Color.fromRGBO(165, 42, 42, 1.0)
                      : widget.item.nivel == 1
                          ? Color.fromRGBO(255, 69, 0, 1.0)
                          : widget.item.nivel == 2
                              ? Color.fromRGBO(255, 215, 0, 1.0)
                              : widget.item.nivel == 3
                                  ? Color.fromRGBO(46, 139, 87, 10)
                                  : Color.fromRGBO(99, 99, 99, 1)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    //color: Colors.amber,
                    //margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
                    padding: EdgeInsets.only(top: 10, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 30,
                          width: 254.5,
                          child: Expanded(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: Colors.white70,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.item.nome,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 97,
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child: SizedBox(
                                width: 84,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    LegendaWidget(44, 'Comp. Cas.:'),
                                    QuantidadeWidget(
                                        40, widget.item.compraCasual),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 97,
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  LegendaWidget(32, 'Preç. Máx.:'),
                                  QuantidadeValorWidget(
                                      60, widget.item.precoMaximo),
                                ],
                              ),
                            ),
                            Container(
                              width: 97,
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  LegendaWidget(32, 'Preç. Mín.:'),
                                  QuantidadeValorWidget(
                                      60, widget.item.precoMinimo),
                                ],
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 75,
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  LegendaWidget(31, 'Est. Atu:'),
                                  QuantidadeWidget(
                                      40, widget.item.estoqueAtual),
                                ],
                              ),
                            ),
                            Container(
                              width: 75,
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  LegendaWidget(31, 'Est. Máx.:'),
                                  QuantidadeWidget(
                                      40, widget.item.estoqueMaximo),
                                ],
                              ),
                            ),
                            Container(
                              width: 75,
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  LegendaWidget(30, 'Est. Mín.:'),
                                  QuantidadeWidget(
                                      40, widget.item.estoqueMinimo),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  MensagemWidget(widget.item.precoMaximo,
                      widget.item.precoMinimo, widget.item.nivel),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
