/// Activity preview page that displays GitHub activity in a WebView
///
/// Uses [WebViewX] to show GitHub profile page with loading indicator
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myportfolio/globals.dart';
import 'package:myportfolio/pages/activityPreview/activity_preview_controller.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class ActivityPreviewPage extends StatefulWidget {
  const ActivityPreviewPage({super.key});

  @override
  State<ActivityPreviewPage> createState() => _ActivityPreviewPageState();
}

class _ActivityPreviewPageState extends State<ActivityPreviewPage> {
  late final ActivityPreviewController controller;
  WebViewXController? webViewController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ActivityPreviewController());
    // Reset ready state and mobile check
    controller.isReady.value = false;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      controller.isMobile.value = 1.sw < 800;
    });
  }

  @override
  void dispose() {
    Get.delete<ActivityPreviewController>();
    webViewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Update mobile state based on current constraints
          final isMobile = constraints.maxWidth < 800;
          if (controller.isMobile.value != isMobile) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              controller.isMobile.value = isMobile;
            });
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Activity",
                style: TextStyle(
                  color: titleColor,
                  fontSize: isMobile ? 80.sp : 30.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              Card(
                color: Colors.yellow,
                child: SizedBox(width: isMobile ? 180.w : 60.w, height: 10.h),
              ),
              SizedBox(height: 40.h),
              Obx(
                () =>
                    controller.isReady.value
                        ? const SizedBox.shrink()
                        : const LinearProgressIndicator(color: Colors.yellow),
              ),
              WebViewX(
                height: 0.8.sh,
                width: 1.sw,
                initialContent:
                    "https://github.com/Sonderman/?t=${DateTime.now().millisecondsSinceEpoch}",
                initialSourceType: SourceType.urlBypass,
                javascriptMode: JavascriptMode.unrestricted,
                onPageStarted: (src) {
                  controller.isReady.value = false;
                },
                onWebViewCreated: (ctrl) {
                  webViewController = ctrl;
                },
                onPageFinished: (src) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    controller.isReady.value = true;
                  });
                  print("Page loaded: $src");
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
