import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/Rotas.dart';
import 'package:olx_clone/componets/ItemAnucio.dart';
import 'package:olx_clone/componets/ListDropdown.dart';
import 'package:olx_clone/models/Anuncio.dart';
import 'package:olx_clone/models/Usuario.dart';
import 'package:olx_clone/util/Configuracoes.dart';
import 'package:olx_clone/views/DetalhesAnuncios.dart';


import '../controller.dart';

class Anuncios extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => AnunciosState();
  
}

class AnunciosState extends State<Anuncios>{
  final corPadrao = Color(0xff9c27b0);
  List<DropdownMenuItem<String>> listaRegiao=[];
  List<DropdownMenuItem<String>> listaCategoria=[];

  StreamController _controller = StreamController<QuerySnapshot>.broadcast();

  String valorInitRegiao ="Região";
  String valorInitCategoria ="Categoria";

  Future<Stream<QuerySnapshot>> filtrarAnuccio() async{

    Query query =  await FirebaseBd.db.collection("anuncio");

     if(valorInitRegiao != "Região"){
       query = query.where("estado" ,isEqualTo: valorInitRegiao);
     }
    if(valorInitCategoria != "Categoria"){
      query = query.where("categoria" ,isEqualTo: valorInitCategoria);
    }


    Stream<QuerySnapshot> stream = query.snapshots();
    stream.listen((dados) {
      _controller.add(dados);
    });

    return stream;

  }
 Future<Stream<QuerySnapshot>> getListListener() async{

     Stream<QuerySnapshot> stream = await FirebaseBd.db.collection("anuncio").snapshots();

     stream.listen((dados) {
         _controller.add(dados);
     });

     return stream;
 }

  getLists(){
    listaRegiao =Configuracoes.getListState();
    listaCategoria=Configuracoes.getListCategory();
  }
 @override
  void initState() {
    super.initState();
    getLists();
    getListListener();
  }
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
      body: Container(
        child:Column(
          children: <Widget>[
            Row(
              children: <Widget> [
                Expanded(
                    child: Center(
                      child: ListDropdown(
                        valorInicial: valorInitRegiao,
                        listDados: listaRegiao,
                        onChanged: (value) {
                          setState(() {
                            valorInitRegiao = value.toString();
                            print("regiao" + valorInitRegiao);
                            filtrarAnuccio();
                          });
                        },
                      ),
                    )

                ),
                Expanded(
                    child:Center(
                     child: ListDropdown(
                         valorInicial: valorInitCategoria,
                         listDados: listaCategoria,
                         onChanged: (value) {
                           setState(() {
                             valorInitCategoria = value.toString();
                             filtrarAnuccio();
                           });
                         },
                         )
                    ),
                )
            ],
            ),
            StreamBuilder(
                stream:  _controller.stream,
                builder: (context,AsyncSnapshot snapshot){
                  switch(snapshot.connectionState){

                   case ConnectionState.none:
                   case ConnectionState.waiting:
                     return Center(
                       child: CircularProgressIndicator(
                         backgroundColor: corPadrao,),
                     );
                     break;
                   case ConnectionState.active:
                   case ConnectionState.done:

                    QuerySnapshot query = snapshot.data;

                      if(query.docs.length == 0){
                        return Container(
                          padding: EdgeInsets.all(100),
                          child:  Center(
                              child: Text("Lista Vazia!!!!",style: TextStyle(fontSize: 22,color: Colors.red),)
                          )
                        );
                      }
                      return listAnuncio(query);
                 }
            }
            )
          ],
        ),
      ),

    );
  }


  listAnuncio(QuerySnapshot query){
     return Expanded(
         child: ListView.builder(
             itemCount: query.docs.length ,
             itemBuilder:(context,index){
                List<DocumentSnapshot> anuncioList = query.docs.toList();
                 DocumentSnapshot anuncioDoc = anuncioList[index];
                 Anuncio anuncio = Anuncio.fromDocumentSnapshot(anuncioDoc);
               return ItemAnuncio(
                   anuncio,
                  onTap: (){
                     Navigator.pushNamed(context, Rotas.ROTAS_DETALHES_ANUNCIO,arguments: anuncio);
                  },
               );
             }
         )
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

@override
  void dispose() {
    _controller.close();
    super.dispose();
  }

}