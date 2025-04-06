import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myportfolio/v2/pages/home.dart';
import 'package:myportfolio/v2/widgets/custom_cursor.dart';
import 'package:sizer/sizer.dart';

class V2Entry extends StatelessWidget {
  const V2Entry({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return ScreenUtilInit(
          designSize: const Size(1920, 1080),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, widget) {
            return CustomCursor(child: const HomePage());
          },
        );
      },
    );
  }
}
