import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../model/product/product.dart';

class CartApi {
  final db = FirebaseFirestore.instance;
  static const userCollection = "user";
  static const cartCollection = "cart";

  Stream<QuerySnapshot> init() {
    return db.collection(userCollection).snapshots();
  }

  Future<List<Product>> readDataFromCollection(String userId) async {
    QuerySnapshot querySnapshot = await db
        .collection(userCollection)
        .doc(userId)
        .collection(cartCollection)
        .get();
    final products = querySnapshot.docs.map((element) {
      return Product.fromJson(element.data() as Map<String, dynamic>);
    }).toList();

    return products;
  }

  Future<Product?> search(Product product, String userId) async {
    QuerySnapshot querySnapshot = await db
        .collection(userCollection)
        .doc(userId)
        .collection(cartCollection)
        .where('id', isEqualTo: product.id)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      return Product.fromJson(
          querySnapshot.docs.first.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future<void> createData(Product product, String userId) async {
    Product updateProduct = product;
    final productSearch = await search(product, userId);
    if (productSearch != null) {
      QuerySnapshot querySnapshot = await db
          .collection(userCollection)
          .doc(userId)
          .collection(cartCollection)
          .where('id', isEqualTo: product.id)
          .get();
      querySnapshot.docs.forEach((element) async {
        final productMap = (element.data() as Map<String, dynamic>);
        if (productMap["id"] == product.id) {
          productMap["quantity"] = productMap["quantity"] + 1;
          await element.reference.update(productMap);
        }
      });
    } else {
      final data = updateProduct.toJson();
      DocumentReference ref = await db
          .collection(userCollection)
          .doc(userId)
          .collection(cartCollection)
          .add(data);
    }
  }

  Future<void> removeData(Product product, String userId) async {
    final productSearch = await search(product, userId);
    if (productSearch != null) {
      QuerySnapshot querySnapshot = await db
          .collection(userCollection)
          .doc(userId)
          .collection(cartCollection)
          .where('id', isEqualTo: product.id)
          .get();

      querySnapshot.docs.forEach((element) async {
        final productMap = (element.data() as Map<String, dynamic>);
        if (productMap["id"] == product.id) {
          if (productMap["quantity"] > 1) {
            productMap["quantity"] = productMap["quantity"] - 1;
            await element.reference.update(productMap);
          } else {
            await element.reference.delete();
          }
        }
      });
    }
  }

  Future<void> removeAll(String userId) async {
    QuerySnapshot querySnapshot = await db
        .collection(userCollection)
        .doc(userId)
        .collection(cartCollection)
        .get();
    querySnapshot.docs.forEach((element) async {
      await element.reference.delete();
    });
  }
}
