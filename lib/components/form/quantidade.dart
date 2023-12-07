import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CampoQuantidade extends StatelessWidget {
  double largura;
  TextEditingController controller;

  CampoQuantidade(
    this.largura,
    this.controller, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Converte a string para double
    double quantidadeDouble = double.tryParse(controller.text) ?? 0;

    // Crie uma instância de NumberFormat
    NumberFormat formatacao = NumberFormat("#,##0", "pt_BR");

    // Formate o valor
    controller.text = formatacao.format(quantidadeDouble);
    return SizedBox(
      height: 30,
      width: largura,
      child: Expanded(
        child: TextFormField(
          controller: controller,
          //validator, controller
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
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
      ),
    );
  }
}
