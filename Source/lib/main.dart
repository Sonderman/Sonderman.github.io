import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myportfolio/controllers/version_controller.dart';
import 'package:myportfolio/app_routes.dart';
import 'package:myportfolio/my_test_page.dart';

/// Main entry point of the Flutter application
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  setupServices();
  runApp(
    GetMaterialApp(
      title: 'Welcome',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true), // Apply the custom theme
      initialRoute: AppRoutes.v2Home, // Or AppRoutes.v2Home if preferred start
      getPages: AppRoutes.pages,
    ),
  );
}

void setupServices() {
  Get.put(VersionController(), permanent: true);
}

/// Test application widget
class MyTestApp extends StatelessWidget {
  const MyTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: TestPage());
  }
}
