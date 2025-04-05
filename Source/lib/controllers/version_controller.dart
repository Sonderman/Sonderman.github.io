import 'package:get/get.dart';

class VersionController extends GetxController {
  final currentVersion = 'v2'.obs;

  void switchVersion(String version) {
    currentVersion.value = version;
  }
}
