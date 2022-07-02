import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/componets/BotaoPersonalizado.dart';
import 'package:olx_clone/views/Anuncios.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../models/Anuncio.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class DetalhesAnuncios extends StatefulWidget {
  Anuncio _anuncio;
  DetalhesAnuncios(this._anuncio);

  @override
  State<StatefulWidget> createState() => DetalhesAnunciosState();
}

class DetalhesAnunciosState extends State<DetalhesAnuncios> {
  late Anuncio _anuncio;
  final corPadrao = Color(0xff9c27b0);
  int indexAtaul = 0;
  List<String> listImg = [];

  @override
  void initState() {
    _anuncio = widget._anuncio;
    listImg = _anuncio.imagen;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: corPadrao,
            title: Text(
              _anuncio.titulo,
            )),
        body: Stack(
          children: [
            ListView(
              children: [
                SizedBox(
                    width: 500,
                    child: CarouselSlider.builder(
                        itemCount: listImg.length,
                        itemBuilder: (context, index, realIndex) {
                          final urlImagem = listImg[index];
                          print("url " + listImg[index].toString());
                          return buildImage(urlImagem, index);
                        },
                        options: CarouselOptions(
                            height: 300,
                            viewportFraction: 1,
                            enableInfiniteScroll: false,
                            pageSnapping: false,
                            onPageChanged: (index, reasao) {
                              return setState(() {
                                indexAtaul = index;
                              });
                            }))),
                  Center(child:
                     SizedBox(
                    height: 32,
                    child: CriarIndicador(),
                     ),),


                 Container(
                      padding: EdgeInsets.all(16),
                        child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      _anuncio.preco,
                      style: TextStyle(
                          fontSize: 24,
                          color: corPadrao,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _anuncio.titulo,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Divider(
                        height: 2,
                        color: corPadrao,
                      ),
                    ),
                    Text("Descrição",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text("en book. It has survived not only five ce"
                        "n book. It has survived not only five cen book. It has survived not only five cen book. It has survived not only five ce"
                        "",
                        style: TextStyle(
                          fontSize: 18,
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Divider(
                        height: 2,
                        color: corPadrao,
                      ),
                    ), Text("Contato",
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 65),
                    child: Text(_anuncio.telefone, style: TextStyle(fontSize: 17)),
                    )
                  ],
                )),
              ],
            ),
            Positioned(
              bottom: 16,
              left: 120,
              right:120,
              child: BotaoPersonalizado(
                onPressed: (){},
                corPadrao: Color.fromARGB( 500,247, 110, 19),
                textoBtn: Text("Chat",style: TextStyle(fontSize: 20),),
              ),)
          ],
        ),

        floatingActionButton: FloatingActionButton(
        onPressed: (){_chamarTelefone(_anuncio.telefone); print("tele " + _anuncio.telefone);},
          backgroundColor: corPadrao,
          child: Icon(Icons.phone),
    ),
    );
  }

  Widget buildImage(String urlImage, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        // color: Colors.grey,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(urlImage), fit: BoxFit.fitWidth)),
      );

  Widget CriarIndicador() => AnimatedSmoothIndicator(
        activeIndex: indexAtaul,
        count: listImg.length,
        effect: JumpingDotEffect(
          activeDotColor: corPadrao,
        ),
      );

  _chamarTelefone(String telefone) async{
 ;
     if( await launchUrlString("tel:$telefone")){
         await launchUrlString("$telefone");
     }
  }
}

/*

 */