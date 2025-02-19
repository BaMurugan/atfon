import 'package:hive_flutter/hive_flutter.dart';

import 'Hive_constants.dart';

class HiveService {
  static initDatabase() async {
    await Hive.initFlutter();
    await Hive.openBox(HiveConstants.appDataDb);
  }

  static String getAuthToken() {
    return Hive.box(HiveConstants.appDataDb)
        .get(HiveConstants.authToken, defaultValue: '');
  }

  static saveAuthToken(String token) {
    Hive.box(HiveConstants.appDataDb).put(HiveConstants.authToken, token);
  }

  static deleteAuthToken() {
    Hive.box(HiveConstants.appDataDb).delete(HiveConstants.authToken);
  }

  static List<String> getAgreedTermsVersions() {
    return Hive.box(HiveConstants.appDataDb).get(
          HiveConstants.agreedTermsAndConditionVersions,
        ) ??
        <String>[];
  }

  static saveAgreedTermsVersion(String version) {
    Hive.box(HiveConstants.appDataDb)
        .put(HiveConstants.agreedTermsAndConditionVersions, [
      ...getAgreedTermsVersions(),
      version,
    ]);
  }

  static clearAgreedTermsVersions() {
    Hive.box(HiveConstants.appDataDb)
        .delete(HiveConstants.agreedTermsAndConditionVersions);
  }
}
