import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/views/Anuncios.dart';
import 'package:olx_clone/views/Cadastrar.dart';
import 'package:olx_clone/views/Login.dart';
import 'package:olx_clone/views/SplashScreen.dart';
import 'package:olx_clone/views/UserAnuncios.dart';

class Rotas {
  static const ROTAS_LOGIN = "/Login";
  static const ROTAS_SPLASHSCREEN = "/SplashScreen";
  static const ROTAS_CADASTRAR = "/Cadastrar";
  static const ROTAS_ANUNCIOS = "/Anuncios";
  static const ROTAS_USER_ANUNCIOS = "/UserAnuncios";

  static Route<dynamic>? routeConfig(RouteSettings settings) {
    switch (settings.name) {

      case ROTAS_SPLASHSCREEN:
        return MaterialPageRoute(builder: (contex) => SplashScreen());
        break;

      case ROTAS_ANUNCIOS:
        return MaterialPageRoute(builder: (_) => Anuncios());
        break;
      case ROTAS_LOGIN:
        return MaterialPageRoute(builder: (context) => Login());
        break;
      case ROTAS_CADASTRAR:
        return MaterialPageRoute(builder: (context) => Cadastrar());
        break;

      case ROTAS_USER_ANUNCIOS:
        return MaterialPageRoute(builder: (_) => UserAnuncios());
        break;
    }
  }

  static errorRoute() {}
}
