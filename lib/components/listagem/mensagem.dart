import 'package:flutter/material.dart';

class MensagemWidget extends StatelessWidget {
  MensagemWidget(
    this.nivel, {
    super.key,
  });

  int nivel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(40, 5, 40, 10),
      child: Text(
        nivel == 0
            ? 'Este item é uma compra CASUAL, compre a qualquer preço!'
            : nivel == 1
                ? 'O estoque está em URGÊNCIA, compre a qualquer preço!'
                : nivel == 2
                    ? 'O estoque está em FALTA, compre em promoção!'
                    : nivel == 3
                        ? 'O estoque está COMPLETO, não precisa comprar!'
                        : 'NIVEL ERRADO',
        style: TextStyle(fontSize: 12),
        softWrap: true,
        textAlign: TextAlign.center,
      ),
    );
  }
}
