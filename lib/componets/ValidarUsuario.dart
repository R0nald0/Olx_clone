import 'package:flutter/cupertino.dart';

class ValidarUsuario{


 static String validarUsuario({String nome =" ",required String email,required String senhas}){

       if(senhas.isNotEmpty && senhas.length >= 4){
         return " logando ";

       }else{
         return " erro na senha";
       }

    }

}