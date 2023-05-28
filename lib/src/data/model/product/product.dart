import 'dart:ffi';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:exam/src/widgets/product_tag.dart';

class Product extends Equatable {
  int? id;
  String? title;
  String? description;
  num? price;
  num? discountPercentage;
  num? rating;
  num? stock;
  String? brand;
  String? category;
  String? thumbnail;
  List<String>? images;

  int? quantity = 1;

  int getPriceByQuantity() {
    return  (price as int) * (quantity ?? 1);
  }

  //Mock
  bool isFlashSale = false;
  List<ProductTagType> tags = [];


  Product(
      this.id,
        this.title,
        this.description,
        this.price,
        this.discountPercentage,
        this.rating,
        this.stock,
        this.brand,
        this.category,
        this.thumbnail,
        this.images);

  //Mock

  void setIsFlashSale() {
    isFlashSale = true;
  }

  String getPriceWithNumericPattern() {
    int newPrice = price?.toInt() ?? 0;
    return convertToHuman(newPrice);
  }


  static String convertToHuman(int price) {
    String amount = price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
    return "\$$amount";
  }

  static String convertToHumanD(double price) {
    String amount = price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
    return "\$$amount";
  }

  void autoGenerateTag() {
    List<ProductTagType> myList = [ProductTagType.bigSale, ProductTagType.cashBack, ProductTagType.freeDelivery];
    tags = getRandomItems(myList, 2);
  }

  //mock
  List<ProductTagType> getRandomItems(List<ProductTagType> list, int count) {
    List<ProductTagType> randomItems = [];
    Random random = Random();

    while (randomItems.length < count) {
      int randomIndex = random.nextInt(list.length);
      ProductTagType randomItem = list[randomIndex];
      if (!randomItems.contains(randomItem)) {
        randomItems.add(randomItem);
      }
    }
    return randomItems;
  }


  @override
  List<Object?> get props => [id, quantity];

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    discountPercentage = json['discountPercentage'];
    rating = json['rating'];
    stock = json['stock'];
    brand = json['brand'];
    category = json['category'];
    thumbnail = json['thumbnail'];
    quantity = json['quantity'];
    images = json['images'].cast<String>();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['discountPercentage'] = discountPercentage;
    data['rating'] = rating;
    data['stock'] = stock;
    data['brand'] = brand;
    data['category'] = category;
    data['thumbnail'] = thumbnail;
    data['images'] = images;
    data['quantity'] = quantity ?? 1;
    return data;
  }
}
