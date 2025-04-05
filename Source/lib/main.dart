import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myportfolio/controllers/version_controller.dart';
import 'package:myportfolio/app_routes.dart';
import 'package:myportfolio/my_test_page.dart';
import 'package:myportfolio/v2/theme/app_theme.dart';
import 'package:myportfolio/v2/widgets/preloader.dart'; // Import Preloader
import 'package:myportfolio/v2/widgets/custom_cursor.dart'; // Import CustomCursor

/// Main entry point of the Flutter application
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  setupServices();
  runApp(const MyApp());
}

void setupServices() {
  Get.put(VersionController(), permanent: true);
}

/// Root application widget
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true; // State to control preloader visibility

  void _handleLoadingComplete() {
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // ScreenUtilInit should wrap GetMaterialApp
    return ScreenUtilInit(
      designSize: const Size(1920, 1080),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use the builder to ensure ScreenUtil is initialized before GetMaterialApp builds
      builder: (context, child) {
        // GetMaterialApp is the root providing Directionality
        return GetMaterialApp(
          title: 'Welcome',
          debugShowCheckedModeBanner: false,
          theme: buildAppTheme(), // Apply the custom theme
          initialRoute: AppRoutes.nestview, // Or AppRoutes.v2Home if preferred start
          getPages: AppRoutes.pages,
          // Use GetMaterialApp's builder to insert widgets within the MaterialApp context
          builder: (context, navigator) {
            // This builder runs within the GetMaterialApp context
            return Stack(
              // Stack to overlay Preloader
              children: [
                // CustomCursor wraps the actual page content (navigator)
                CustomCursor(
                  child: navigator ?? const SizedBox.shrink(), // Handle null navigator
                ),
                // Conditionally display Preloader on top
                if (_isLoading) Preloader(onLoadingComplete: _handleLoadingComplete),
              ],
            );
          },
        );
      },
    );
  }
}

/// Test application widget
class MyTestApp extends StatelessWidget {
  const MyTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: TestPage());
  }
}
