import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruitshop/data/models/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final _isLoading = false.obs;
  set isLoading(value) => _isLoading.value = value;
  get isLoading => _isLoading.value;

  RxList<ProductModel> products = RxList<ProductModel>([]);

  @override
  onReady(){
    super.onReady();
    products.bindStream(getAllProducts());
  }

  Stream<List<ProductModel>> getAllProducts() => FirebaseFirestore.instance
      .collection("products")
      .snapshots()
      .map((query) =>
          query.docs.map((item) => ProductModel.fromMap(item.data())).toList());
}
