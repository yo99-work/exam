import 'package:exam/src/data/model/notification/notification.dart';
import 'package:exam/src/data/network/api/notification/notification_api.dart';

class NotificationRepository {
  final NotificationApi notificationApi;

  NotificationRepository({ required this.notificationApi});

  Future<List<Notification>> getNotification(String userId) async {
    try {
      final response = await notificationApi.readDataFromCollection(userId);
      return response;
    } catch (e) {
      throw e;
    }
  }
}