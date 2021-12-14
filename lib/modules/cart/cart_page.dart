import 'package:flutter/material.dart';
import 'package:fruitshop/data/models/product_model.dart';
import 'package:fruitshop/modules/cart/cart_controller.dart';
import 'package:fruitshop/modules/product/product_controller.dart';
import 'package:fruitshop/modules/widgets/buttons/button_primary.dart';
import 'package:fruitshop/modules/widgets/scaffolds/regular_scaffold.dart';
import 'package:fruitshop/routes/app_pages.dart';
import 'package:fruitshop/theme/dosis_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  ProductController productController = Get.put(ProductController());
  CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    final moneyFormat = NumberFormat("#,##0.00", "pt_BR");
    return WillPopScope(
      onWillPop: () {
        productController.finalValue = 0;
        return Future.value(true);
      },
      child: RegularScaffold(
        title: "Carrinho de compras",
        widget: Column(
          children: [
            Expanded(
              child: ListView(
                children:
                    productController.products.map((ProductModel product) {
                  return productDataInCart(product);
                }).toList(),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Valor total: ",
                    style: DosisStyle.regular(context).merge(
                        TextStyle(fontSize: 16.sp, color: Colors.grey[800]))),
                Text("R\$" + moneyFormat.format(productController.finalValue),
                    style: DosisStyle.bold(context)
                        .merge(TextStyle(fontSize: 16.sp, color: Colors.red))),
              ],
            ),
            SizedBox(height: 16),
            ButtonPrimary(
                buttonText: "Confirmar compra",
                callback: () {
                  cartController.handleOrderCart();
                },
                isLoading: cartController.isLoading),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                productController.finalValue = 0;
                Get.toNamed(RoutesProduct.PRODUCT_LIST);
              },
              child: Text("Editar",
                  style: DosisStyle.bold(context).merge(TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[800],
                    decoration: TextDecoration.underline,
                  ))),
            ),
          ],
        ),
      ),
    );
  }

  Widget productDataInCart(ProductModel product) {
    final moneyFormat = NumberFormat("#,##0.00", "pt_BR");
    return product.counter == 0
        ? Container()
        : Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                product.counter.toString() +
                                    "x " +
                                    product.name!,
                                style: DosisStyle.bold(context).merge(TextStyle(
                                    fontSize: 16.sp, color: Colors.grey[800]))),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Spacer(),
                                Text("Valor final: ",
                                    style: DosisStyle.regular(context).merge(
                                        TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.grey[800]))),
                                Text(
                                    "R\$" +
                                        moneyFormat.format(product.finalValue),
                                    style: DosisStyle.regular(context).merge(
                                        TextStyle(
                                            fontSize: 14.sp, color: Colors.red))),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              )
            ],
          );
  }
}
