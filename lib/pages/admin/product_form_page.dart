import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/category_model.dart';
import '../../models/product_model.dart';
import '../../services/firestore_servoce.dart';
import '../../ui/general/colors.dart';
import '../../ui/widgets/button_normal_widget.dart';
import '../../ui/widgets/general_widget.dart';
import '../../ui/widgets/text_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../ui/widgets/textfield_widget.dart';

class ProductFormPage extends StatefulWidget {
  List<CategoryModel> categories;
  ProductModel? productModel;

  ProductFormPage({
    required this.categories,
    this.productModel,
  });

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final TextEditingController _ingredientController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _discountController = TextEditingController();

  final TextEditingController _timeController = TextEditingController();

  final TextEditingController _servingController = TextEditingController();

  final TextEditingController _rateController = TextEditingController();

  List<String> _ingredients = [];
  List<CategoryModel> _categories = [];
  String categoryValue = "";
  XFile? _image;
  bool isLoading = true;

  CollectionReference _collectionReference =
  FirebaseFirestore.instance.collection('tasks');

  final FirestoreService _categoryService =
  FirestoreService(collection: "categories");

  final FirestoreService _productService =
  FirestoreService(collection: "products");

  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;

  final _formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
    getData();
  }

  getData() {
    // _categories = await _categoryService.getCategories();
    categoryValue = widget.categories.first.id!;

    if (widget.productModel != null) {
      _nameController.text = widget.productModel!.name;
      _descriptionController.text = widget.productModel!.description;
      _priceController.text = widget.productModel!.price.toStringAsFixed(2);
      _discountController.text = widget.productModel!.discount.toString();
      _timeController.text = widget.productModel!.time.toString();
      _servingController.text = widget.productModel!.serving.toString();
      _rateController.text = widget.productModel!.rate.toStringAsFixed(1);
      _ingredients = widget.productModel!.ingredients;
      categoryValue = widget.productModel!.categoryId;
    }

    isLoading = false;
    setState(() {});
  }

  getImageGallery() async {
    ImagePicker _imagePicker = ImagePicker();
    _image = await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  getImageCamera() async {
    ImagePicker _imagePicker = ImagePicker();
    _image = await _imagePicker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  Future<String> uploadImageStorage() async {
    firebase_storage.Reference _reference = _storage.ref().child("products");
    String time = DateTime.now().toString();
    firebase_storage.TaskSnapshot uploadTask =
    await _reference.child("$time.jpg").putFile(File(_image!.path));
    String url = await uploadTask.ref.getDownloadURL();
    return url;
  }

  saveProduct() async {
    if (_formKey.currentState!.validate()) {
      ProductModel productModel = ProductModel(
        image: "",
        categoryId: categoryValue,
        rate: double.parse(_rateController.text),
        price: double.parse(_priceController.text),
        name: _nameController.text,
        discount: int.parse(_discountController.text),
        ingredients: _ingredients,
        description: _descriptionController.text,
        time: int.parse(_timeController.text),
        serving: int.parse(_servingController.text),
      );

      if (_image != null) {
        String imageUrl = await uploadImageStorage();
        productModel.image = imageUrl;
      } else {
        if (widget.productModel != null) {
          productModel.image = widget.productModel!.image;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              content: Row(
                children: [
                  Icon(
                    Icons.image_not_supported,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Por favor selecciona una imagen.",
                  ),
                ],
              ),
            ),
          );
          return;
        }
      }

      if (widget.productModel == null) {
        //Agregar nuevo
        _productService.addProduct(productModel).then((value) {
          isLoading = false;
          setState(() {});
          Navigator.pop(context);
        });
      } else {
        //Actualizar
        productModel.id = widget.productModel!.id;
        _productService.updateProduct(productModel).then((value) {
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
      appBar: AppBar(
        title: TextGeneral(
          text: "${widget.productModel == null ? 'Agregar' : 'Actualizar'} producto",
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
                    TextNormal(text: "Nombre del producto:"),
                    TextFielWidget(
                      hintText: "Nombre del producto",
                      controller: _nameController,
                    ),
                    TextFielWidget(
                      hintText: "Descripción",
                      maxLines: 4,
                      controller: _descriptionController,
                    ),
                    Row(
                      children: [
                        TextNormal(text: " Categoría:"),
                      ],
                    ),
                    divider6(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14.0,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 12.0,
                            offset: const Offset(4, 4),
                          )
                        ],
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: categoryValue,
                          isExpanded: true,
                          items: widget.categories
                              .map(
                                (e) => DropdownMenuItem(
                              value: e.id,
                              child: TextNormal(
                                text: e.category,
                              ),
                            ),
                          )
                              .toList(),
                          onChanged: (String? value) {
                            categoryValue = value!;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    divider20(),
                    divider6(),
                    Row(
                      children: [
                        Expanded(
                          child: TextFielWidget(
                            hintText: "Precio",
                            isNumeric: true,
                            controller: _priceController,
                          ),
                        ),
                        dividerWidth10,
                        Expanded(
                          child: TextFielWidget(
                            hintText: "Descuento",
                            isNumeric: true,
                            controller: _discountController,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFielWidget(
                            hintText: "Tiempo",
                            isNumeric: true,
                            controller: _timeController,
                          ),
                        ),
                        dividerWidth10,
                        Expanded(
                          child: TextFielWidget(
                            hintText: "Porciones",
                            isNumeric: true,
                            controller: _servingController,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFielWidget(
                            hintText: "Calificación",
                            isNumeric: true,
                            controller: _rateController,
                          ),
                        ),
                        dividerWidth10,
                        Expanded(
                          child: SizedBox(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30.0,
                      child: Divider(
                        indent: 20.0,
                        endIndent: 20.0,
                      ),
                    ),
                    TextNormal(
                      text: "Ingredientes",
                    ),
                    divider12(),
                    Row(
                      children: [
                        Expanded(
                          child: TextFielWidget(
                            hintText: "Ingrediente",
                            controller: _ingredientController,
                            validate: false,
                          ),
                        ),
                        dividerWidth10,
                        InkWell(
                          onTap: () {
                            _ingredients.add(_ingredientController.text);
                            _ingredientController.clear();
                            setState(() {});
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: kBrandSecondaryColor,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    _ingredients.isNotEmpty
                        ? Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 12.0,
                            offset: const Offset(4, 4),
                          )
                        ],
                      ),
                      child: ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _ingredients.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: TextNormal(text: _ingredients[index]),
                            trailing: IconButton(
                              icon: SvgPicture.asset(
                                'assets/icons/trash.svg',
                                height: 18.0,
                                color:
                                kBrandPrimaryColor.withOpacity(0.8),
                              ),
                              onPressed: () {
                                _ingredients.removeAt(index);
                                setState(() {});
                              },
                            ),
                          );
                        },
                      ),
                    )
                        : Container(
                        margin: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/box.png',
                              height: 90.0,
                              color: kBrandPrimaryColor.withOpacity(0.8),
                            ),
                            divider6(),
                            TextNormal(
                              text: "Aún no hay ingredientes",
                            ),
                          ],
                        )),
                    divider20(),
                    const SizedBox(
                      height: 30.0,
                      child: Divider(
                        indent: 20.0,
                        endIndent: 20.0,
                      ),
                    ),
                    TextNormal(
                      text: "Imagen del producto",
                    ),
                    divider20(),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40.0,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                getImageGallery();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xfff72585),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                              ),
                              icon: SvgPicture.asset(
                                'assets/icons/gallery.svg',
                                color: Colors.white,
                              ),
                              label: Text(
                                "Galería",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        dividerWidth10,
                        Expanded(
                          child: SizedBox(
                            height: 40.0,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                getImageCamera();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff4361ee),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              icon: SvgPicture.asset(
                                'assets/icons/camera.svg',
                                color: Colors.white,
                              ),
                              label: Text(
                                "Cámara",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    divider20(),
                    Container(
                      height: height * 0.32,
                      width: width * 0.85,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 12.0,
                            offset: const Offset(4, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14.0),
                        child: Image(
                          image: _image != null
                              ? FileImage(File(_image!.path))
                              : widget.productModel != null
                              ? NetworkImage(widget.productModel!.image)
                              : const AssetImage(
                              'assets/images/placeholder.png')
                          as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    divider30(),
                    ButtonNormalWidget(
                      title: "Guardar",
                      // icon: 'save',
                      onPressed: () {
                        saveProduct();
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