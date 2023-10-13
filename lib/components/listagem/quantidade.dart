import 'package:flutter/material.dart';

class CriarCampoQuantidade extends StatelessWidget {
  double largura;
  String quantidadeEstoque;
  //TextEditingController controller;

  CriarCampoQuantidade(this.largura, this.quantidadeEstoque, { //, this.controller
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: largura,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white70,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          quantidadeEstoque,
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}