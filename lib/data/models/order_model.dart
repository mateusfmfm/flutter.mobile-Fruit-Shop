import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel{
  static const ORDER_VALUE = "orderValue";
  static const CREATED_AT = "createdAt";
  static const ORDER_PRODUCTS = "orderProducts";

   int? orderValue;
   Timestamp? createdAt;
   List<dynamic>? orderProducts;

  OrderModel({this.orderValue, this.createdAt, this.orderProducts,});

  OrderModel.fromMap(Map<String, dynamic> data){
    orderValue = data[ORDER_VALUE];
    createdAt = data[CREATED_AT];
    orderProducts = data[ORDER_PRODUCTS];
  }

}