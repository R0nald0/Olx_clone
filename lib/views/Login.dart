import 'package:flutter/material.dart';
import 'package:olx_clone/Rotas.dart';
import 'package:olx_clone/componets/BotaoInputPersonalisado.dart';
import 'package:olx_clone/componets/ValidarUsuario.dart';
import 'package:olx_clone/controller.dart';

import '../models/Usuario.dart';

class Login extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
  final corPadrao = Color(0xff9c27b0);
  TextEditingController _editingControllerEmail =
      TextEditingController(text: "miau@gmail.com");
  TextEditingController _editingControllerSenha = TextEditingController();
  String msg =" ";

  validarCamp(){

    String email = _editingControllerEmail.text;
    String senha = _editingControllerSenha.text;

      if(email.isNotEmpty && email.contains("@")){
        if(senha.isNotEmpty && senha.length >= 4){

          Usuario usuario =Usuario();
          usuario.email = email;
          usuario.senha = senha;

          logarUsuario(usuario);

        } else{
          setState(() {
            msg= "Verifique a Senha Digitada - Senha => 6 ?";
            snac(msg);
          });
        }
      }else{
        setState(() {
          msg= "Verifique o email Digitado";
          snac(msg);
        });
      }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: corPadrao),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 80, bottom: 32),
                child: Image.asset(
                  "imagens/logo.png",
                  height: 150,
                  width: 150,
                ),
              ),
              BotaoInputPersonalizado(
                _editingControllerEmail,
                corPadrao,
                "Email",
                "Seu@Email.com",
                Icon(Icons.person),
                textInputType: TextInputType.name,
              ),
              SizedBox(height: 20),
              BotaoInputPersonalizado(
                _editingControllerSenha,
                corPadrao,
                "Senha",
                "Digite sua senha",
                Icon(Icons.password_rounded, color: Colors.black87),
                isPassword: true,
              ),
              SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () {validarCamp();},
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    primary: corPadrao,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18))),
                    child: Text("Login",style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 20,),
              TextButton(
                onPressed: () {
                   Navigator.pushNamed(context, Rotas.ROTAS_CADASTRAR);
                },
                child: Text(
                  "Cadastre-se",
                  style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }

  snac(String texto){

    final snack = SnackBar(
      content: Text(texto),
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  void logarUsuario(Usuario usuario) {
     FirebaseBd.auth.signInWithEmailAndPassword(
         email: usuario.email,
         password: usuario.senha
     ).then((value) {
            Navigator.pushNamedAndRemoveUntil((context), Rotas.ROTAS_ANUNCIOS, (route) => false);
     });

  }
}
