import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class QuantidadeValorWidget extends StatelessWidget {
  double largura;
  String quantidadeValor;
  //TextEditingController controller;

  QuantidadeValorWidget(
    this.largura,
    this.quantidadeValor, {
    //, this.controller
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Converte a string para double
    double quantidadeValorDouble = double.tryParse(quantidadeValor) ?? 0.0;

    // Crie uma instância de NumberFormat
    NumberFormat formatacao = NumberFormat("#,##0.00", "pt_BR");

    // Formate o valor
    quantidadeValor = formatacao.format(quantidadeValorDouble);

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
          quantidadeValor,
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
