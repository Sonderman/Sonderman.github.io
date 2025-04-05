import 'package:get/get.dart';
import 'package:myportfolio/nest_view.dart';
import 'package:myportfolio/v2/pages/about.dart';
import 'package:myportfolio/v2/pages/contact.dart';
import 'package:myportfolio/v2/pages/home.dart';
import 'package:myportfolio/v2/pages/projects.dart';
import 'package:myportfolio/v2/pages/resume.dart';
import 'package:myportfolio/v2/pages/activity.dart'; // Import ActivityPage

class AppRoutes {
  static const nestview = '/';
  static const about = '/about';
  static const resume = '/resume';
  static const projects = '/projects';
  static const contact = '/contact';
  static const activity = '/activity'; // Define activity route
  static const v2Home = '/v2';

  static final pages = [
    GetPage(name: nestview, page: () => NestView()),
    GetPage(name: about, page: () => AboutPage()),
    GetPage(name: resume, page: () => ResumePage()),
    GetPage(name: projects, page: () => ProjectsPage()),
    GetPage(name: contact, page: () => ContactPage()),
    GetPage(name: activity, page: () => ActivityPage()), // Add GetPage for Activity
    GetPage(name: v2Home, page: () => HomePage()),
  ];
}
