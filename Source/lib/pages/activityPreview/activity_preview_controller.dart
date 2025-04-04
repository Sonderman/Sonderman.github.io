import 'package:get/get.dart';

class ActivityPreviewController extends GetxController {
  /// Flag indicating if WebView has finished loading
  RxBool isReady = false.obs;

  /// Flag indicating mobile layout
  RxBool isMobile = false.obs;
}
