
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:olx_clone/Rotas.dart';
import 'package:olx_clone/models/Usuario.dart';
import 'package:olx_clone/views/Login.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  @override
  void initState() {
    super.initState();

  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Timer(
        Duration(seconds: 5),(){
           Navigator.pushNamedAndRemoveUntil(context, Rotas.ROTAS_ANUNCIOS, (route) => false);

     }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff9c27b0),
      body: Center(
        child:Container(
                   width: 150,
                    height: 150,
                    child: Image.asset("imagens/logo.png")
                )
      ),
    );
  }

}

