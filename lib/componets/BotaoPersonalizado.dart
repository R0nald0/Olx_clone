import 'package:flutter/material.dart';

class BotaoPersonalizado extends StatelessWidget{
  late final Widget textoBtn ;
   late final Color corTextoPadrao;
   late final Color corPadrao;
   late final VoidCallback onPressed;


   BotaoPersonalizado(
       {required this.textoBtn, this.corTextoPadrao = Colors.white,
        required this.onPressed,
         required this.corPadrao ,
       }
  );


  @override
  Widget build(BuildContext context) => ElevatedButton(
    onPressed: this.onPressed,
    style: ElevatedButton.styleFrom(
        padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
        primary: this.corPadrao,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18))),
    child: this.textoBtn
  );
}