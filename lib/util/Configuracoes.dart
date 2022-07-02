
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/models/Categoria.dart';

class Configuracoes{

   static List<DropdownMenuItem<String>> getListState (){
      List<DropdownMenuItem<String>> listEstado= [];
      listEstado.add(
          DropdownMenuItem(child: Text("Região",style: TextStyle(color:Color(0xff9c27b0)),),value: "Região",)
      );
      for(var state in Estados.listaEstadosSigla){
        listEstado.add(
                DropdownMenuItem(child: Text(state),value:state)
            );
      }
      return listEstado;
   }

   static List<DropdownMenuItem<String>> getListCategory(){
        List<DropdownMenuItem<String>> listCategoria= [];

        listCategoria.add(
            DropdownMenuItem(child: Text("Categoria",style: TextStyle(color:Color(0xff9c27b0))),value: "Categoria",)
        );

         for( var category in Categoria.categoriasExibida()){
           listCategoria.add(
               DropdownMenuItem(child: Text(category),value: category )
           );
         }

         return listCategoria;
   }
}