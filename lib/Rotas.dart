

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/views/Anuncios.dart';
import 'package:olx_clone/views/Cadastrar.dart';
import 'package:olx_clone/views/DetalhesAnuncios.dart';
import 'package:olx_clone/views/Login.dart';
import 'package:olx_clone/views/NovoAnuncio.dart';
import 'package:olx_clone/views/SplashScreen.dart';
import 'package:olx_clone/views/UserAnuncios.dart';

class Rotas {
  static const ROTAS_LOGIN = "/Login";
  static const ROTAS_SPLASHSCREEN = "/SplashScreen";
  static const ROTAS_CADASTRAR = "/Cadastrar";
  static const ROTAS_ANUNCIOS = "/Anuncios";
  static const ROTAS_USER_ANUNCIOS = "/UserAnuncios";
  static const ROTAS_NOVO_ANUNCIO = "/NovoAnuncio";
  static const ROTAS_DETALHES_ANUNCIO = "/DetalhesAnuncio";
    static var arsg;

  static Route<dynamic>? routeConfig(RouteSettings settings) {

         arsg = settings.arguments;

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
      case ROTAS_NOVO_ANUNCIO:
        return MaterialPageRoute(builder:(context)=>NovoAnuncio());
      break;

      case ROTAS_DETALHES_ANUNCIO:
        return MaterialPageRoute(builder: (_)=>DetalhesAnuncios(arsg) );
      break;

      default : _erroRoute();
    }

  }

  static Route<dynamic>? _erroRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("TELA DE ERRO"),
        ),
        body: Center(
          child: Text("Erro de Rota"),
        ),
      );
    });
  }
}
