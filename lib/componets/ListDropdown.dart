import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListDropdown extends StatelessWidget{

    String? valorInicial;
    Widget? hint;
   late List<DropdownMenuItem<String>> listDados;
   void Function(String?) onChanged;
   void Function()? onTap;

   ListDropdown({
       required this.listDados,
       required this.onChanged,
       this.valorInicial = null,
       this.onTap = null,
       this.hint = null
}){}

  @override
  Widget build(BuildContext context)  =>DropdownButtonHideUnderline(

      child: DropdownButton(
        items: this.listDados,
        onChanged: this.onChanged,
        value: this.valorInicial,
        onTap: this.onTap,
        hint: this.hint,
        iconEnabledColor: Color(0xff9c27b0),
       style: TextStyle(
         color:Colors.black,
             fontSize: 20
       ),
      ),

  );
}