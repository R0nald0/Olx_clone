import 'package:flutter/services.dart';
import 'package:olx_clone/componets/ValidarUsuario.dart';
import 'package:validadores/validadores.dart';

import 'package:flutter/material.dart';

class CampoTextFormPersonalizad extends StatelessWidget {
  final Color corPadrao;
  final String labelText;
  final String hintText;
  final Icon icone;
  late final bool isPassword;
  late final TextEditingController controller;
  late final TextInputType textInputType;
  final String? Function(String?) funcValidar;
  final void Function(String?)? onSaved;
  final List<TextInputFormatter> inputFormatters;
  final int maxLines ;


  CampoTextFormPersonalizad(
        @required this.controller,
        @required this.funcValidar,

        this.corPadrao,
        this.labelText,
        { this.isPassword = false,
          this.textInputType = TextInputType.text,
          this.maxLines = 1,
          this.icone = const Icon(null),
          this.inputFormatters = const [],
          this.hintText = "",
          this.onSaved =  null
        }
      );

  @override
  Widget build(BuildContext context) => TextFormField(
          keyboardType: textInputType,
          controller: controller,
          obscureText: isPassword,
          inputFormatters: this.inputFormatters,
          onSaved: this.onSaved,
          maxLines: this.maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            labelText: labelText,
            hintText: hintText,
            contentPadding: EdgeInsets.fromLTRB(8, 16, 8, 16),
            focusColor: corPadrao,
            prefixIcon: icone,
          ),
          validator: this.funcValidar
,
          );

}
