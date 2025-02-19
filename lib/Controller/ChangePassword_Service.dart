import 'package:autofon_seller/Controller/Home_Service.dart';
import 'package:autofon_seller/Other%20Service/ApiPath.dart';
import 'package:autofon_seller/Other%20Service/ApiService.dart';
import 'package:autofon_seller/Other%20Service/HiveStoreage.dart';
import 'package:get/get.dart';

class ChangePasswordService extends GetxController {
  final homeController = Get.find<HomeService>();
  changePassword(String currentPassword, String newPassword) async {
    try {
      final request = await ApiService.call(
          apiCallMethod: ApiCallMethod.post,
          path: ApiPaths.sellerChangePassword,
          token: HiveService.getAuthToken(),
          body: {
            'phone': homeController.profileData.phone,
            'currentPassword': currentPassword,
            'newPassword': newPassword,
          });
      Get.snackbar("Success", "Password Changed Successfully",
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
