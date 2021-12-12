class ProductModel{
  // static const ID = "id";
  static const IMAGEURL = "imageUrl";
  static const DESCRIPTION = "description";
  static const NAME = "name";
  static const PRICE = "price";

  //  String? id;
   String? imageUrl;
   String? description;
   String? name;
   int? price;
   int? counter = 0;

  ProductModel({this.imageUrl, this.description, this.name, this.price});

  ProductModel.fromMap(Map<String, dynamic> data){
    // id = data[ID];
    imageUrl = data[IMAGEURL];
    description = data[DESCRIPTION];
    name = data[NAME];
    price = data[PRICE];
  }

}