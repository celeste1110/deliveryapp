import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/product_model.dart';
import '../../models/product_order_model.dart';
import '../../services/order_service.dart';
import '../../services/order_stream_service.dart';
import '../../ui/general/colors.dart';
import '../../ui/widgets/general_widget.dart';
import '../../ui/widgets/item_ingredient_widget.dart';
import '../../ui/widgets/text_widget.dart';

class ProductDetailPage extends StatefulWidget {
  ProductModel productModel;
  bool isGeneral;

  ProductDetailPage({
    required this.productModel,
    required this.isGeneral,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        fit: StackFit.loose,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Hero(
                      tag:
                      "${widget.productModel.id!}${widget.isGeneral ? "general" : "promotion"}",
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(45.0),
                          bottomLeft: Radius.circular(45.0),
                        ),
                        child: CachedNetworkImage(
                          width: double.infinity,
                          height: height * 0.45,
                          imageUrl: widget.productModel.image,
                          fit: BoxFit.cover,
                          fadeInCurve: Curves.easeIn,
                          fadeInDuration: const Duration(milliseconds: 800),
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) {
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
                          },
                        ),
                      ),
                    ),
                    Positioned.fill(
                      bottom: -50,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: width * 0.8,
                            minWidth: width * 0.8,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 14.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  offset: const Offset(0, 5),
                                  blurRadius: 12.0),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.productModel.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kBrandPrimaryColor,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              divider3,
                              TextNormal(
                                text: widget.productModel.categoryDescription!,
                              ),
                              divider3,
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 14.0,
                                    color: Color(0xffFDBF4F),
                                  ),
                                  dividerWidth3,
                                  Text(
                                    widget.productModel.rate.toStringAsFixed(1),
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: kBrandPrimaryColor,
                                    ),
                                  ),
                                  dividerWidth3,
                                  Text(" | "),
                                  dividerWidth3,
                                  Text(
                                    "${widget.productModel.time} min.",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: kBrandPrimaryColor,
                                    ),
                                  ),
                                  dividerWidth3,
                                  Text(" | "),
                                  dividerWidth3,
                                  Text(
                                    "Porciones: ${widget.productModel.serving}",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: kBrandPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              divider6(),
                              Text(
                                "S./ ${widget.productModel.price.toStringAsFixed(2)}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kBrandPrimaryColor,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SafeArea(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          margin: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.90),
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 12,
                                offset: const Offset(5, 5),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_sharp,
                            color: kBrandPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                divider40(),
                divider12(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextNormal(
                        text: "Descripción:",
                      ),
                      divider12(),
                      TextNormal(
                        text: widget.productModel.description,
                        color: kBrandPrimaryColor.withOpacity(0.6),
                      ),
                      divider12(),
                      TextNormal(
                        text: "Ingredientes:",
                      ),
                      divider12(),
                      Wrap(
                        spacing: 12.0,
                        runSpacing: 12.0,
                        // children: widget.productModel.ingredients.map((e) =>  ItemIngredientWidget(text: e),).toList(),
                        // children: [
                        //   ...widget.productModel.ingredients.map((e) =>  ItemIngredientWidget(text: e),).toList(),
                        // ],
                        children: List.generate(
                          widget.productModel.ingredients.length,
                              (index) => ItemIngredientWidget(
                            text: widget.productModel.ingredients[index],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                divider40(),
                divider40(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80.0,
              margin: const EdgeInsets.symmetric(
                horizontal: 0.0,
                vertical: 0.0,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 10.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    offset: const Offset(0, -5.0),
                    blurRadius: 12.0,
                  ),
                ],
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: quantity > 1
                        ? () {
                      quantity--;
                      setState(() {});
                    }
                        : null,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        // color: kBrandPrimaryColor.withOpacity(0.3),
                        color: quantity > 1
                            ? kBrandPrimaryColor.withOpacity(0.3)
                            : kBrandPrimaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(
                      minWidth: 42.0,
                      maxWidth: 42.0,
                    ),
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Text(
                      quantity.toString(),
                      style: TextStyle(
                        color: kBrandPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      quantity++;
                      setState(() {});
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: kBrandSecondaryColor.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  dividerWidth10,
                  Expanded(
                    child: SizedBox(
                      height: 54.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                              side: BorderSide.none,
                            ),
                            primary: kBrandSecondaryColor),
                        child: const Text(
                          "Agregar orden",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        onPressed: () {
                          ProductOrderModel productOrder = ProductOrderModel(
                            id: widget.productModel.id!,
                            name: widget.productModel.name,
                            price: widget.productModel.price,
                            image: widget.productModel.image,
                            quantity: quantity,
                          );
                          OrderService().addProduct(productOrder);
                          OrderStreamService().addCounter();
                          quantity = 1;
                          setState((){});
                          showSuccessSnackBar(context, "El producto se agregó a tu orden.");
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}