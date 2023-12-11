import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MensagemWidget extends StatelessWidget {
  int nivel;
  String precoMaximo;
  String precoMinimo;
  String sifrao = 'RS';

  MensagemWidget(
    this.precoMaximo,
    this.precoMinimo,
    this.nivel, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double quantidadeValorDouble = double.tryParse(precoMaximo) ?? 0.0;

    // Crie uma instância de NumberFormat
    NumberFormat formatacao = NumberFormat("#,##0.00", "pt_BR");

    // Formate o valor
    precoMaximo = formatacao.format(quantidadeValorDouble);
    quantidadeValorDouble = double.tryParse(precoMinimo) ?? 0.0;
    precoMinimo = formatacao.format(quantidadeValorDouble);

    return Container(
      padding: EdgeInsets.fromLTRB(40, 5, 40, 10),
      child: Text(
        nivel == 0
            ? 'Este item é uma compra CASUAL!\nCompre a qualquer preço!'
            : nivel == 1
                ? 'O Estoque está em URGÊNCIA!\nPague até o Preço Máx.: $sifrao $precoMaximo!'
                : nivel == 2
                    ? 'O Estoque está em FALTA!\nCompre em promoção!\n*Abaixo de $sifrao $precoMinimo!'
                    : nivel == 3
                        ? 'O estoque está COMPLETO, não precisa comprar!'
                        : 'Aguardando cadastro do nome!',
        style: TextStyle(fontSize: 12),
        softWrap: true,
        textAlign: TextAlign.center,
      ),
    );
  }
}
