import 'dart:convert';

import 'package:get/get.dart';

import '../Module/NotificationData_Module.dart';
import '../Module/NotificationStatus_Module.dart';
import '../Other Service/ApiPath.dart';
import '../Other Service/ApiService.dart';
import '../Other Service/HiveStoreage.dart';
import 'Home_Service.dart';

class NotificationService extends GetxController {
  final profile = Get.find<HomeService>();
  late NotificationStatusModule notificationStatusModule;
  late NotificationDataModule notificationDataModule;
  int selectedIndex = 0;
  List notificationPages = [
    '?event=New+Enquiry',
    '?event=New+Order',
    '?event=Order+Completed',
    '?event=Shipment+Completed',
    '?event=Order+Shortage',
    '?event=Payment+Completed',
    '?event=Service+Request+Completed',
  ];

  Stream<void> instilize() async* {
    await getUser();
    await getNotification();
  }

  getUser() async {
    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.get,
      path: "${ApiPaths.sellerUsersUser}/${profile.profileData.id}",
      token: HiveService.getAuthToken(),
    );
    notificationStatusModule =
        notificationStatusModuleFromMap(jsonEncode(request));

    update();
  }

  updateStatus() async {
    notificationStatusModule.data!.notificationEnabled =
        !notificationStatusModule.data!.notificationEnabled!;
    update();
    final request = await ApiService.call(
        apiCallMethod: ApiCallMethod.put,
        path: ApiPaths.sellerUsersUpdateNotification,
        token: HiveService.getAuthToken(),
        body: {});
    update();
  }

  getNotification() async {
    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.get,
      path:
          '${ApiPaths.sellerUserNotification}${notificationPages[selectedIndex]}',
      token: HiveService.getAuthToken(),
    );
    notificationDataModule = notificationDataModuleFromMap(jsonEncode(request));
    update();
  }

  dismiss(String id) async {
    await ApiService.call(
        apiCallMethod: ApiCallMethod.put,
        path: '${ApiPaths.sellerUserNotification}/$id/dismiss',
        token: HiveService.getAuthToken(),
        body: {
          'params': {'userNotificationId': id}
        });
    await getNotification();
  }
}
