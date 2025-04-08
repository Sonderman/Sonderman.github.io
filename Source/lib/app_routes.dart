import 'package:get/get.dart';
import 'package:myportfolio/v1/entry.dart';
import 'package:myportfolio/v2/entry.dart';

class AppRoutes {
  static const v1Home = '/v1';
  static const v2Home = '/v2';

  static final pages = [
    GetPage(name: v1Home, page: () => V1Entry()),
    GetPage(name: v2Home, page: () => V2Entry()),
  ];
}
