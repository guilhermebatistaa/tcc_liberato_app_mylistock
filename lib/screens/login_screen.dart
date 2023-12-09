import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/Models/Login.dart';
import 'package:my_app/screens/initial_screen.dart';
import 'package:my_app/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _mailImputController = TextEditingController();
  TextEditingController _passwordImputController = TextEditingController();

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
                  'Login',
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
                      _doLogin();

                      //validar no banco

                      //if (validado banco) {}

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (contextNew) => InitialScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Entrar',
                    ),
                  ),
                ),
                Divider(),
                Text(
                  'Sem cadastro?',
                  textAlign: TextAlign.center,
                ),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (contextNew) => SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Cadastrar',
                    ),
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

  void _doLogin() async {
    String mailForm = this._mailImputController.text;
    String passwordForm = this._passwordImputController.text;

    Login loginUser = await _getSavedLogin();
    print(loginUser);
  }

  Future<Login> _getSavedLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonLogin = prefs.getString("LOGGIN_USER_INFOS");

    Map<String, dynamic> mapLogin = json.decode(jsonLogin!);

    Login login = Login.fromJson(mapLogin);

    return login;
  }
}
