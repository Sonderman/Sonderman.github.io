import 'package:get/get.dart';
import '../app_routes.dart'; // Import route definitions

class VersionController extends GetxController {
  final currentVersion = 'v2'.obs;

  void switchVersion(String version) {
    currentVersion.value = version;
  }

  /// Switches the app version and performs a full navigation stack reset.
  /// This effectively restarts the app at the selected version's entry point.
  void switchVersionAndRestart(String version) {
    currentVersion.value = version;
    final targetRoute = version == 'v1' ? AppRoutes.v1Home : AppRoutes.v2Home;
    // Clear entire navigation stack and navigate to the selected version's home
    Get.offAllNamed(targetRoute);
  }
}
