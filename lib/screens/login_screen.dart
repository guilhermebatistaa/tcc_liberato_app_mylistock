import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/Models/Constants.dart';
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

  bool _obscurePassword = true;

  final _formKey = GlobalKey<FormState>();

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
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple, // Cor roxa
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.length < 5) {
                            return "E-mail curto demais";
                          } else if (!value.contains("@")) {
                            return "E-mail sem @";
                          }
                          return null;
                        },
                        controller: _mailImputController,
                        autofocus: true,
                        decoration: InputDecoration(
                            labelText: "E-mail",
                            prefixIcon: Icon(Icons.mail_outline)),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.length < 6) {
                            return "Senha curta demais";
                          }
                          return null;
                        },
                        obscureText: _obscurePassword,
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
                Row(
                  children: [
                    Checkbox(
                      value: _obscurePassword,
                      onChanged: (newValue) {
                        setState(() {
                          _obscurePassword = newValue!;
                        });
                      },
                    ),
                    Text(
                      "Ocultar senha",
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.all(10)),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () async {
                      String resultado = await _doLogin();
                      if (resultado == "Login com sucesso!") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (contextNew) => InitialScreen(),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(resultado)),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(resultado)),
                        );
                      }
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

  Future<String> _doLogin() async {
    if (_formKey.currentState!.validate()) {
      String mailForm = this._mailImputController.text;
      String passwordForm = this._passwordImputController.text;

      Login savedLogin = await _getSavedLogin(mailForm);

      if (mailForm == savedLogin.mail && passwordForm == savedLogin.password) {
        return "Login com sucesso!";
      }

      return 'E-mail ou Senha incorreta!';
    } else {
      return 'Ajuste os campos!';
    }
  }

  Future<Login> _getSavedLogin(String mailForm) async {
    mailForm = mailForm.split('@').first;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonLogin = prefs.getString("LOGGIN_USER_INFOS$mailForm");

    Map<String, dynamic> mapLogin = json.decode(jsonLogin!);

    Login login = Login.fromJson(mapLogin);

    Constants.usuario = login.name!;

    return login;
  }
}
