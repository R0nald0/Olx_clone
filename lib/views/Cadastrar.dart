import 'package:flutter/material.dart';
import 'package:olx_clone/controller.dart';
import 'package:olx_clone/models/Usuario.dart';

import '../Rotas.dart';
import '../componets/BotaoInputPersonalisado.dart';

class Cadastrar extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>CadastrarState();

}

class CadastrarState extends State<Cadastrar> {
  final corPadrao = Color(0xff9c27b0);
  TextEditingController _editingControllerSenha = TextEditingController();
  TextEditingController _editingControllerNome = TextEditingController();
  TextEditingController _editingControllerEmail = TextEditingController();

  String msgErro = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: corPadrao,title: Text("Cadastrar"),),
      body:  Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
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
                    _editingControllerNome,
                    corPadrao,
                    "Seu Nome",
                    "Nome",
                    Icon(Icons.person),
                    textInputType: TextInputType.name,
                  ),
                  SizedBox(height: 20,),
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
                    Icon(Icons.password_rounded, color:Colors.black),
                    isPassword: true,
                  ),
                  SizedBox(height: 30,),
                  ElevatedButton(
                    onPressed: () {
                      validarCampos();
                      snac(msgErro);
                    },
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        primary: corPadrao,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18))),
                    child: Text(
                      "Cadastrar",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              )
          ),
        )
      )
    );
  }
  snac(String erro){
    final snack =SnackBar(
      content: Text(erro),
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
   cadastrarUsuario(Usuario usuario){
    FirebaseBd.auth.createUserWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((value){
      Navigator.pushNamedAndRemoveUntil((context), Rotas.ROTAS_ANUNCIOS, (route) => false);
    });
  }

  validarCampos(){
    String nome = _editingControllerNome.text;
    String email = _editingControllerEmail.text;
    String senha = _editingControllerSenha.text;

    if(nome.isNotEmpty && nome.length > 4 ){
      if(email.isNotEmpty && email.contains("@")){
        if(senha.isNotEmpty && senha.length >= 4){

            Usuario usuario =Usuario();
            usuario.nome = nome;
            usuario.email = email;
            usuario.senha = senha;

            cadastrarUsuario(usuario);
            FirebaseBd.db.collection("usuario").add(usuario.ToMap());

        } else{
          setState(() {
            msgErro= "Verifique a Senha Digitada - Senha => 6 ?";
            print("senha" + senha.length.toString());
          });
        }
      }else{
        setState(() {
          msgErro= "Verifique o email Digitado";
        });
      }
    }else{
      setState(() {
        msgErro= "Verifique o nome Digitado";
      });
    }
  }

}