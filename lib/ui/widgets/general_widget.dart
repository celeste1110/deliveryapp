import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../general/colors.dart';
const divider3 = SizedBox(height: 3.0,);
SizedBox divider4() => const SizedBox(height: 4.0);
SizedBox divider6() => const SizedBox(height: 6.0);
SizedBox divider8() => const SizedBox(height:8.0);
SizedBox divider10() => const SizedBox(height: 10.0);
SizedBox divider12() => const SizedBox(height: 12.0);
SizedBox divider20() => const SizedBox(height: 20.0);
SizedBox divider30() => const SizedBox(height: 30.0);
SizedBox divider40() => const SizedBox(height: 40.0);

const dividerWidth3 = SizedBox(
  width: 3.0,
);

const dividerWidth6 = SizedBox(
  width: 6.0,
);

const dividerWidth10 = SizedBox(
  width: 10.0,
);

Widget circleWidget(double radius) {
  return Container(
    height: radius * 2,
    width: radius * 2,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white.withOpacity(0.13),
    ),
  );
}

Widget loadingWidget(){
  return Center(
    child: SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: kBrandSecondaryColor,
      ),
    ),
  );
}

void showSnackBar(BuildContext context, String text){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      backgroundColor: Colors.redAccent,
      content: Text(text),
    ),
  );
}


void showSuccessSnackBar(BuildContext context, String text){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      backgroundColor: Color(0xff06d6a0),
      content: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.white,),
          const SizedBox(
            width: 10.0,
          ),
          Text(text),
        ],
      ),
    ),
  );
}