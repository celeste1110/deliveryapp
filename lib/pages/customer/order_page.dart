import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../helpers/sp_global.dart';
import '../../models/order_model.dart';
import '../../services/firestore_servoce.dart';
import '../../services/order_service.dart';
import '../../services/order_stream_service.dart';
import '../../ui/general/colors.dart';
import '../../ui/widgets/general_widget.dart';
import '../../ui/widgets/item_order_widget.dart';
import '../../ui/widgets/text_widget.dart';

class OrderPage extends StatefulWidget {
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final FirestoreService _ordersCollection =
      FirestoreService(collection: "orders");
  DateFormat format = DateFormat('yyyy-MM-dd hh:mm:ss');
  final SPGlobal _prefs = SPGlobal();

  _registerOrder() {
    // Map<String, dynamic> order = {
    //   "customer": "Elvis Barrionuevo",
    //   "email": "mandarinax@gmail.com",
    //   "products": OrderService().getOrdersMap(),
    //   "datetime": format.format(DateTime.now()),
    //   "status": "Recibido",
    // };

    OrderModel orderModel = OrderModel(
      customer: "${_prefs.name} ${_prefs.lastName}",
      email: _prefs.email,
      products: OrderService().getOrders,
      datetime: format.format(DateTime.now()),
      status: "Recibido",
    );

    _ordersCollection.addOrder(orderModel).then((value) {
      if (value.isNotEmpty) {
        showSuccessSnackBar(
          context,
          "Tu orden fue enviada con éxito.",
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    divider10(),
                    divider6(),
                    Center(
                      child: TextGeneral(
                        text: 'My Cart',
                        fontSize: 23,
                        color: kBrandPrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    divider12(),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
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
                    divider20(),
                    TextGeneral(
                        text: 'Your Order',
                        fontSize: 18,
                        color: kBrandPrimaryColor,
                        fontWeight: FontWeight.w700),
                    divider12(),
                    OrderService().ordersLength > 0
                        ? ListView.builder(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: OrderService().ordersLength,
                            itemBuilder: (BuildContext context, int index) {
                              return ItemOrderWidget(
                                productOrderModel:
                                    OrderService().getProductOrder(index),
                                onDelete: () {
                                  OrderService().deleteProduct(index);
                                  OrderStreamService().removeCounter();
                                  setState(() {});
                                },
                              );
                            },
                          )
                        : Container(
                            height: 300,
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/box.png',
                                  color: kBrandPrimaryColor.withOpacity(0.9),
                                  height: 90,
                                ),
                                divider20(),
                                TextNormal(
                                  text:
                                      "Aún no has agregado productos a la lista.",
                                ),
                              ],
                            ),
                          ),
                    const SizedBox(
                      height: 100.0,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 20.0,
                      offset: const Offset(0, -10.0),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            color: kBrandPrimaryColor.withOpacity(0.6),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        divider3,
                        Text(
                          "S/${OrderService().total.toStringAsFixed(2)}",
                          style: TextStyle(
                            color: kBrandPrimaryColor.withOpacity(0.96),
                            fontSize: 22.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    dividerWidth10,
                    dividerWidth10,
                    Expanded(
                      child: SizedBox(
                        height: 46,
                        child: ElevatedButton(
                          onPressed: OrderService().ordersLength > 0
                              ? () {
                                  _registerOrder();
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  14.0,
                                ),
                              ),
                              primary: kBrandSecondaryColor),
                          child: Text(
                            "Ordenar ahora",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
