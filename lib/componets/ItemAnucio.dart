import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:olx_clone/models/Anuncio.dart';

class ItemAnuncio extends StatelessWidget{

   late Anuncio anuncio ;
   late  VoidCallback? onTap;
   final VoidCallback? onPressedRemove;


   ItemAnuncio( @required this.anuncio,
        {
           this.onTap = null,
           this.onPressedRemove =  null
          }){}
  @override
  Widget build(BuildContext context) {

      return GestureDetector(
        onTap: this.onTap,
          child: Card(
            child: Row(
              children: <Widget>[
                Container(
                   decoration: BoxDecoration(
                     image: DecorationImage(
                       image: NetworkImage(anuncio.imagen[0]),fit: BoxFit.cover
                     )
                   ),
                  height: 100,width: 100,
                ),

                   Expanded(
                    flex:3 ,
                    child:Padding(padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(anuncio.titulo,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          SizedBox(height: 10,),
                          Text("R\$ ${anuncio.preco}",style: TextStyle(fontSize: 14),),
                        ],
                      ),
                    )
                  ),

              if(this.onPressedRemove != null)  Expanded(
                   flex: 1,
                    child: IconButton(onPressed: this.onPressedRemove,
                      icon: Icon(Icons.delete),color:Colors.redAccent ,splashColor: Colors.red,
                    )
                )

              ],
            ),
          )
      );
  }

}