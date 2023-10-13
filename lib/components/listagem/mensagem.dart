import 'package:flutter/material.dart';

class CriarMensagem extends StatelessWidget {
  const CriarMensagem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(40, 5, 40, 10),
      child: Text(
        'Texto de Text Texto de Text Texto de Text Texto de Text Texto de Text Texto de Text',
        style: TextStyle(fontSize: 12),
        softWrap: true,
        textAlign: TextAlign.center,
      ),
    );
  }
}
