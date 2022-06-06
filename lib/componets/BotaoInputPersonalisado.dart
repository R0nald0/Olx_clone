import 'package:flutter/material.dart';

class BotaoInputPersonalizado extends StatelessWidget{

   final Color corPadrao;
   final String labelText;
   final String hintText;
   final Icon icone ;
   late final bool isPassword;
   late final TextEditingController controller;
   late final TextInputType textInputType;


   BotaoInputPersonalizado(
        @required this.controller,
        this.corPadrao,
        this.labelText,
        @required this.hintText,
        this.icone,
       {this.isPassword = false,this.textInputType = TextInputType.text}
       );

  @override
  Widget build(BuildContext context) {
    return TextField(
        keyboardType: textInputType,
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          labelText: labelText,
          hintText:   hintText,
          contentPadding: EdgeInsets.fromLTRB(8, 16, 8 , 16),
          focusColor: corPadrao,
          prefixIcon: icone

        )
    );

  }

}