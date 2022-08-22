import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deliveryapp/ui/general/colors.dart';
import 'package:flutter_deliveryapp/ui/widgets/text_widget.dart';

import '../../models/order_model.dart';
import '../../services/firestore_servoce.dart';
import '../../ui/widgets/general_widget.dart';
import '../../ui/widgets/item_order_admin_widget.dart';

class OrderAdminPage extends StatelessWidget {
  final FirestoreService _orderReference =
      FirestoreService(collection: 'orders');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextGeneral(
          text: 'Ordenes',
          fontSize: 25,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: kBrandSecondaryColor,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: StreamBuilder(
          stream: _orderReference.getStreamOrder(),
          builder: (BuildContext context, AsyncSnapshot snap) {
            if (snap.hasData) {
              QuerySnapshot collection = snap.data;
              List<OrderModel> orders = collection.docs.map((e) {
                OrderModel model =
                    OrderModel.fromJson(e.data() as Map<String, dynamic>);
                model.id = e.id;
                return model;
              }).toList();
              orders = orders.reversed.toList();
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return ItemOrderAdminWidget(
                    orderModel: orders[index],
                  );
                },
              );
            }
            return loadingWidget();
          },
        ),
      ),
    );
  }
}
