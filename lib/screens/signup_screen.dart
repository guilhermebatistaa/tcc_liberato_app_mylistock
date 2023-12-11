import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/Models/Constants.dart';
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
                  'Cadastro',
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
                        controller: _nameImputController,
                        validator: (value) {
                          if (value!.length < 2) {
                            return "Nome curto demais";
                          }
                          return null;
                        },
                        autofocus: true,
                        decoration: InputDecoration(
                            labelText: "Nome", prefixIcon: Icon(Icons.person)),
                      ),
                      TextFormField(
                        controller: _mailImputController,
                        validator: (value) {
                          if (value!.length < 5) {
                            return "E-mail curto demais";
                          } else if (!value.contains("@")) {
                            return "E-mail sem @";
                          }
                          return null;
                        },
                        autofocus: true,
                        decoration: InputDecoration(
                            labelText: "E-mail",
                            prefixIcon: Icon(Icons.mail_outline)),
                      ),
                      TextFormField(
                        controller: _passwordImputController,
                        validator: (value) {
                          if (value!.length < 6) {
                            return "Senha curta demais";
                          }
                          return null;
                        },
                        obscureText: _obscurePassword,
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
                      if (await _doSignUp()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Usuário cadastrado!')),
                        );
                        Navigator.pop(context);
                      } else {
                        print("deu ruim");
                      }
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

  Future<bool> _doSignUp() async {
    if (_formKey.currentState!.validate()) {
      Login newLogin = Login(
          name: _nameImputController.text,
          mail: _mailImputController.text,
          password: _passwordImputController.text);

      print(newLogin);

      _saveLogin(newLogin);

      return true;
    } else {
      return false;
    }
  }

  void _saveLogin(Login login) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Constants.usuario = login.mail!.split('@').first;
    prefs.setString(
      "LOGGIN_USER_INFOS${Constants.usuario}",
      json.encode(login.toJson()),
    );
  }
}
