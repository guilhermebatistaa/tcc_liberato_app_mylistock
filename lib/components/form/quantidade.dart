import 'package:flutter/material.dart';

class criarCampoQuantidade extends StatelessWidget {
  double largura;
  TextEditingController controller;

  criarCampoQuantidade(this.largura, this.controller, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: largura,
      child: Expanded(
        child: TextFormField(
          controller: controller,
          //validator, controller
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              fillColor: Colors.white70,
              filled: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 5)),
        ),
      ),
    );
  }
}
