import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../general/colors.dart';
import '../general/fonts.dart';
import 'general_widget.dart';

class SearchWidget extends StatelessWidget {
  Function onTap;

  SearchWidget({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.black.withOpacity(0.04),
      splashColor: Colors.black.withOpacity(0.04),

      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20.0,
              offset: const Offset(
                4,
                4,
              ),
            ),
          ],
        ),
        child: TextField(
          onTap: () {
            onTap();
          },
          //readOnly: true,
          decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xff262A34).withOpacity(0.1),
              hintText: "Buscar",
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black.withOpacity(0.5),
                size: 25,
              ),
              hintStyle: TextStyle(
                  fontSize: textNormalSize,
                  color: Colors.black.withOpacity(0.5)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none,
              ),
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
        ),
      ),
    );
  }
}
