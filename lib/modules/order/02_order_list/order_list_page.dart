import 'package:flutter/material.dart';
import 'package:fruitshop/data/models/order_model.dart';
import 'package:fruitshop/data/utils/date_formatter_util.dart';
import 'package:fruitshop/modules/order/01_order_resum/order_resum_controller.dart';
import 'package:fruitshop/modules/widgets/scaffolds/regular_scaffold.dart';
import 'package:fruitshop/theme/dosis_style.dart';
import 'package:get/get.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  @override
  Widget build(BuildContext context) {
    OrderResumController orderResumController = Get.put(OrderResumController());
    return RegularScaffold(
      showBackButton: false,
      title: "Pedidos realizados",
      widget: Column(children: [
        Expanded(
            child: ListView(
          children: orderResumController.orders.map((OrderModel order) {
            return orderItem(order);
          }).toList(),
        ))
      ]),
    );
  }

  Widget orderItem(OrderModel order) {
    OrderResumController orderResumController = Get.put(OrderResumController());
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey, spreadRadius: 1.25),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Text(
                        DateFormatUtil()
                            .transformTimeStampToDate(order.createdAt!),
                        style: DosisStyle.bold(context).merge(
                            TextStyle(fontSize: 16, color: Colors.grey[800]))),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8)
          ],
        ),
      ),
    );
  }
}
