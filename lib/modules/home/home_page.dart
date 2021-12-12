import 'package:flutter/material.dart';
import 'package:fruitshop/modules/home/home_controller.dart';
import 'package:fruitshop/modules/product/product_controller.dart';
import 'package:fruitshop/modules/widgets/buttons/button_primary.dart';
import 'package:fruitshop/modules/widgets/scaffolds/regular_scaffold.dart';
import 'package:fruitshop/routes/app_pages.dart';
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
                Text("Bem vindo!"),
                Container(
                  width: 200,
                  child: ButtonPrimary(
                    buttonText: "Loja",
                    callback: () {
                      Get.toNamed(RoutesProduct.PRODUCT_LIST);
                    },
                    isLoading: _controller.isLoading,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
