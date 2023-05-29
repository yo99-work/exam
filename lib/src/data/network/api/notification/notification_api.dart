import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../model/notification/notification.dart';

class NotificationApi {
  final db = FirebaseFirestore.instance;
  static const collection = "notification";

  Stream<QuerySnapshot> init() {
    return db.collection(collection).snapshots();
  }

  Future<List<Notification>> readDataFromCollection(String userId) async {
    QuerySnapshot querySnapshot = await db
        .collection(collection)
        .get();
    final notifications = querySnapshot.docs.map((element) {
      return Notification.fromJson(element.data() as Map<String, dynamic>);
    }).toList();
    return notifications;
  }
}
