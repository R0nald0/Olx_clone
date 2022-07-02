import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:olx_clone/controller.dart';

class Anuncio{
  late String _id;
  late String _titulo;
  late String _estado;
  late String _categoria;
  late String _preco;
  late String _descricao;
  late String _telefone;
  late List<String> _imagen;

  Anuncio(){}

  Anuncio.gerarId(){
     this.id = FirebaseBd.db.collection("Anuncio").doc().id;
     print("imagen " + this.id);
     this.imagen = [];
  }

  Anuncio.fromDocumentSnapshot( DocumentSnapshot documentSnapshot){
       this._titulo = documentSnapshot['titulo'];
       this.preco   =documentSnapshot['valor'];
       this.categoria = documentSnapshot['categoria'];
       this.estado = documentSnapshot['estado'];
       this._telefone = documentSnapshot['telefone'];
       this._id = documentSnapshot['id_anuncio'];
       this._descricao =documentSnapshot['descricao'];
       this.imagen = List<String>.from(documentSnapshot['url_fotos']);
  }





  Map<String,dynamic> toMap(){
    Map<String,dynamic> anuncioMap= {
      "valor"   : this.preco,
      "titulo" : this.titulo,
      "descricao" : this.descricao,
      "estado" :   this.estado,
      "url_fotos" : this.imagen,
      "categoria" :this.categoria,
      "id_anuncio" : this.id,
      "telefone" :this.telefone
    };
    return anuncioMap;
  }

   String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get titulo => _titulo;

  set titulo(String value) {
    _titulo = value;
  }

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }

  String get estado => _estado;

  set estado(String value) {
    _estado = value;
  }

  String get categoria => _categoria;

  set categoria(String value) {
    _categoria = value;
  }

  String get preco => _preco;

  set preco(String value) {
    _preco = value;
  }

  List<String> get imagen => _imagen;

  set imagen(List<String> value) {
    _imagen = value;
  }

  String get telefone => _telefone;

  set telefone(String value) {
    _telefone = value;
  }
}