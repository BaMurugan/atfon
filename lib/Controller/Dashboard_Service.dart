import 'package:autofon_seller/Other%20Service/ApiPath.dart';
import 'package:autofon_seller/Other%20Service/ApiService.dart';
import 'package:autofon_seller/Other%20Service/HiveStoreage.dart';
import 'package:get/get.dart';

import '../Module/Statistics_Module.dart';

class DashboadService extends GetxController {
  static Stream<Statistics> getData() async* {
    Map request = await ApiService.call(
      apiCallMethod: ApiCallMethod.post,
      path: ApiPaths.sellerStatistics,
      token: HiveService.getAuthToken(),
      body: {},
    );

    yield Statistics.fromMap(request['data']);
  }
}
