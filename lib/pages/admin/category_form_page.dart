import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/category_model.dart';
import '../../services/firestore_servoce.dart';
import '../../ui/general/colors.dart';
import '../../ui/widgets/button_normal_widget.dart';
import '../../ui/widgets/general_widget.dart';
import '../../ui/widgets/text_widget.dart';
import '../../ui/widgets/textfield_widget.dart';

class CategoryFormPage extends StatefulWidget {
  CategoryModel? categoryModel;

  CategoryFormPage({
    this.categoryModel,
  });

  @override
  State<CategoryFormPage> createState() => _CategoryFormPageState();
}

class _CategoryFormPageState extends State<CategoryFormPage> {
  final TextEditingController _descriptionController = TextEditingController();
  bool isLoading = true;
  final FirestoreService _categoryService =
  FirestoreService(collection: "categories");
  final _formKey = GlobalKey<FormState>();
  @override
  initState() {
    super.initState();
    getData();
  }

  getData() {
    // _categories = await _categoryService.getCategories();


    if (widget.categoryModel != null) {

      _descriptionController.text = widget.categoryModel!.category;

    }

    isLoading = false;
    setState(() {});
  }

  saveCategory() async {
    if (_formKey.currentState!.validate()) {
      CategoryModel categoryModel =  CategoryModel(
        category: _descriptionController.text,
        status: true,

      );

      if (widget.categoryModel == null) {
        //Agregar nuevo
        _categoryService.addCategory(categoryModel).then((value) {
          isLoading = false;
          setState(() {});
          Navigator.pop(context);
        });
      } else {
        //Actualizar
        categoryModel.id = widget.categoryModel!.id;
        _categoryService.updateCategory(categoryModel).then((value) {
          isLoading = false;
          setState(() {});
          Navigator.pop(context);
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TextGeneral(
          text:
          "${widget.categoryModel == null ? 'Agregar' : 'Actualizar'} categoria",
          fontSize: 25,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: kBrandSecondaryColor,
      ),
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(60.0),
      //   child: MyAppBarWidget(
      //     text:
      //     "${widget.productModel == null ? 'Agregar' : 'Actualizar'} producto",
      //   ),
      // ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    divider12(),
                    TextNormal(text: "Nombre de la categoria:",color: kBrandSecondaryColor),

                    TextFielWidget(
                      hintText: "Nombre de la categoria",
                      controller: _descriptionController,
                    ),
                    divider6(),


                    divider30(),
                    ButtonNormalWidget(
                      title: "Guardar",
                      // icon: 'save',
                      onPressed: () {
                        saveCategory();
                      },
                    ),
                    divider40(),
                    divider40(),
                  ],
                ),
              ),
            ),
          ),
          isLoading
              ? Container(
            color: Colors.white.withOpacity(0.8),
            child: Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: kBrandSecondaryColor,
                  strokeWidth: 2.0,
                ),
              ),
            ),
          )
              : Container(),
        ],
      ),
    );
  }
}
