import 'package:diacritic/diacritic.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fruitshop/data/models/product_model.dart';
import 'package:fruitshop/modules/product/product_controller.dart';
import 'package:fruitshop/modules/widgets/buttons/button_primary.dart';
import 'package:fruitshop/modules/widgets/scaffolds/regular_scaffold.dart';
import 'package:fruitshop/modules/widgets/text_fields/text_field_search.dart';
import 'package:fruitshop/routes/app_pages.dart';
import 'package:fruitshop/theme/dosis_style.dart';
import 'package:get/get.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return GetX<ProductController>(
      builder: (_controller) => RegularScaffold(
        showBackButton: false,
        title: "Lista de produtos",
        widget: productController.isLoading
            ? const Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                ),
              )
            : Column(
                children: [
                  TextFieldSearch(
                    callback: (text) {
                      _controller.textFilter.value = (removeDiacritics(text));
                    },
                    placeHolder: "Buscar produto",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: ListView(
                      children: productController.productListFiltered
                          .map((ProductModel product) {
                        return productContainer(product);
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ButtonPrimary(
                    buttonText: "Adicionar ao carrinho",
                    callback: () {
                      productController.goToCart();
                    },
                    isLoading: false,
                    fontSize: 16,
                  )
                ],
              ),
      ),
    );
  }

  Widget productContainer(ProductModel product) {
    return Column(
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
                Container(
                  child: Image.network(
                    product.imageUrl!,
                    width: 100,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name!,
                          style: DosisStyle.bold(context).merge(TextStyle(
                              fontSize: 16, color: Colors.grey[800]))),
                      SizedBox(height: 8),
                      Text(product.description!,
                          style: DosisStyle.regular(context).merge(TextStyle(
                              fontSize: 14, color: Colors.grey[800]))),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text("R\$${product.price.toString()},00",
                              style: DosisStyle.bold(context).merge(
                                  TextStyle(fontSize: 16, color: Colors.red))),
                          Spacer(),
                          GestureDetector(
                            child: Icon(Icons.remove_circle_rounded),
                            onTap: product.counter == 0
                                ? () {}
                                : () {
                                    setState(() {
                                      product.counter = product.counter! - 1;
                                    });
                                    product.finalValue =
                                        product.counter! * product.price!;
                                  },
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(product.counter.toString(),
                                style: DosisStyle.bold(context).merge(TextStyle(
                                    fontSize: 16, color: Colors.grey[800]))),
                          ),
                          GestureDetector(
                            child: Icon(Icons.add_circle_rounded),
                            onTap: () {
                              setState(() {
                                product.counter = product.counter! + 1;
                              });
                              product.finalValue =
                                  product.counter! * product.price!;
                            },
                          )
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
