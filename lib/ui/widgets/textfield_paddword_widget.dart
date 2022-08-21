import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../general/colors.dart';

class TextFieldPasswordWidget extends StatefulWidget {
  TextEditingController controller;
  String text;
  TextFieldPasswordWidget({
    required this.controller,
    required this.text,
});

  @override
  State<TextFieldPasswordWidget> createState() => _TextFieldPasswordWidgetState();
}

class _TextFieldPasswordWidgetState extends State<TextFieldPasswordWidget> {
  bool isInvisible = true;
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.symmetric(vertical: 7.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: isInvisible,
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 18),
          filled: true,
          fillColor: Color(0xff262A34).withOpacity(0.1),
          hintText: widget.text,
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontSize: 14.0,
          ),
          counterText: "",
          suffixIcon: IconButton(
            onPressed: () {
              isInvisible = !isInvisible;
              setState(() {});
            },
            icon: Icon(
              isInvisible
                  ? Icons.remove_red_eye
                  : Icons.remove_red_eye_outlined,
              color: Colors.black26,
            ),
          ),
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
          ),
        ),
        validator: (String? value) {
          if (value!.isEmpty) return "Campo requerido";
          return null;
        },
      ),
    );
  }
}
