import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myportfolio/globals.dart';
import 'package:webviewx/webviewx.dart';

class ActivityPreviewPage extends StatefulWidget {
  const ActivityPreviewPage({super.key});

  @override
  State<ActivityPreviewPage> createState() => _ActivityPreviewPageState();
}

class _ActivityPreviewPageState extends State<ActivityPreviewPage> {
  bool isReady = false;
  bool isMobile = false;
  @override
  Widget build(BuildContext context) {
    isMobile = 1.sw < 800;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Activity",
            style: TextStyle(
                color: titleColor,
                fontSize: isMobile ? 80.sp : 30.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.h,
          ),
          Card(
            color: Colors.yellow,
            child: SizedBox(
              width: isMobile ? 180.w : 60.w,
              height: 10.h,
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          if (!isReady)
            const LinearProgressIndicator(
              color: Colors.yellow,
            ),
          WebViewX(
            height: 1500.h,
            width: 1.sw,
            initialContent: "https://github.com/Sonderman/",
            initialSourceType: SourceType.urlBypass,
            onPageFinished: (src) {
              setState(() {
                isReady = true;
              });
            },
          ),
        ],
      ),
    );
  }
}
