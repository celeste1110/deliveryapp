import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deliveryapp/ui/widgets/search_widget2.dart';

import '../../helpers/sp_global.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';
import '../../services/firestore_servoce.dart';
import '../../ui/general/colors.dart';
import '../../ui/widgets/general_widget.dart';
import '../../ui/widgets/item_category_widget.dart';
import '../../ui/widgets/item_product_widget.dart';
import '../../ui/widgets/item_product_widget2.dart';
import '../../ui/widgets/item_promotion_widget.dart';
import '../../ui/widgets/search_widget.dart';
import '../../ui/widgets/text_widget.dart';
import '../../utils/search_product_delegate.dart';

class MenuPage extends StatefulWidget {
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final FirestoreService _productService =
      FirestoreService(collection: "products");
  final FirestoreService _categoryService =
      FirestoreService(collection: "categories");
  List<ProductModel> products = [];
  List<ProductModel> productsAux = [];
  List<CategoryModel> categories = [];
  List<ProductModel> promotionProducts = [];
  final TextEditingController _buscarController = TextEditingController();
  int indexCategory = 0;
  String category_id = "0";
  bool isLoading = true;

  final SPGlobal _prefs = SPGlobal();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFirebase();
    //_prefs.isLogin = false;
  }

  getDataFirebase() async {
    categories = await _categoryService.getCategories();
    products = await _productService.getProducts();

    products = products.map((e) {
      String categoryDescription = categories
          .firstWhere((element) => element.id == e.categoryId)
          .category;
      e.categoryDescription = categoryDescription;
      return e;
    }).toList();

    productsAux = products;
    categories.insert(
      0,
      CategoryModel(
        id: "0",
        category: "Todos",
        status: true,
      ),
    );

    promotionProducts =
        products.where((element) => element.discount > 0).toList();

    isLoading = false;
    print(categories);
    print(products);

    setState(() {});
  }

  filterCategory(String categoryId) {
    products = productsAux;
    if (categoryId != "0") {
      products = products
          .where((element) => element.categoryId == categoryId)
          .toList();
    }
  }

  filterProductos(String producto, String idCategory) {
    products = productsAux;

      if (idCategory == "0") {
        if (producto != "") {
          products = products
              .where((element) =>
              element.name.toLowerCase().contains(producto.toLowerCase()))
              .toList();
        }

      } else {
        if (producto != "") {
          products = products
              .where((element) =>
          element.name.toLowerCase().contains(producto.toLowerCase()) &&
              element.categoryId == idCategory)
              .toList();
        }else {
          products = products
              .where((element) => element.categoryId == idCategory)
              .toList();
        }
        }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                divider20(),
                divider6(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextGeneral(
                      text: 'H',
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    TextGeneral(
                      text: 'Menu',
                      fontSize: 25,
                      color: kBrandPrimaryColor.withOpacity(0.9),
                      fontWeight: FontWeight.w600,
                    ),
                    Container(
                        width: 50,
                        height: 50,
                        child: Stack(
                          children: [
                            Center(
                              child: Icon(
                                Icons.notifications,
                                size: 25,
                              ),
                            ),
                            Positioned(
                              right: 17,
                              top: 18,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
                divider12(),
                divider20(),
                TextGeneral(
                  text: 'Nuestra comida',
                  fontSize: 14,
                  color: kBrandPrimaryColor.withOpacity(0.5),
                  fontWeight: FontWeight.w500,
                ),
                divider8(),
                TextGeneral(
                  text: 'Especial para ti',
                  fontSize: 17,
                  color: kBrandSecondaryColor.withOpacity(0.9),
                  fontWeight: FontWeight.w500,
                ),
                divider20(),
                SearchWidget2(
                  controller: _buscarController,
                  onTap: () {
                    filterProductos(
                      _buscarController.text,
                        category_id
                    );
                    setState(() {});
                  },
                ),
                // SearchWidget(
                //   onTap: () async {
                //     final res = await showSearch(
                //       context: context,
                //       delegate: SearchProductDelegate(
                //         products: productsAux,
                //       ),
                //     );
                //   },
                // ),
                divider20(),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: categories
                        .map(
                          (e) => ItemCategoryWidget(
                            text: e.category,
                            selected: indexCategory == categories.indexOf(e)
                                ? true
                                : false,
                            onTap: () {
                              indexCategory = categories.indexOf(e);
                              category_id = e.id!;
                              filterCategory(e.id!);
                              setState(() {});
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
                divider20(),
                products.isNotEmpty
                    ? GridView.count(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                        children: products
                            .map((e) => ItemProductWidget2(productModel: e))
                            .toList(),
                      )
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   physics: const ScrollPhysics(),
                    //   itemCount: products.length,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     return ItemProductWidget(
                    //       productModel: products[index],
                    //     );
                    //   },
                    // )
                    : Container(
                        width: double.infinity,
                        height: 200,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/box.png',
                              height: 80.0,
                            ),
                            divider6(),
                            TextNormal(
                              text: "Aún no hay productos en esta categoría",
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
