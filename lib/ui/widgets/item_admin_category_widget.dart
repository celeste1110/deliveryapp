import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deliveryapp/ui/widgets/text_widget.dart';
import 'package:flutter_svg/svg.dart';

import '../../models/category_model.dart';
import '../../pages/admin/category_form_page.dart';
import '../../pages/admin/product_form_page.dart';
import '../../services/firestore_servoce.dart';
import '../general/colors.dart';
import 'general_widget.dart';

class ItemAdminCategoryWidget extends StatelessWidget {
  CategoryModel category;
  // Function onDelete;
  // Function onUpdate;

  ItemAdminCategoryWidget({
    required this.category,
    // required this.onDelete,
    // required this.onUpdate,
  });
  final FirestoreService _categoryService =
  FirestoreService(collection: 'categories');
  showAlertDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Eliminar categoria",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              divider3,
              TextNormal(
                text:
                "¿Estás seguro de eliminar la categoria?, ten en cuenta que será de forma permanente",
              ),
              divider6(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancelar",
                      style: TextStyle(
                        color: kBrandPrimaryColor.withOpacity(0.7),
                      ),
                    ),
                  ),
                  dividerWidth10,
                  ElevatedButton(
                    onPressed: () {
                      _categoryService.deleteCategory(category.id!).then((
                          value) {
                        Navigator.pop(context);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      primary: kBrandPrimaryColor,
                    ),
                    child: Text(
                      "Aceptar",
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: kBrandPrimaryColor,
          child: Text(
            category.category[0],
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        title: TextNormal(text: category.category),
        subtitle: Text(
          "Estado: ${category.status ? 'Activo' : 'Desactivo'}",
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                showAlertDelete(context);
              },
              icon: SvgPicture.asset(
                'assets/icons/trash.svg',
                color: kBrandPrimaryColor.withOpacity(0.8),
                height: 20.0,
              ),
            ),
            IconButton(
              onPressed: () {
                // onUpdate();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryFormPage(
                    categoryModel: category,

                    ),
                  ),
                );
              },
              icon: SvgPicture.asset(
                'assets/icons/edit.svg',
                color: kBrandPrimaryColor.withOpacity(0.8),
                height: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
