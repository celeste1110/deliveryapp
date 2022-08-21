
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/product_model.dart';
import '../../pages/customer/product_detail_page.dart';
import '../general/colors.dart';
import 'general_widget.dart';

class ItemProductWidget2 extends StatelessWidget {
  ProductModel productModel;

  ItemProductWidget2({
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14.0),
      splashColor: Colors.black.withOpacity(0.08),
      highlightColor: Colors.black.withOpacity(0.05),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              productModel: productModel,
              isGeneral: true,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        margin: const EdgeInsets.only(bottom: 14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12.0,
              offset: const Offset(4, 4),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              child: Stack(
                children: [
                  Hero(
                    tag: "${productModel.id!}general",
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14.0),
                      child: CachedNetworkImage(
                        width: 150,
                        height: 120,
                        imageUrl: productModel.image,
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
                  Positioned(
                    bottom: 5,
                    right: 0,
                    child: productModel.discount > 0
                        ? Container(
                      margin:
                      const EdgeInsets.symmetric(horizontal: 10.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: kBrandSecondaryColor,
                      ),
                      child: Text(
                        "${productModel.discount}% desc",
                        style: const TextStyle(
                          fontSize: 9.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
            divider10(),
            Text(
              productModel.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                color: kBrandPrimaryColor,
              ),
            ),
            divider10(),
            Row(
              children: [
                Text(
                  "S./ ${productModel.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 13.0,
                    decoration: productModel.discount > 0 ? TextDecoration.lineThrough : TextDecoration.none,
                    fontWeight: FontWeight.w600,
                    color:  productModel.discount > 0 ?  kBrandPrimaryColor.withOpacity(0.4) : kBrandSecondaryColor,
                  ),
                ),
                dividerWidth6,
                productModel.discount > 0 ? Text(
                  "S./ ${ (productModel.price - productModel.price * productModel.discount/100).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    color: kBrandSecondaryColor,
                  ),
                ) : const SizedBox(),
              ],
            ),
            divider3,
          ],
        ),
      ),
    );
  }
}
