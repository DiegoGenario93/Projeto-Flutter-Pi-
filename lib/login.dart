import 'package:flutter/material.dart';
import 'servico.dart';
import 'database_helper.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void realizarLogin() {
      String login = loginController.text;
      String senha = senhaController.text;

      if (login == 'Manutenção' && senha == 'manute01') {
        // Navegar para a página Servico.dart
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ServicoPage()),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erro de autenticação'),
              content: Text('Login ou senha incorretos.'),
              actions: <Widget>[],
            );
          },
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey, // Cor de fundo preta
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8, // 80% da largura da tela
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white, // Cor de fundo branca
              borderRadius: BorderRadius.circular(10.0), // Borda arredondada
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Página de Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: loginController,
                  decoration: InputDecoration(
                    hintText: 'Digite seu login',
                    labelText: 'Login',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: senhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Digite sua senha',
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: realizarLogin,
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

