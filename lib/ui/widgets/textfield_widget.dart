import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../general/colors.dart';

class TextFielWidget extends StatelessWidget {
  String hintText;
  int? maxLines;
  bool? isNumeric;
  TextEditingController controller;
  bool? validate;

  TextFielWidget({
    required this.hintText,
    this.maxLines,
    this.isNumeric = false,
    required this.controller,
    this.validate,

});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.0),
      child: TextFormField(

        controller: controller,
        maxLines: maxLines,
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        keyboardType:
        isNumeric! ? TextInputType.number : TextInputType.text,
        inputFormatters: isNumeric!
            ? [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
        ]
            : [],

        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 18),
            filled: true,
            fillColor: Color(0xff262A34).withOpacity(0.1),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 14.0,

            ),
            counterText: "",
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
            errorStyle: const TextStyle(
              color: kErrorColor,
            )),
        validator: (String? value) {

          if(validate != null) return null;

          if(value!.isEmpty){
            return "Campo requerido";
          }



          return null;
        },
      ),
    );
  }
}
