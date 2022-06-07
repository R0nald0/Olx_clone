import 'package:flutter/material.dart';
import 'package:olx_clone/Rotas.dart';
import 'package:olx_clone/models/Usuario.dart';

import '../controller.dart';

class Anuncios extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => AnunciosState();
  
}


class AnunciosState extends State<Anuncios>{
  final corPadrao = Color(0xff9c27b0);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: corPadrao

              ),
                child:Column(
                  children: <Widget>[
                    Center(child: Image.asset("imagens/logo.png",width: 80,height: 80,),),
                    Text("OLX"),
                    Text("OLX")
                  ],
                )
            ),
             Expanded(child:  listMenu(),)
           ],
         )
      ),
      appBar: AppBar(
        title:Text("OLX"),
        backgroundColor: corPadrao,
      ),

      
    );
  }

  listMenu(){
   return  ListView(
         children: [
           ListTile(
             title: Usuario.verificarUsuarioLogado()
                  ?Text("Sair")
                  :Text("Logar"),
             onTap: (){
               Usuario.verificarUsuarioLogado()
                   ?deslogarUsuario()
                   :  Navigator.pushNamed((context),Rotas.ROTAS_LOGIN);
             },
           ),
           ListTile(
             title:  Usuario.verificarUsuarioLogado()
                 ?Text("Meu Perfil")
                 : Text("Cadastrar"),
             onTap: (){
               Navigator.pop(context);
               Navigator.pushNamed((context), Rotas.ROTAS_CADASTRAR);
             },
           ),
           ListTile(
             title: Text("Meus Anúncios"),
             onTap: (){
               Navigator.pop(context);

               Usuario.verificarUsuarioLogado()
                 ?Navigator.pushNamed(context, Rotas.ROTAS_USER_ANUNCIOS)
                 :Navigator.pushNamed((context), Rotas.ROTAS_LOGIN);
             },
           ),

           ListTile(
             title: Text("Configuraçoes",),
             onTap: (){
               Navigator.pop(context);
               Navigator.pushNamed((context), Rotas.ROTAS_CADASTRAR);
             },
           ),

         ],
       );
  }

  deslogarUsuario(){
    FirebaseBd.auth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, Rotas.ROTAS_ANUNCIOS, (route) => false);
  }



}