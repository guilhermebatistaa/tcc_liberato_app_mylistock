import 'package:flutter/material.dart';
import 'package:my_app/data/item_dao.dart';
import 'package:my_app/services/ItemService.dart';

class ExclusionScreen extends StatefulWidget {
  ExclusionScreen({this.nome, this.id, Key? key});

  String? nome;
  String? id;

  @override
  State<ExclusionScreen> createState() => _ExclusionScreenState();
}

class _ExclusionScreenState extends State<ExclusionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 200,
          width: 375,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Confirmação de exclusão',
                      style: TextStyle(fontSize: 22),
                      softWrap: true,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Exclusão cancelada'),
                          ),
                        );
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back), // Ícone de voltar.
                    ),
                  ),
                ],
              ),
              Text(
                'Excluír o item ${widget.nome!}?',
                style: TextStyle(fontSize: 15),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Exclusão cancelada'),
                          ),
                        );
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancelar',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await ItemService().excluirItem(widget.id!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Item excluído',
                            ),
                          ),
                        );
                        Navigator.pop(context, true);
                      },
                      child: const Text(
                        'Confirmar',
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
