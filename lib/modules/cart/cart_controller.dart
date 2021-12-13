import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruitshop/data/models/product_model.dart';
import 'package:fruitshop/modules/product/product_controller.dart';
import 'package:fruitshop/routes/app_pages.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final _isLoading = false.obs;
  set isLoading(value) => _isLoading.value = value;
  get isLoading => _isLoading.value;

  ProductController productController = Get.put(ProductController());

  List<Map> orderProductsToJson() {
    var i;
    List<Map<String, dynamic>>? data = [];
    

    for (i = 0;
        i < productController.products.length;
        i == productController.products.length) {
      if (productController.products[i].counter != 0) {
        data.add({
          'name': productController.products[i].name,
          'counter': productController.products[i].counter,
          'finalValue': productController.products[i].finalValue,
          'price': productController.products[i].price
        });
      }
      i++;
    }
    return data;
  }

  Future<void> handleOrderCart() {
    isLoading = true;
    CollectionReference order = FirebaseFirestore.instance.collection('order');
    return order.add({
      'createdAt': DateTime.now(),
      'orderValue' : productController.finalValue,
      'orderProducts': orderProductsToJson(),
    }).then((value) {
      isLoading = false;
      print("cart Added");
      Get.toNamed(RoutesOrder.ORDER_RESUM);
    }).catchError((error) {
      isLoading = false;
      print("Failed to add cart: $error");
    });
  }
}
