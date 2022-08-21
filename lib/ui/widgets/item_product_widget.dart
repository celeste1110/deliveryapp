import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deliveryapp/ui/widgets/text_widget.dart';

import '../../models/product_model.dart';
import '../../pages/customer/product_detail_page.dart';
import '../general/colors.dart';
import 'general_widget.dart';

class ItemProductWidget extends StatelessWidget {
  ProductModel productModel;

  ItemProductWidget({
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
        child: Row(
          children: [
            Hero(
              tag: "${productModel.id!}general",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14.0),
                child: CachedNetworkImage(
                  width: 120,
                  height: 120,
                  imageUrl: productModel.image,
                  fit: BoxFit.cover,
                  fadeInCurve: Curves.easeIn,
                  fadeInDuration: const Duration(milliseconds: 800),
                  progressIndicatorBuilder: (context, url, downloadProgress) {
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
            dividerWidth10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        productModel.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: kBrandPrimaryColor,
                        ),
                      ),
                      productModel.discount > 0 ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: kBrandSecondaryColor,
                        ),
                        child: Text(
                          "${productModel.discount}% desc",
                          style: const TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ) : const SizedBox(),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "S./ ${productModel.price.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14.0,
                          decoration: productModel.discount > 0 ? TextDecoration.lineThrough : TextDecoration.none,
                          fontWeight: FontWeight.w600,
                          color:  productModel.discount > 0 ?  kBrandPrimaryColor.withOpacity(0.4) : kBrandPrimaryColor,
                        ),
                      ),
                      dividerWidth6,
                      productModel.discount > 0 ? Text(
                        "S./ ${ (productModel.price - productModel.price * productModel.discount/100).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: kBrandPrimaryColor,
                        ),
                      ) : const SizedBox(),
                    ],
                  ),
                  divider3,
                  TextNormal(
                    text: productModel.description,
                    color: kBrandPrimaryColor.withOpacity(0.6),
                    maxLines: 2,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  divider3,
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 14.0,
                        color: Color(0xffFDBF4F),
                      ),
                      dividerWidth3,
                      Text(
                        productModel.rate.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: kBrandPrimaryColor,
                        ),
                      ),
                      dividerWidth3,
                      Text(" | "),
                      dividerWidth3,
                      Text(
                        "${productModel.time} min.",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: kBrandPrimaryColor,
                        ),
                      ),
                      dividerWidth3,
                      Text(" | "),
                      dividerWidth3,
                      Text(
                        "Porciones: ${productModel.serving}",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: kBrandPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
