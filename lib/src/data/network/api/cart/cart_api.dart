import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../model/product/product.dart';

class CartApi {
  final db = FirebaseFirestore.instance;
  static const collectName = "CART";

  Stream<QuerySnapshot> init() {
    return db.collection(collectName).snapshots();
  }

  Future<List<Product>> readDataFromCollection() async {

    QuerySnapshot querySnapshot = await db.collection(collectName).get();
    final products = querySnapshot.docs.map((element) {
     return Product.fromJson(element?.data() as Map<String, dynamic>);

    }).toList();

    print("THAT ALL PRODUCT ${products}");
    return products;

  }

  Future<String> createData(Product product) async {
    final data = product.toJson();
    DocumentReference ref = await db.collection(collectName).add(data);
    print(ref.id);
    return ref.id;
  }
  //
  // Future<List<Product>> readData(String id) async {
  //   List<Product> myDataList = [];
  //   final test = await db.collection('CART').get().then((values) {
  //     values.docChanges.forEach((element) { })
  //   });
  //   test.
  //   return [];
  //   // print(snapshot.data['name']);
  // }
  //
  // void updateData(DocumentSnapshot doc) async {
  //   await db.collection('CRUD').document(doc.documentID).updateData({'todo': 'please 🤫'});
  // }
  //
  // void deleteData(DocumentSnapshot doc) async {
  //   await db.collection('CRUD').document(doc.documentID).delete();
  // }

  // Should not be inside here but probably inside a todoObject
  // String randomTodo() {
  //   final randomNumber = Random().nextInt(4);
  //   String todo;
  //   switch (randomNumber) {
  //     case 1:
  //       todo = 'Like and subscribe 💩';
  //       break;
  //     case 2:
  //       todo = 'Twitter @robertbrunhage 🤣';
  //       break;
  //     case 3:
  //       todo = 'Patreon in the description 🤗';
  //       break;
  //     default:
  //       todo = 'Leave a comment 🤓';
  //       break;
  //   }
  //   return todo;
  // }
}

// CartApi db = CartApi();