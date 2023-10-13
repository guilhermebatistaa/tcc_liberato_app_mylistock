import 'package:flutter/material.dart';
import 'package:my_app/components/shared/legenda.dart';
import 'package:my_app/components/listagem/mensagem.dart';
import 'package:my_app/components/listagem/quantidade.dart';
import 'package:my_app/screens/form_screen.dart';

class Item extends StatefulWidget {
  String nome;
  String compraCasual;
  String estoqueAtual;
  String precoMaximo;
  String precoMinimo;
  String estoqueMaximo;
  String estoqueMinimo;
  String id;

  Item(this.nome, this.compraCasual, this.estoqueAtual, this.precoMaximo,
      this.precoMinimo, this.estoqueMaximo, this.estoqueMinimo, this.id,
      {super.key});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
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
                    nome: widget.nome,
                    compraCasual: widget.compraCasual,
                    estoqueAtual: widget.estoqueAtual,
                    precoMaximo: widget.precoMaximo,
                    precoMinimo: widget.precoMinimo,
                    estoqueMaximo: widget.estoqueMaximo,
                    estoqueMinimo: widget.estoqueMinimo,
                    id: widget.id,
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
                color: Color.fromRGBO(46, 139, 87, 10),
              ),
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
                                  widget.nome,
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
                                width: 87,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CriarLegenda(44, 'Compra Cas.:'),
                                    CriarCampoQuantidade(
                                        40, widget.compraCasual),
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
                                  CriarLegenda(32, 'Preço Máx.:'),
                                  CriarCampoQuantidade(60, widget.precoMaximo),
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
                                  CriarLegenda(32, 'Preço Mín.:'),
                                  CriarCampoQuantidade(60, widget.precoMinimo),
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
                                  CriarLegenda(31, 'Est. Atu:'),
                                  CriarCampoQuantidade(40, widget.estoqueAtual),
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
                                  CriarLegenda(30, 'Est. Máx.:'),
                                  CriarCampoQuantidade(
                                      40, widget.estoqueMaximo),
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
                                  CriarLegenda(30, 'Est. Mín.:'),
                                  CriarCampoQuantidade(
                                      40, widget.estoqueMinimo),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  CriarMensagem(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
