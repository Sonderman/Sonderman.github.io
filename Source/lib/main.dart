import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:myportfolio/my_test_page.dart';
import 'package:myportfolio/pages/home.dart';

/// Main entry point of the Flutter application
///
/// Initializes Flutter bindings and screen utilities before running the app
/// Uses [WidgetsFlutterBinding] to ensure proper initialization
/// Uses [ScreenUtil] for responsive design across different screen sizes
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

/// Root application widget that sets up the responsive design and theme
///
/// Uses [ScreenUtilInit] to configure responsive behavior:
/// - designSize: Base design dimensions (1920x1080)
/// - minTextAdapt: Enables text size adaptation
/// - splitScreenMode: Supports split screen layouts
///
/// Configures [MaterialApp] with:
/// - Dark theme
/// - Disabled debug banner
/// - Home page set to [HomePage]
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// Builds the root application widget
  ///
  /// @param context The build context
  /// @return Configured [ScreenUtilInit] widget wrapping [MaterialApp]
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1080),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        title: 'Welcome',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColorDark: Colors.black,
          //fontFamily: "GoogleSansRegular",
        ),
        home: // const ProfilePage(),
            const HomePage(),
      ),
    );
  }
}

/// Test application widget used for development and testing
///
/// Simple [MaterialApp] configuration that shows [TestPage]
/// Disables debug banner for cleaner testing UI
class MyTestApp extends StatelessWidget {
  const MyTestApp({super.key});

  /// Builds the test application widget
  ///
  /// @param context The build context
  /// @return Configured [MaterialApp] pointing to [TestPage]
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: TestPage());
  }
}
