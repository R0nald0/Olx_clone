import 'package:firebase_auth/firebase_auth.dart';
import 'package:olx_clone/controller.dart';

class Usuario {
  late String _idUsuario;
  late String _nome;
  late String _senha;
  late String _email;

  Usuario();

  Map<String,dynamic> ToMap(){
    Map<String,dynamic> map={
      "idUsuario": this.idUsuario,
      "nome":      this.nome,
      "email":     this.email,
    };
    return map;
  }

 static verificarUsuarioLogado(){
    User? user = FirebaseBd.auth.currentUser;
    if(user != null){
      return true;
    }else{
      return false;
    }
  }



  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get idUsuario => _idUsuario;

  set idUsuario(String value) {
    _idUsuario = value;
  }
}