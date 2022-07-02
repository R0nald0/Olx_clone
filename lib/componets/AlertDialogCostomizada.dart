import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogCostomizado extends StatelessWidget{
   late Widget content;
   late List<Widget> actions ;
   late Widget? title;

   AlertDialogCostomizado({
         required this.content,
         required this.actions,
         this.title = null
     }){}

  @override
  Widget build(BuildContext context)  => AlertDialog(

      content:this.content ,
      actions: this.actions,
      title:this.title ,

  );

}