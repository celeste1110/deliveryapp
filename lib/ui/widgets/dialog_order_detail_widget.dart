import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/order_model.dart';
import '../../services/firestore_servoce.dart';
import '../../utils/constants.dart';
import '../general/colors.dart';
import 'general_widget.dart';

class DialogOrderDetailWidget extends StatefulWidget {
  OrderModel orderModel;

  DialogOrderDetailWidget({
    required this.orderModel,
  });

  @override
  State<DialogOrderDetailWidget> createState() => _DialogOrderDetailWidgetState();
}

class _DialogOrderDetailWidgetState extends State<DialogOrderDetailWidget> {
  final FirestoreService _orderService = FirestoreService(collection: 'orders');
  String statusValue = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    statusValue = widget.orderModel.status;
  }

  void updateStatus(){
    widget.orderModel.status = statusValue;
    _orderService.updateStatusOrder(widget.orderModel).whenComplete((){
      Navigator.pop(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      contentPadding: EdgeInsets.zero,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Detalle de la orden",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 0.4,
            ),
            divider6(),
            Text(
              "Cliente:",
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: kBrandPrimaryColor.withOpacity(0.6),
              ),
            ),
            Text(
              widget.orderModel.customer,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
                color: kBrandPrimaryColor.withOpacity(0.9),
              ),
            ),
            divider3,
            Text(
              "Fecha / Hora:",
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: kBrandPrimaryColor.withOpacity(0.6),
              ),
            ),
            Text(
              widget.orderModel.datetime,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
                color: kBrandPrimaryColor.withOpacity(0.9),
              ),
            ),
            divider3,
            const Divider(
              thickness: 0.4,
            ),
            Text(
              "Productos:",
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: kBrandPrimaryColor.withOpacity(0.6),
              ),
            ),
            divider3,
            ...widget.orderModel.products
                .map(
                  (e) => Container(
                margin: const EdgeInsets.symmetric(vertical: 7.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13.0,
                              color: kBrandPrimaryColor.withOpacity(0.8),
                            ),
                          ),
                          Text(
                            "S/${e.price.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                              color: kBrandPrimaryColor.withOpacity(0.6),
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      "Cant. ${e.quantity}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13.0,
                        color: kBrandPrimaryColor.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            )
                .toList(),
            divider3,
            const Divider(
              thickness: 0.4,
            ),
            Text(
              "Estado:",
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: kBrandPrimaryColor.withOpacity(0.6),
              ),
            ),
            Wrap(
              spacing: 10.0,
              children: statusColor
                  .map((key, value) => MapEntry(key, value))
                  .keys
                  .map(
                    (e) => FilterChip(
                  selected: statusValue == e,
                  selectedColor: statusColor[statusValue],
                  checkmarkColor:
                  statusValue == e ? Colors.white : Colors.black38,
                  backgroundColor: Colors.black12.withOpacity(0.05),
                  label: Text(
                    e,
                    style: TextStyle(
                      fontSize: 13.0,
                      color:
                      statusValue == e ? Colors.white : Colors.black38,
                    ),
                  ),
                  onSelected: (bool value) {
                    statusValue = e;
                    setState(() {});
                  },
                ),
              )
                  .toList(),
            ),
            divider3,
            const Divider(
              thickness: 0.4,
            ),
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
                      color: kBrandPrimaryColor.withOpacity(0.5),
                    ),
                  ),
                ),
                dividerWidth10,
                ElevatedButton(
                  onPressed: () {
                    updateStatus();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    primary: kBrandPrimaryColor,
                  ),
                  child: Text(
                    "Guardar",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
