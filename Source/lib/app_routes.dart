import 'package:get/get.dart';
import 'package:myportfolio/nest_view.dart';
import 'v1/pages/home.dart' as v1;
import 'v2/pages/home.dart' as v2;

class AppRoutes {
  static const nestview = '/';
  static const v1Home = '/v1';
  static const v2Home = '/v2';

  static final pages = [
    GetPage(name: nestview, page: () => NestView()),
    GetPage(name: v1Home, page: () => v1.HomePage()),
    GetPage(name: v2Home, page: () => v2.HomePage()),
  ];
}
