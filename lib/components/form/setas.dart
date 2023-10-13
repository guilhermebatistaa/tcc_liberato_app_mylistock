import 'package:flutter/material.dart';

class criarBotaoSetas extends StatelessWidget {
  //final TextEditingController controller;

  const criarBotaoSetas({
    //this.controller,
    super.key,
  });

  String formatarNumero(double numero) {
    String numeroFormatado =
        numero.toStringAsFixed(2); // Formata com duas casas decimais
    numeroFormatado =
        numeroFormatado.replaceAll('.', ','); // Substitui o ponto pela vírgula
    return numeroFormatado;
  }

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
              onPressed: () {},
              // onPressed: () {
              //   if (controller.text.contains(',')) {
              //     String numeroComPonto = controller.text.replaceAll(',', '.');
              //     double valorAtualDouble =
              //         double.tryParse(numeroComPonto) ?? 0.00;
              //     if (valorAtualDouble >= 0 && valorAtualDouble < 999.00) {
              //       valorAtualDouble += 0.50;

              //       ScaffoldMessenger.of(context).showSnackBar(
              //         const SnackBar(
              //           duration: Duration(milliseconds: 500),
              //           content: Text('Aumentou estoque do item!'),
              //         ),
              //       );

              //       String numeroFormatado = valorAtualDouble
              //           .toStringAsFixed(2); // Formata com duas casas decimais
              //       numeroFormatado = numeroFormatado.replaceAll(
              //           '.', ','); // Substitui o ponto pela vírgula
              //       controller.text = numeroFormatado;
              //     }
              //   } else {
              //     int valorAtualInt = int.tryParse(controller.text) ?? 0;
              //     if (valorAtualInt >= 0 && valorAtualInt < 999) {
              //       valorAtualInt++;

              //       ScaffoldMessenger.of(context).showSnackBar(
              //         const SnackBar(
              //           duration: Duration(milliseconds: 500),
              //           content: Text('Aumentou estoque do item!'),
              //         ),
              //       );
              //       controller.text = valorAtualInt.toString();
              //     }
              //   }
              // },
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
              onPressed: () {},
              // onPressed: () {
              //   if (controller.text.contains(',')) {
              //     String numeroComPonto = controller.text.replaceAll(',', '.');
              //     double valorAtualDouble =
              //         double.tryParse(numeroComPonto) ?? 0.00;
              //     if (valorAtualDouble > 0 && valorAtualDouble <= 999.00) {
              //       valorAtualDouble -= 0.50;

              //       ScaffoldMessenger.of(context).showSnackBar(
              //         const SnackBar(
              //           duration: Duration(milliseconds: 500),
              //           content: Text('Aumentou estoque do item!'),
              //         ),
              //       );

              //       String numeroFormatado = valorAtualDouble
              //           .toStringAsFixed(2); // Formata com duas casas decimais
              //       numeroFormatado = numeroFormatado.replaceAll(
              //           '.', ','); // Substitui o ponto pela vírgula
              //       controller.text = numeroFormatado;
              //     }
              //   } else {
              //     int valorAtualInt = int.tryParse(controller.text) ?? 0;
              //     if (valorAtualInt > 0 && valorAtualInt <= 999) {
              //       valorAtualInt--;

              //       ScaffoldMessenger.of(context).showSnackBar(
              //         const SnackBar(
              //           duration: Duration(milliseconds: 500),
              //           content: Text('Aumentou estoque do item!'),
              //         ),
              //       );
              //       controller.text = valorAtualInt.toString();
              //     }
              //   }
              // },
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
