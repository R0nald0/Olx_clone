import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/Rotas.dart';
import 'package:olx_clone/componets/AlertDialogCostomizada.dart';
import 'package:olx_clone/componets/ItemAnucio.dart';
import 'package:olx_clone/controller.dart';
import 'package:olx_clone/models/Anuncio.dart';


class UserAnuncios extends StatefulWidget{
  @override
  State<StatefulWidget> createState()  => UserAnunciosState();

}

class UserAnunciosState extends State<UserAnuncios> {
  final corPadrao = Color(0xff9c27b0);
  final StreamController _controller = StreamController<
      QuerySnapshot>.broadcast();

  Future<Stream<QuerySnapshot>> streamAddItens() async {
    User? user = await FirebaseBd.auth.currentUser;

    Stream<QuerySnapshot> stream = FirebaseBd.db
        .collection("meus_anuncios")
        .doc(user?.uid)
        .collection("anuncio")
        .snapshots();

    stream.listen((dados) {
      _controller.add(dados);
    });

    return stream;
  }

  @override
  void initState() {

    super.initState();
    streamAddItens();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Anúncios"),
        backgroundColor: corPadrao,
      ),
      body: StreamBuilder(
          stream: _controller.stream,
          builder: (context, AsyncSnapshot snap) {
            switch (snap.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: corPadrao,),
                );
                break;
              case ConnectionState.active:
              case ConnectionState.done:
                QuerySnapshot query = snap.data;
                if (snap.hasData) {
                  return listaAnuncios(query);
                }
                return Center(
                  child: Text("Erro ao carregar dados"),);
            }
            return Container();
          }
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: corPadrao,
        onPressed: () {
          Navigator.pushNamed(context, Rotas.ROTAS_NOVO_ANUNCIO);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  listaAnuncios(QuerySnapshot querySnapshot) {
    return ListView.builder(
        itemCount: querySnapshot.docs.length,
        itemBuilder: (context, index) {
          List<DocumentSnapshot> listAnucios = querySnapshot.docs.toList();
          DocumentSnapshot documentSnapshot = listAnucios[index];
          Anuncio anuncio = Anuncio.fromDocumentSnapshot(documentSnapshot);

          return ItemAnuncio(
            anuncio,
            onTap: () {},
            onPressedRemove: () {
                 showDialog(
                     context: context,
                     builder: (context)=> AlertDialogCostomizado(
                       content: Text("Deseja excluir o Anúcio ${anuncio.titulo}"),
                       actions: [
                         TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Cancelar")),
                         TextButton(onPressed: (){
                           removerAnuncios(anuncio.id);
                           Navigator.pop(context);
                         }, child: Text("Deletar",style:TextStyle(color: Colors.red),)),
                       ],
                     ),
                 );
            },);
        }
    );
  }
  void removerAnuncios(String idAnucios)  async{
     User? user = await FirebaseBd.auth.currentUser;

    FirebaseBd.db.collection("meus_anuncios")
        .doc(user?.uid.toString())
        .collection("anuncio")
        .doc(idAnucios).delete()
        .then((_){
          FirebaseBd.db.collection("anuncio").doc(idAnucios).delete();
    });
  }


  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }



}