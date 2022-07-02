import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:olx_clone/Rotas.dart';
import 'package:olx_clone/componets/BotaoPersonalizado.dart';
import 'package:olx_clone/componets/InputPersonalisado.dart';
import 'package:olx_clone/componets/CampoTextFormPersonalizad.dart';
import 'package:olx_clone/componets/ValidarUsuario.dart';
import 'package:olx_clone/controller.dart';
import 'package:validadores/Validador.dart';

import '../models/Usuario.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
  final corPadrao = Color(0xff9c27b0);
  final _formKey =GlobalKey<FormState>();
  TextEditingController _editingControllerEmail = TextEditingController();
  TextEditingController _editingControllerSenha = TextEditingController();
  String msg = " ";

  _validarCamp() {
    String email = _editingControllerEmail.text;
    String senha = _editingControllerSenha.text;
    Usuario usuario = Usuario();
    usuario.email = email;
    usuario.senha = senha;
    logarUsuario(usuario);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: corPadrao),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Center(
              child: Form(
                key: _formKey,
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
                  CampoTextFormPersonalizad(
                      _editingControllerEmail,
                      (valor){return ValidarUsuario.validarQtdCaracter(valor!);},
                      corPadrao,
                      "Email",
                     hintText: "meu@email.com",
                      icone: Icon(Icons.email,color: corPadrao,),
                     textInputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                 CampoTextFormPersonalizad(
                   _editingControllerSenha,
                       (valor){return ValidarUsuario.validarSenha(valor!);},
                   corPadrao,
                   "Senha",
                   isPassword: true,
                   textInputType: TextInputType.text,
                   icone: Icon(Icons.password,color: corPadrao,),
                 ),
                  SizedBox(
                    height: 30,
                  ),
                  BotaoPersonalizado(
                    textoBtn: Text(" Login",style: TextStyle(fontSize: 20)), corPadrao: corPadrao,
                    onPressed: (){if(_formKey.currentState!.validate()){
                      _validarCamp();
                    }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Rotas.ROTAS_CADASTRAR);
                    },
                    child: Text(
                      "Cadastre-se",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              )
          ),
        ),
      ),
    );
  }

  snac(String texto) {
    final snack = SnackBar(
      content: Text(texto),
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  void logarUsuario(Usuario usuario) {
    print("campos " + usuario.email +" " + usuario.senha);
    FirebaseBd.auth
        .signInWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then((value) {
      Navigator.pushNamedAndRemoveUntil(
          (context), Rotas.ROTAS_ANUNCIOS, (route) => false);
    }).catchError((erro){
      setState(() {
         msg ="Email ou Senha Incorretos" ;
      });
      snac(msg);
    });
  }
}


/*

              TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _editingControllerEmail,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                    labelText: "email",
                    hintText: "email",
                    contentPadding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                    focusColor: corPadrao,
                  ),
                  validator: (String? value){
                     ValidarUsuario.validarQtdCaracter(value!);
                  }
              ),


 */