import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myportfolio/v1/pages/home.dart';

class V1Entry extends StatelessWidget {
  const V1Entry({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1080),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use the builder to ensure ScreenUtil is initialized before GetMaterialApp builds
      builder: (context, child) {
        // GetMaterialApp is the root providing Directionality
        return HomePage();
      },
    );
  }
}
