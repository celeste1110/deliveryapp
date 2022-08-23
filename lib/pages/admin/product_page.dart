import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deliveryapp/pages/admin/product_form_page.dart';

import '../../models/category_model.dart';
import '../../models/product_model.dart';
import '../../services/firestore_servoce.dart';
import '../../ui/general/colors.dart';
import '../../ui/widgets/floating_button_widget.dart';
import '../../ui/widgets/general_widget.dart';
import '../../ui/widgets/item_admin_product_widget.dart';
import '../../ui/widgets/text_widget.dart';

class ProductAdminPage extends StatefulWidget {
  const ProductAdminPage({Key? key}) : super(key: key);

  @override
  State<ProductAdminPage> createState() => _ProductAdminPageState();
}

class _ProductAdminPageState extends State<ProductAdminPage> {
  final CollectionReference _productReference =
  FirebaseFirestore.instance.collection('products');

  final FirestoreService _categoryReference =
  FirestoreService(collection: "categories");

  final FirestoreService _productService = FirestoreService(collection: "products");


  List<CategoryModel> categories = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    categories = await _categoryReference.getCategories();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextGeneral(
          text: 'Productos',
          fontSize: 25,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: kBrandSecondaryColor,
      ),
      floatingActionButton: FloatingButtonWidget(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductFormPage(
                categories: categories,

              ),
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
              stream: _productService.getStreamProduct(),
              builder: (BuildContext context, AsyncSnapshot snap) {
                if (snap.hasData) {
                  QuerySnapshot collection = snap.data;
                  List<ProductModel> products = collection.docs.map((e) {
                    ProductModel product =
                    ProductModel.fromJson(e.data() as Map<String, dynamic>);
                    product.id = e.id;

                    product.categoryDescription = categories.isNotEmpty ? categories
                        .firstWhere((element) => element.id == product.categoryId)
                        .category : "";

                    return product;
                  }).toList();

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ItemAdminProductWidget(
                        productModel: products[index],
                        categories: categories,
                      );
                    },
                  );
                }
                return loadingWidget();
              },
            ),
            divider40(),
            divider40(),
          ],
        ),
      ),
    );
  }
}
