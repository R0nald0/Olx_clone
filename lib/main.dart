import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/Rotas.dart';
import 'package:olx_clone/views/Login.dart';
import 'package:olx_clone/views/SplashScreen.dart';

void main(){

  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();


  runApp(MaterialApp(
     home: SplashScreen(),
    initialRoute: Rotas.ROTAS_SPLASHSCREEN,
    onGenerateRoute:Rotas.routeConfig

  ));
}