import 'package:flutter/material.dart';
import 'package:my_app/Models/Item.dart';
import 'package:my_app/components/listagem/ItemWidget.dart';
import 'package:my_app/components/shared/legenda.dart';
import 'package:my_app/components/form/quantidade.dart';
import 'package:my_app/components/form/setas.dart';
import 'package:my_app/data/item_dao.dart';
import 'package:my_app/screens/exclusion_screen.dart';
import 'package:my_app/services/ItemService.dart';

class FormScreen extends StatefulWidget {
  FormScreen(
      {this.itemContext,
      this.nome,
      this.compraCasual,
      this.estoqueAtual,
      this.precoMaximo,
      this.precoMinimo,
      this.estoqueMaximo,
      this.estoqueMinimo,
      this.id,
      Key? key});

  final BuildContext? itemContext;
  String? nome;
  String? compraCasual;
  String? estoqueAtual;
  String? precoMaximo;
  String? precoMinimo;
  String? estoqueMaximo;
  String? estoqueMinimo;
  String? id;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerCompraCasual = TextEditingController();
  TextEditingController controllerEstoqueAtual = TextEditingController();
  TextEditingController controllerPrecoMaximo = TextEditingController();
  TextEditingController controllerPrecoMinimo = TextEditingController();
  TextEditingController controllerEstoqueMaximo = TextEditingController();
  TextEditingController controllerEstoqueMinimo = TextEditingController();
  TextEditingController controllerId = TextEditingController();

  @override
  void initState() {
    super.initState();
    controllerNome.text = widget.nome ?? "";
    controllerCompraCasual.text = widget.compraCasual ?? "";
    controllerEstoqueAtual.text = widget.estoqueAtual ?? "";
    controllerPrecoMaximo.text = widget.precoMaximo ?? "";
    controllerPrecoMinimo.text = widget.precoMinimo ?? "";
    controllerEstoqueMaximo.text = widget.estoqueMaximo ?? "";
    controllerEstoqueMinimo.text = widget.estoqueMinimo ?? "";
    controllerId.text = widget.id ?? "";
  }

  final _formKey = GlobalKey<FormState>();

  String? _errorMessage;

  bool valueValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 350,
              width: 375,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2),
              ),
              child: Container(
                color: Color.fromRGBO(119, 136, 153, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            controllerId.text.isEmpty
                                ? 'Cadastro de Item'
                                : 'Alteração de Item',
                            style: TextStyle(fontSize: 25),
                            softWrap: true,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.arrow_back), // Ícone de voltar.
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 30,
                            width: 308.5,
                            child: Expanded(
                              child: TextFormField(
                                controller: controllerNome,
                                // onFieldSubmitted: (value) {
                                //   if (nameController.text.trim().isEmpty) {
                                //     nameController.text = '';
                                //     _formKey.currentState!.reset();
                                //   }
                                // },
                                // validator: (String? value) {
                                //   if (valueValidator(value)) {
                                //     setState(() {
                                //       _errorMessage = 'Insira o nome do item';
                                //     });
                                //   } else {
                                //     setState(() {
                                //       _errorMessage = null;
                                //     });
                                //   }
                                //   return null;
                                // },
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Nome',
                                  hintStyle: TextStyle(fontSize: 12),
                                  fillColor: Colors.white70,
                                  filled: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //color: Colors.amberAccent,
                      height: 167,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 132,
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  width: 122,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      LegendaWidget(44, 'Compra Casual:'),
                                      CampoQuantidade(
                                          40, controllerCompraCasual),
                                      BotaoSetas(), //controllerEstAtu
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 132,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    LegendaWidget(33, 'Preço Máx.:'),
                                    CampoQuantidade(60, controllerPrecoMaximo),
                                    BotaoSetas(), //controllerPreMax
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 132,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    LegendaWidget(33, 'Preço Mín.:'),
                                    CampoQuantidade(60, controllerPrecoMinimo),
                                    BotaoSetas(), //controllerPreMin
                                  ],
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 110,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    LegendaWidget(33, 'Est. Atual:'),
                                    CampoQuantidade(40, controllerEstoqueAtual),
                                    BotaoSetas(), //controllerEstAtu
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 110,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    LegendaWidget(33, 'Est. Máx.:'),
                                    CampoQuantidade(
                                        40, controllerEstoqueMaximo),
                                    BotaoSetas(), //controllerEstmax
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 110,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    LegendaWidget(33, 'Est. Mín.:'),
                                    CampoQuantidade(
                                        40, controllerEstoqueMinimo),
                                    BotaoSetas(), //controllerEstMin
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                Item item = Item();
                                item.nome = controllerNome.text;
                                item.compraCasual = controllerCompraCasual.text;
                                item.estoqueAtual = controllerEstoqueAtual.text;
                                item.precoMaximo = controllerPrecoMaximo.text;
                                item.precoMinimo = controllerPrecoMinimo.text;
                                item.estoqueMaximo =
                                    controllerEstoqueMaximo.text;
                                item.estoqueMinimo =
                                    controllerEstoqueMinimo.text;
                                item.id = controllerId.text;

                                await ItemService()
                                    .salvarItem(ItemWidget(item));

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(_errorMessage ??
                                        (controllerId.text.isEmpty
                                            ? 'Cadastrando novo item!'
                                            : 'Salvando alterações')),
                                  ),
                                );
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              controllerId.text.isEmpty
                                  ? 'Adicionar'
                                  : 'Salvar',
                            ),
                          ),
                        ),
                        if (controllerId.text != "")
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: IconButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (contextNew) => ExclusionScreen(
                                      nome: widget.nome,
                                      id: widget.id,
                                    ),
                                  ),
                                ).then((result) {
                                  if (result == true) {
                                    Navigator.of(context).pop();
                                  }
                                });
                              },
                              icon: Icon(Icons.delete_forever),
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
