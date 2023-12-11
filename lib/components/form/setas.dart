import 'package:flutter/material.dart';

class BotaoSetas extends StatelessWidget {
  TextEditingController controller;

  BotaoSetas(
    this.controller, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: 30,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 25,
            width: 30,
            child: ElevatedButton(
              onPressed: () {
                if (controller.text.contains(',')) {
                  String valorComPonto = controller.text.replaceAll(',', '.');
                  double valorDouble = double.tryParse(valorComPonto) ?? 0.00;
                  if (valorDouble >= 0 && valorDouble < 999.00) {
                    valorDouble += 0.50;

                    String numeroFormatado = valorDouble
                        .toStringAsFixed(2); // Formata com duas casas decimais
                    numeroFormatado = numeroFormatado.replaceAll(
                        '.', ','); // Substitui o ponto pela vírgula
                    controller.text = numeroFormatado;
                  }
                } else {
                  int quantidadeInteiro = int.tryParse(controller.text)!;
                  if (quantidadeInteiro >= 0 && quantidadeInteiro < 999) {
                    quantidadeInteiro++;

                    controller.text = quantidadeInteiro.toString();
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              child: Image.asset(
                'assets/images/angulo-da-seta-para-cima.png',
              ),
            ),
          ),
          SizedBox(
            height: 25,
            width: 30,
            child: ElevatedButton(
              onPressed: () {
                if (controller.text.contains(',')) {
                  String valorComPonto = controller.text.replaceAll(',', '.');
                  double valorDouble = double.tryParse(valorComPonto) ?? 0.00;
                  if (valorDouble > 0 && valorDouble <= 999.00) {
                    valorDouble -= 0.50;

                    String numeroFormatado = valorDouble
                        .toStringAsFixed(2); // Formata com duas casas decimais
                    numeroFormatado = numeroFormatado.replaceAll(
                        '.', ','); // Substitui o ponto pela vírgula
                    controller.text = numeroFormatado;
                  }
                } else {
                  int valorAtualInt = int.tryParse(controller.text) ?? 0;
                  if (valorAtualInt > 0 && valorAtualInt <= 999) {
                    valorAtualInt--;

                    controller.text = valorAtualInt.toString();
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              child: Image.asset(
                'assets/images/seta-para-baixo.png',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
