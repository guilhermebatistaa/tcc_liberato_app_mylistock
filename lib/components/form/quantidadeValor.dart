import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CampoQuantidadeValor extends StatelessWidget {
  double largura;
  TextEditingController controller;

  CampoQuantidadeValor(
    this.largura,
    this.controller, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Converte a string para double
    double quantidadeValorDouble = double.tryParse(controller.text) ?? 0.0;

    // Crie uma instância de NumberFormat
    NumberFormat formatacao = NumberFormat("#,##0.00", "pt_BR");

    // Formate o valor
    controller.text = formatacao.format(quantidadeValorDouble);
    return SizedBox(
      height: 30,
      width: largura,
      child: TextFormField(
        controller: controller,
        // validator, controller
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+(\,\d{0,2})?$')),
        ],
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          fillColor: Colors.white70,
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 5),
        ),
        onTap: () {
          // Selecionar todo o texto
          controller.selection = TextSelection(
            baseOffset: 0,
            extentOffset: controller.text.length,
          );
        },
      ),
    );
  }
}
