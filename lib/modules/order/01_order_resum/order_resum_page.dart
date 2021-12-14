import 'package:flutter/material.dart';
import 'package:fruitshop/data/models/product_model.dart';
import 'package:fruitshop/modules/order/01_order_resum/order_resum_controller.dart';
import 'package:fruitshop/modules/product/product_controller.dart';
import 'package:fruitshop/modules/widgets/buttons/button_primary.dart';
import 'package:fruitshop/modules/widgets/scaffolds/regular_scaffold.dart';
import 'package:fruitshop/routes/app_pages.dart';
import 'package:fruitshop/theme/dosis_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class OrderResumPage extends StatefulWidget {
  const OrderResumPage({Key? key}) : super(key: key);

  @override
  _OrderResumPageState createState() => _OrderResumPageState();
}

class _OrderResumPageState extends State<OrderResumPage> {
  OrderResumController orderResumController = Get.put(OrderResumController());
  ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    final moneyFormat = NumberFormat("#,##0.00", "pt_BR");
    return RegularScaffold(
      showBackButton: false,
      title: 'Resumo do pedido',
      widget: Column(
        children: [
          Row(
            children: [
              Text("Valor final da compra:",
                  style: DosisStyle.regular(context)
                      .merge(TextStyle(fontSize: 16.sp, color: Colors.grey[800]))),
              Text("R\$" + moneyFormat.format(productController.finalValue),
                  style: DosisStyle.bold(context)
                      .merge(TextStyle(fontSize: 16.sp, color: Colors.pink))),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: Screenshot(
              controller: orderResumController.screenshotController,
              child: Container(
                color: Colors.white,
                child: ListView(
                  children: productController.products
                      .map((ProductModel product) {
                    return orderData(product);
                  }).toList(),
                ),
              ),
            ),
          ),
          ButtonPrimary(
              buttonText: "Voltar para o início",
              callback: () {
                Get.delete<ProductController>();
                Get.until(ModalRoute.withName(RoutesHome.HOME));
              },
              isLoading: false),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              orderResumController.takeScreenshot();
            },
            child: Text("Exportar para PDF",
                style: DosisStyle.bold(context).merge(TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[800],
                  decoration: TextDecoration.underline,
                ))),
          ),
        ],
      ),
    );
  }

  Widget orderData(ProductModel product) {
    final moneyFormat = NumberFormat("#,##0.00", "pt_BR");
    return product.counter == 0
        ? Container()
        : Column(
            children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name!,
                        style: DosisStyle.bold(context).merge(
                            TextStyle(fontSize: 16.sp, color: Colors.grey[800]))),
                    Spacer(),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Quantidade: " + product.counter.toString(),
                            style: DosisStyle.regular(context).merge(TextStyle(
                                fontSize: 14.sp, color: Colors.grey[800]))),
                        Text(
                            "Valor unitário: R\$" +
                                moneyFormat.format(product.price),
                            style: DosisStyle.regular(context).merge(TextStyle(
                                fontSize: 14.sp, color: Colors.grey[800]))),
                        Text(
                            "Valor total: R\$" +
                                moneyFormat.format(product.finalValue),
                            style: DosisStyle.regular(context).merge(TextStyle(
                                fontSize: 14.sp, color: Colors.grey[800]))),
                      ],
                    )),
                  ],
                ),
              ),
              Divider()
            ],
          );
  }
}
