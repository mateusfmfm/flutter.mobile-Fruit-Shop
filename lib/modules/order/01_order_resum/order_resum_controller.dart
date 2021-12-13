import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruitshop/data/models/order_model.dart';
import 'package:get/get.dart';

class OrderResumController extends GetxController {
  RxList<OrderModel> orders = RxList<OrderModel>([]);

  @override
  onReady() {
    super.onReady();
    orders.bindStream(getAllOrders());
  }

  Stream<List<OrderModel>> getAllOrders() => FirebaseFirestore.instance
      .collection("order")
      .snapshots()
      .map((query) =>
          query.docs.map((item) => OrderModel.fromMap(item.data())).toList());
}
