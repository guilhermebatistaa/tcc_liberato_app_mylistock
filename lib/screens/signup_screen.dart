import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/Models/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _nameImputController = TextEditingController();
  TextEditingController _mailImputController = TextEditingController();
  TextEditingController _passwordImputController = TextEditingController();
  TextEditingController _confirmImputController = TextEditingController();

  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue, Colors.red])),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/comida.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Cadastro',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple, // Cor roxa
                  ),
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameImputController,
                        autofocus: true,
                        decoration: InputDecoration(
                            labelText: "Nome", prefixIcon: Icon(Icons.person)),
                      ),
                      TextFormField(
                        controller: _mailImputController,
                        autofocus: true,
                        decoration: InputDecoration(
                            labelText: "E-mail",
                            prefixIcon: Icon(Icons.mail_outline)),
                      ),
                      TextFormField(
                        controller: _passwordImputController,
                        autofocus: true,
                        decoration: InputDecoration(
                            labelText: "Senha",
                            prefixIcon: Icon(Icons.vpn_key)),
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () async {
                      _doSignUp();
                      //validar no banco
                      //SalvarUsuario();
                      //Voltar para o Login
                      //notificar na barra o cadastro feito
                    },
                    child: Icon(Icons.save),
                  ),
                ),
                Divider(),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 200, 200, 200),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _doSignUp() {
    Login newLogin = Login(
        name: _nameImputController.text,
        mail: _mailImputController.text,
        password: _passwordImputController.text);

    print(newLogin);

    _saveLogin(newLogin);
  }

  void _saveLogin(Login login) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      "LOGGIN_USER_INFOS",
      json.encode(login.toJson()),
    );
  }
}
