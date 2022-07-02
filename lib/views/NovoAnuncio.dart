import 'dart:async';
import 'dart:io';


import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:olx_clone/Rotas.dart';
import 'package:olx_clone/componets/BotaoPersonalizado.dart';
import 'package:olx_clone/componets/CampoTextFormPersonalizad.dart';
import 'package:olx_clone/componets/InputPersonalisado.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olx_clone/controller.dart';
import 'package:olx_clone/models/Anuncio.dart';
import 'package:olx_clone/models/Categoria.dart';
import 'package:olx_clone/util/Configuracoes.dart';
import 'package:validadores/Validador.dart';

import '../componets/AlertDialogCostomizada.dart';

class NovoAnuncio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NovoAnuncioState();
}

class NovoAnuncioState extends State<NovoAnuncio> {

  TextEditingController _tituloAnuncioController = TextEditingController();
  TextEditingController _valorController = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();

  final ImagePicker _picker =ImagePicker();
  late final XFile image ;
  final corPadrao = Color(0xff9c27b0);

  final _keyForm = GlobalKey<FormState>();
  List<XFile> listImagens = [];
List<DropdownMenuItem<String>> listEstados = [];
  List<DropdownMenuItem<String>> listCategorias = [];
  //String itemEstado = "Bahia";
  String itemCategoria = "Veículos";
  late BuildContext _diologContext;
  late Anuncio anuncio ;


   limparCampos(){
     _tituloAnuncioController.clear();
     _valorController.clear();
     _telefoneController.clear();
     _descricaoController.clear();
     listImagens.clear();
   }


   _getUrlImg(TaskSnapshot task) async{
       String url = await task.ref.getDownloadURL();
       anuncio.imagen.add(url);
       print("urlfoto" + url);
   }
   _salvarImagens() async {
      _diologCarregando();
      String  nome_imagem = DateTime.now().millisecondsSinceEpoch.toString();

      for(var imagens in listImagens){
        final imgRef = FirebaseBd.storage.ref()
              .child("meus_anuncios").child(anuncio.id).child(nome_imagem);
        try{
          final task =  imgRef.putFile(File(imagens.path));
             task.snapshotEvents.listen((snapshot) async {
                if(snapshot.state == TaskState.success) {
                  print("urlfoto" + snapshot.state.toString());
                  await _getUrlImg(snapshot);
                }
                _salvarAnuncios();
             });

        }on FirebaseException catch (erro){
            print("imagen" + erro.message.toString());
        }
      }
   }
   _salvarAnuncios() async{

     User? user = await FirebaseBd.auth.currentUser;
       FirebaseBd.db.collection("meus_anuncios")
           .doc(user?.uid.toString()).collection("anuncio")
           .doc(anuncio.id).set(anuncio.toMap()
       ).then((_){
          FirebaseBd.db.collection("anuncio").doc(anuncio.id)
              .set(anuncio.toMap())
              .then((_){
            Navigator.pop(_diologContext);
          });
       });

   }

  _getLists(){
      listEstados = Configuracoes.getListState();
      listCategorias = Configuracoes.getListCategory();
  }

 @override
  void initState() {
    super.initState();
    _getLists();
    anuncio = Anuncio.gerarId();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo Anúncio"),
        backgroundColor: corPadrao,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _keyForm,
            child: Column(

              children: <Widget>[
                FormField<List>(
                  initialValue: listImagens,
                  validator: (imagens) {
                    if (imagens?.length == 0) {
                      return " Adcionar imagens";
                    }
                    return null;
                  },
                  builder: (state) {
                    return Column(
                      children: <Widget>[
                        Container(
                          height: 100,
                          child: ListView.builder(
                              itemCount: listImagens.length + 1,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                if (index == listImagens.length) {
                                  return _addBotaoImagens();
                                }

                                if (listImagens.length > 0) {
                                  return Padding(padding: EdgeInsets.symmetric(horizontal: 8),
                                    child: GestureDetector(
                                      onTap: (){
                                         _dialogExcluirImg(index);
                                      },
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundImage:FileImage(File(listImagens[index].path)),
                                        child: Container(
                                          alignment: Alignment.bottomRight,
                                          child: Icon(Icons.delete,color: Colors.red,),
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                return Container();
                              }),
                        ),
                        state.hasError
                            ? Container(
                                child: Text(
                                "${[state.errorText]}",
                                style: TextStyle(color: Colors.red),
                              ))
                            : Container()
                      ],
                    );
                  },
                ),
                Padding(padding: EdgeInsets.only(top: 15,bottom: 15, ),
                    child: _criarListDropDawn()),
                CampoTextFormPersonalizad(
                    _tituloAnuncioController,
                      (valor){return Validador().add(
                            Validar.OBRIGATORIO,msg:"Campo Obrigatório").validar(valor!);
                      },
                    corPadrao,
                    "Titulo",
                   onSaved:(titulo){
                        anuncio.titulo =titulo!;
                   } ,
                ),
                Padding(padding: EdgeInsets.only(top: 15,bottom: 15),
                  child: CampoTextFormPersonalizad(
                    _valorController,
                        (valor){return Validador().add(
                        Validar.OBRIGATORIO,msg:"Campo Obrigatório").validar(valor!);
                    },
                    corPadrao,
                    "Valor R\$",
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RealInputFormatter(moeda: true)
                    ],
                    textInputType: TextInputType.number,
                    onSaved:(valor){
                       setState(() {
                         anuncio.preco = valor!;
                       });

                    } ,
                   ),
                ),
                CampoTextFormPersonalizad(_telefoneController,
                    (valor){
                      return Validador().add(Validar.OBRIGATORIO,msg:"Campo Obrigátorio").validar(valor);
                      },
                    corPadrao,
                    "Telefone",
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly,
                       TelefoneInputFormatter()
                   ],
                  textInputType: TextInputType.number,
                  onSaved:(telefone){
                     anuncio.telefone= telefone!;
                  } ,
                ),
                Padding(padding: EdgeInsets.only(top: 15,bottom: 15),
                  child: CampoTextFormPersonalizad(
                     _descricaoController,
                        (valor){return Validador().add(
                        Validar.OBRIGATORIO,msg:"Campo Obrigatório")
                        .maxLength(200)
                            .validar(valor!);
                    },
                    corPadrao,
                    "Descrição",
                    hintText: "Descricao 200 caracteres  ",
                    maxLines: 2,
                    onSaved:(descricao){
                       anuncio.descricao = descricao!;
                    } ,
                  ),
                ),
                BotaoPersonalizado(
                      onPressed:  () {
                        if (_keyForm.currentState!.validate()) {
                          _keyForm.currentState?.save();
                          _diologContext = context;
                          _salvarImagens();
                        }
                      }
                     , corPadrao:corPadrao,
                    textoBtn:Text("Cadastrar Anúncio ",style: TextStyle(fontSize: 20)
                 ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void selecionarImagem() async{
     final XFile? img =  await _picker.pickImage(source: ImageSource.gallery);

      if(img != null){
         setState(() {
            listImagens.add(img);
         });
      }
  }
   _diologCarregando() async{
     return showDialog(
         barrierDismissible: false,
         context: _diologContext,
         builder: (_diologContext)=>AlertDialog(
            content: Column( mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(height: 20,),
                Text("Salvando dados...")
              ],
            ),
         )
     );

   }
  _addBotaoImagens() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),

      child: GestureDetector(
        onTap: () {selecionarImagem();},
        child: CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.add_a_photo, color: Colors.grey[400], size: 30),
              Text("Adicionar", style: TextStyle(color: Colors.grey[400]))
            ],
          ),
        ),
      ),
    );
  }
  _dialogExcluirImg(index){
    return showDialog(
        context: context, builder: (context)=>
      AlertDialogCostomizado(
          content:SingleChildScrollView(
             child: Column( mainAxisSize: MainAxisSize.min,mainAxisAlignment: MainAxisAlignment.center,
              children: [ Image.file(File(listImagens[index].path)),],
              )
             ),
        actions: [
          Center(
            child:  BotaoPersonalizado(
                onPressed:(){
                setState(() {
                  listImagens.removeAt(index);
                  Navigator.of(context).pop();
                });
              },
               corPadrao: Colors.transparent,
              textoBtn: Text("Excluir", style: TextStyle(fontSize: 20,color: corPadrao,backgroundColor:Colors.transparent),
              ),
              corTextoPadrao: Colors.white,
            ),
          )
      ],
          ),
      );


  }
  _criarListDropDawn(){

    String itemEstado = "Bahia";
    String itemCategoria = "Veículos";

    return Row(children: <Widget>[
      Expanded(
          child:DropdownButtonFormField(
            icon: Icon(Icons.keyboard_arrow_down),
            hint: Text("Estados"),
            items: listEstados,
            validator: (Object? value){
                  if(value == null){
                       return "Campo Obrigatorio";
                  }
                  return null;
            },
            onSaved:(estado){
              anuncio.estado = estado.toString();
            } ,
            onChanged: (value) {
              setState(() {
                itemEstado = value.toString();
              });
            },
          )
      ),
      SizedBox(width: 10),

      Expanded(
          child:DropdownButtonFormField(
            hint: Text("Categorias"),
            icon: Icon(Icons.keyboard_arrow_down),
            items: listCategorias,
            validator: (value){
                 if(value == null){
                    return "Campo Obrigatorio";
                 }
              return null;
            },
            onSaved:(categoria){
                 anuncio.categoria = categoria.toString();
            } ,
            onChanged: (Object? value) {
               setState(() {
                  itemCategoria = value.toString();
               });
            },
          )
      ),
    ],
    );
  }
}


