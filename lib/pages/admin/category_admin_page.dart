import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/category_model.dart';
import '../../services/firestore_servoce.dart';
import '../../ui/general/colors.dart';
import '../../ui/widgets/floating_button_widget.dart';
import '../../ui/widgets/general_widget.dart';
import '../../ui/widgets/item_admin_category_widget.dart';
import '../../ui/widgets/text_widget.dart';
import 'category_form_page.dart';

class CategoryAdminPage extends StatefulWidget {
  @override
  State<CategoryAdminPage> createState() => _CategoryAdminPageState();
}

class _CategoryAdminPageState extends State<CategoryAdminPage> {
  final FirestoreService _categoryService =
  FirestoreService(collection: 'categories');



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextGeneral(
          text: 'Categorias',
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
              builder: (context) => CategoryFormPage(


              ),
            ),
          );
        },
      ),
      body: StreamBuilder(
        stream: _categoryService.getStreamCategory(),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.hasData) {
            QuerySnapshot collection = snap.data;

            // List<Map<String, dynamic>> productsMap = collection.docs
            //     .map((e) => e.data() as Map<String, dynamic>)
            //     .toList();


            List<CategoryModel> categories = collection.docs.map((e){
              CategoryModel categoryModel = CategoryModel.fromJson(e.data() as Map<String, dynamic>);
              categoryModel.id = e.id;
              return categoryModel;
            }).toList();

            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) {
                return ItemAdminCategoryWidget(
                  category: categories[index],
                  // onDelete: (){},
                  // onUpdate: (){},
                );
              },
            );
          }
          return loadingWidget();
        },
      ),
    );
  }
}
