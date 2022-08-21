import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deliveryapp/ui/general/colors.dart';
import 'package:flutter_deliveryapp/ui/widgets/text_widget.dart';

import '../../helpers/sp_global.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';
import '../../services/firestore_servoce.dart';
import '../../ui/widgets/general_widget.dart';
import '../../ui/widgets/item_category_widget.dart';
import '../../ui/widgets/item_product_widget.dart';
import '../../ui/widgets/item_promotion_widget.dart';
import '../../ui/widgets/search_widget.dart';
import '../../utils/search_product_delegate.dart';

class HomeCustomerPage extends StatefulWidget {
  const HomeCustomerPage({Key? key}) : super(key: key);

  @override
  State<HomeCustomerPage> createState() => _HomeCustomerPageState();
}

class _HomeCustomerPageState extends State<HomeCustomerPage> {
  final FirestoreService _productService =
      FirestoreService(collection: "products");
  final FirestoreService _categoryService =
      FirestoreService(collection: "categories");
  List<ProductModel> products = [];
  List<ProductModel> productsAux = [];
  List<CategoryModel> categories = [];
  List<ProductModel> promotionProducts = [];

  int indexCategory = 0;

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
                      text: 'Home',
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
                SearchWidget(
                  onTap: () async {
                    final res = await showSearch(
                      context: context,
                      delegate: SearchProductDelegate(
                        products: productsAux,
                      ),
                    );
                  },
                ),
                divider20(),
                Container(
                  width: double.infinity,
                  height: 110,
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.orange.withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(10, 10)),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextGeneral(
                          text: 'Delivery a Home',
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        divider6(),
                        TextGeneral(
                          text: 'Avenida La Molina 1581',
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        divider6(),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextGeneral(
                            text: '2.4 km',
                            fontSize: 15,
                            color: kBrandSecondaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                divider30(),
                Container(
                  width: double.infinity,
                  height: 115,
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextGeneral(
                                  text: 'Ckicken Teriyaki',
                                  fontSize: 17,
                                  color: kBrandPrimaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                divider6(),
                                TextGeneral(
                                  text: 'Descuento 25%',
                                  fontSize: 13,
                                  color: kBrandPrimaryColor,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: TextGeneral(
                                    text: 'Ordenar Ahora',
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                            Image.asset(
                              'assets/images/comida1.png',
                              height: 85,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                divider20(),
                TextGeneral(
                  text: 'Promociones',
                  fontSize: 20,
                  color: kBrandPrimaryColor.withOpacity(0.9),
                  fontWeight: FontWeight.w600,
                ),
                divider20(),
                SizedBox(
                  height: 170,
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: promotionProducts.length,
                    controller: PageController(
                      initialPage: 0,
                      viewportFraction: 0.4,
                    ),
                    padEnds: false,

                    itemBuilder: (BuildContext context, int index) {
                      return ItemPromotionWidget(
                        productModel: promotionProducts[index],
                      );
                    },
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
