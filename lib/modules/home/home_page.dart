import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruitshop/modules/home/home_controller.dart';
import 'package:fruitshop/modules/product/product_controller.dart';
import 'package:fruitshop/modules/widgets/buttons/button_primary.dart';
import 'package:fruitshop/modules/widgets/scaffolds/regular_scaffold.dart';
import 'package:fruitshop/routes/app_pages.dart';
import 'package:fruitshop/theme/dosis_style.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(
      builder: (_controller) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: RegularScaffold(
            title: "Loja de Frutas",
            widget: Column(
              children: [
                Row(
                  children: [
                    optionContainer("Loja", "assets/shopping_cart.svg",
                        () => _controller.goToShop()),
                    Spacer(),
                    optionContainer("Pedidos", "assets/report.svg",
                        () => _controller.goToOrders()),
                  ],
                ),
                ButtonPrimary(
                  buttonText: 'Loja',
                  callback: () {},
                  isLoading: _controller.isLoading,
                )
              ],
            )),
      ),
    );
  }

  Widget optionContainer(String title, String asset, Function() goTo) {
    return GestureDetector(
      onTap: goTo,
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.pink, spreadRadius: 1.25),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SvgPicture.asset(
                asset,
                height: 80,
              ),
              SizedBox(
                height: 16,
              ),
              Text(title,
                  style: DosisStyle.bold(context)
                      .merge(TextStyle(fontSize: 16, color: Colors.pink))),
            ],
          ),
        ),
      ),
    );
  }
}
