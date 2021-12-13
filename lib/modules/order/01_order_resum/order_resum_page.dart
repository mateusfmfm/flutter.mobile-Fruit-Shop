import 'package:flutter/material.dart';
import 'package:fruitshop/data/models/product_model.dart';
import 'package:fruitshop/modules/product/product_controller.dart';
import 'package:fruitshop/modules/widgets/buttons/button_primary.dart';
import 'package:fruitshop/modules/widgets/scaffolds/regular_scaffold.dart';
import 'package:fruitshop/routes/app_pages.dart';
import 'package:fruitshop/theme/dosis_style.dart';
import 'package:get/get.dart';

class OrderResumPage extends StatefulWidget {
  const OrderResumPage({Key? key}) : super(key: key);

  @override
  _OrderResumPageState createState() => _OrderResumPageState();
}

class _OrderResumPageState extends State<OrderResumPage> {
  ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return RegularScaffold(
      showBackButton: false,
      title: 'Resumo do pedido',
      widget: Column(
        children: [
          Text(
              "Abaixo está o resumo da sua compra! Para baixar a versão PDF, clique no botão abaixo da tela.",
              style: DosisStyle.regular(context)
                  .merge(TextStyle(fontSize: 16, color: Colors.grey[800]))),
          SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: productController.products.map((ProductModel product) {
                return orderData(product);
              }).toList(),
            ),
          ),
          ButtonPrimary(
              buttonText: "Voltar para o início",
              callback: () {
                Get.delete<ProductController>();
                Get.until(ModalRoute.withName(RoutesHome.HOME));
              },
              isLoading: false)
        ],
      ),
    );
  }

  Widget orderData(ProductModel product) {
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
                            TextStyle(fontSize: 16, color: Colors.grey[800]))),
                    Spacer(),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Quantidade: " + product.counter.toString(),
                            style: DosisStyle.regular(context).merge(TextStyle(
                                fontSize: 14, color: Colors.grey[800]))),
                        Text("Valor unitário: " + product.price.toString(),
                            style: DosisStyle.regular(context).merge(TextStyle(
                                fontSize: 14, color: Colors.grey[800]))),
                        Text("Valor total: " + product.finalValue.toString(),
                            style: DosisStyle.regular(context).merge(TextStyle(
                                fontSize: 14, color: Colors.grey[800]))),
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
