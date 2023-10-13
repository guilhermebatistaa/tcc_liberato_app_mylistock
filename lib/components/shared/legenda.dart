import 'package:flutter/material.dart';

class CriarLegenda extends StatelessWidget {
  double valorLargura;
  String texto;

  CriarLegenda(this.valorLargura, this.texto,{
    super.key,s
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: valorLargura,
      child: Text(
        texto,
        style: TextStyle(fontSize: 12),
        softWrap: true,
      ),
    );
  }
}
