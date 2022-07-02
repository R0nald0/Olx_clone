import 'package:flutter/cupertino.dart';
import 'package:validadores/Validador.dart';

class ValidarUsuario {

  static String? validarQtdCaracter(String texto){
     return Validador()
         .add(Validar.OBRIGATORIO,msg: "Campo Obrigatório")
         .add(Validar.EMAIL,msg: "Insira um email Valido")
         .valido(texto);
   }
  static String? validarSenha(String texto){
    return Validador()
        .add(Validar.OBRIGATORIO,msg: "Campo Obrigatório")
        .minLength(6,msg: "Minino de 6 Caractéres")
        .maxLength(12,msg: "Máximo de 12 Caracteres")
        .valido(texto);
  }

  static String? validarNome(String texto){
    return Validador()
        .add(Validar.OBRIGATORIO,msg: "Campo Obrigatório")
        .minLength(6,msg: "Minino de 6 Caractéres")
        .maxLength(12,msg: "Máximo de 12 Caracteres")
        .valido(texto);
  }
}