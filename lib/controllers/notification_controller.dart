
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class NotificationController extends GetxController {
  var notifications = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    notifications.value = [
      {
        "title": "Payment Successful",
        "message": "Your payment of ₹500 is completed",
        "time": "10 min ago",
        "isRead": false,
      },
      {
        "title": "New Offer",
        "message": "Get 20% cashback on next recharge",
        "time": "1 hour ago",
        "isRead": true,
      },
      {
        "title": "Account Update",
        "message": "Your profile has been updated successfully",
        "time": "Yesterday",
        "isRead": true,
      },
    ];
  }

  void markAsRead(int index) {
    notifications[index]["isRead"] = true;
    notifications.refresh();
  }

  void clearAll() {
    notifications.clear();
  }
}
