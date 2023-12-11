import 'package:flutter/material.dart';
import 'package:my_app/Models/Constants.dart';
import 'package:my_app/components/listagem/ItemWidget.dart';
import 'package:my_app/data/item_dao.dart';
import 'package:my_app/screens/form_screen.dart';
import 'package:my_app/services/ItemService.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool ordenacao = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(Icons.refresh),
          )
        ],
        title: Text(
          ordenacao == true
              ? 'LiStock: Ordem Prioridade'
              : 'LiStock: Ordem Alfabética',
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/estante.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<List<ItemWidget>>(
          future: ItemService().buscarTodosOsItens(ordenacao),
          builder: (context, snapshot) {
            List<ItemWidget>? items = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text('Carregando'),
                    ],
                  ),
                );
              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text('Carregando'),
                    ],
                  ),
                );
              case ConnectionState.active:
                return Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text('Carregando'),
                    ],
                  ),
                );
              case ConnectionState.done:
                if (snapshot.hasData && items != null) {
                  if (items.isNotEmpty) {
                    return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          final ItemWidget tarefa = items[index];
                          return tarefa;
                        });
                  }

                  return Center(
                    child: Column(
                      children: [
                        Icon(Icons.error_outline, size: 128),
                        Text(
                          'Não há nenhum item',
                          style: TextStyle(
                              fontSize: 32,
                              color: Color.fromRGBO(255, 69, 0,
                                  1.0)), // Substitua "Colors.red" pela cor desejada
                        ),
                      ],
                    ),
                  );
                }

                return Text('Erro ao carregar Tarefas');
            }
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        // Adicione seus itens de rodapé aqui
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Olá ' + Constants.usuario + "!"),
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Você deslogou!")),
                );
                Navigator.of(context).pop();
              },
            ),
            IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                setState(() {
                  ordenacao == true
                      ? ordenacao = false
                      : ordenacao == false
                          ? ordenacao = true
                          : ordenacao;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (contextNew) => FormScreen(
                      itemContext: context,
                    ),
                  ),
                ).then((value) => setState(() {
                      print('Recarregando a tela inicial');
                    }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
