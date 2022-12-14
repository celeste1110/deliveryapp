
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/product_model.dart';
import '../ui/general/colors.dart';
import '../ui/widgets/item_product_widget.dart';

class SearchProductDelegate extends SearchDelegate {
  List<ProductModel> products;

  SearchProductDelegate({
    required this.products,
  });

  List<String> names = [
    "Juan",
    "Luis",
    "Carlos",
    "Diana",
    "Susana",
    "Maria",
    "Alejandra",
    "Mariela",
    "Angela",
  ];

  @override
  String get searchFieldLabel => "Buscar producto";

  @override
  TextStyle get searchFieldStyle => TextStyle(
    color: kBrandPrimaryColor.withOpacity(0.5),
    fontSize: 14.0,
  );

  @override
  InputDecorationTheme get searchFieldDecorationTheme => InputDecorationTheme(
    hintStyle: TextStyle(
      fontSize: 14.0,
    ),
    filled: true,
    // fillColor: Colors.redAccent,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
    ),
  );

  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context).copyWith(
    hintColor: Colors.white,
    appBarTheme: AppBarTheme(
      elevation: 0,
      toolbarHeight: 76,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
          color: kBrandPrimaryColor,
          size: 22.0
      ),
    ),
    textTheme: GoogleFonts.manropeTextTheme().copyWith(
      headline6: const TextStyle(
        fontSize: 14.0,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: kBrandPrimaryColor.withOpacity(0.5),
        ),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 14.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(14.0),
        )
    ),

  );



  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(
          Icons.close,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: Icon(
        Icons.arrow_back_ios_sharp,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<ProductModel> productsResult = products
        .where((element) =>
        element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: productsResult.length,
      itemBuilder: (BuildContext context, int index) {
        return ItemProductWidget(
          productModel: productsResult[index],
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<ProductModel> productsSuggestion = products
        .where((element) =>
        element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: productsSuggestion.length,
      itemBuilder: (BuildContext context, int index) {
        return ItemProductWidget(
          productModel: productsSuggestion[index],
        );
      },
    );
  }
}