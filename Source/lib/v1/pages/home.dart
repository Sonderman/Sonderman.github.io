import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myportfolio/v1/globals.dart';
import 'package:myportfolio/v1/pages/about_page.dart';
import 'package:myportfolio/v1/pages/activity_page.dart';
import 'package:myportfolio/v1/pages/projects_page.dart';
import 'package:myportfolio/v1/pages/resume_page.dart';
import 'package:url_launcher/url_launcher.dart';

/// Home page widget that manages navigation between different sections
///
/// Sections include:
/// - About
/// - Resume
/// - Projects
/// - Activity Preview
///
/// Uses [StatefulWidget] to manage current page selection
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

/// State class for [HomePage] that manages:
/// - Current selected page index
/// - Page content widgets
/// - Responsive layout switching
/// - Navigation UI
class _HomePageState extends State<HomePage> {
  /// Currently selected page index (0-3)
  int selectedPage = 0;

  /// List of page widgets that can be displayed
  ///
  /// Ordered as: About, Resume, Projects, Activity Preview
  List pages = [const AboutPage(), const ResumePage(), const ProjectsPage(), const ActivityPage()];

  /// Builds the responsive home page layout
  ///
  /// Uses [LayoutBuilder] to determine screen width and switch between:
  /// - Desktop layout (side-by-side about card and content)
  /// - Mobile layout (stacked about card and content with bottom nav)
  ///
  /// @param context The build context
  /// @return Scaffold with appropriate layout for current screen size
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, ori) {
            if (ori.maxWidth > 800) {
              return Center(
                child: SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(children: [SizedBox(height: 160.h), aboutCardWidget()]),
                      SizedBox(width: 30.w),
                      Column(
                        children: [
                          SizedBox(height: 30.h),
                          headerWidget(),
                          SizedBox(height: 30.h),
                          Card(
                            shadowColor: Colors.white,
                            elevation: 2,
                            child: SizedBox(width: 0.6.sw, child: pages[selectedPage]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Scaffold(
                bottomNavigationBar: bottomNavWidget(),
                body: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        aboutCardWidgetMobile(),
                        SizedBox(height: 30.sp),
                        Card(
                          shadowColor: Colors.white,
                          elevation: 2,
                          child: SizedBox(width: 0.9.sw, child: pages[selectedPage]),
                        ),
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  /// Builds the desktop navigation header widget
  ///
  /// Contains text buttons for switching between pages
  /// Highlights currently selected page with yellow color
  ///
  /// @return Card widget with horizontal row of navigation buttons
  Widget headerWidget() {
    TextStyle buttonTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
    );

    return SizedBox(
      height: 100.h,
      child: Card(
        shadowColor: Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Row'un minimum alan kaplamasını sağladık
            children: [
              Flexible(
                // Expanded yerine Flexible kullandık
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 20.w),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          selectedPage = 0;
                        });
                      },
                      child: Text(
                        "About",
                        style:
                            selectedPage == 0
                                ? buttonTextStyle.copyWith(color: Colors.yellow)
                                : buttonTextStyle,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          selectedPage = 1;
                        });
                      },
                      child: Text(
                        "Resume",
                        style:
                            selectedPage == 1
                                ? buttonTextStyle.copyWith(color: Colors.yellow)
                                : buttonTextStyle,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          selectedPage = 2;
                        });
                      },
                      child: Text(
                        "Projects",
                        style:
                            selectedPage == 2
                                ? buttonTextStyle.copyWith(color: Colors.yellow)
                                : buttonTextStyle,
                      ),
                    ),
                    SizedBox(width: 20.w),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          selectedPage = 3;
                        });
                      },
                      child: Text(
                        "Activity",
                        style:
                            selectedPage == 3
                                ? buttonTextStyle.copyWith(color: Colors.yellow)
                                : buttonTextStyle,
                      ),
                    ),
                    SizedBox(width: 20.w),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the mobile bottom navigation widget
  ///
  /// Similar to [headerWidget] but optimized for mobile screens
  /// Uses larger text sizes for better touch targets
  ///
  /// @return Card widget with bottom navigation buttons
  Widget bottomNavWidget() {
    TextStyle buttonTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 60.sp,
      fontWeight: FontWeight.bold,
    );
    return SizedBox(
      height: 100.h,
      child: Card(
        shadowColor: Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 20.w),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedPage = 0;
                  });
                },
                child: Text(
                  "About",
                  style:
                      selectedPage == 0
                          ? buttonTextStyle.copyWith(color: Colors.yellow)
                          : buttonTextStyle,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedPage = 1;
                  });
                },
                child: Text(
                  "Resume",
                  style:
                      selectedPage == 1
                          ? buttonTextStyle.copyWith(color: Colors.yellow)
                          : buttonTextStyle,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedPage = 2;
                  });
                },
                child: Text(
                  "Projects",
                  style:
                      selectedPage == 2
                          ? buttonTextStyle.copyWith(color: Colors.yellow)
                          : buttonTextStyle,
                ),
              ),
              SizedBox(width: 20.w),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedPage = 3;
                  });
                },
                child: Text(
                  "Activity",
                  style:
                      selectedPage == 3
                          ? buttonTextStyle.copyWith(color: Colors.yellow)
                          : buttonTextStyle,
                ),
              ),
              SizedBox(width: 20.w),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the desktop about card widget
  ///
  /// Displays:
  /// - Profile image
  /// - Name and title
  /// - Contact information
  /// - Social media links
  ///
  /// @return Card widget with profile information (fixed width for desktop)
  Widget aboutCardWidget() {
    return SizedBox(
      width: 350.w,
      child: Card(
        shadowColor: Colors.white,
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 300.sp,
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    child: Image.asset("assets/profileImage.png", fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Text(
                "Ali Haydar AYAR",
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              Card(
                color: const Color(0xff2B2B2C),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(profileTitle, style: TextStyle(fontSize: 18.sp)),
                ),
              ),
              SizedBox(height: 30.h),
              const Divider(),
              SizedBox(height: 30.h),
              Row(
                children: [
                  Card(
                    color: const Color(0xff2B2B2C),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0).w,
                      child: Icon(Icons.mail_outline, color: Colors.yellow, size: 25.sp),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("EMAIL", style: TextStyle(color: Colors.grey)),
                      SelectableText(
                        email,
                        maxLines: 2,
                        /*onTap: () {
                          launchUrl(Uri.parse("mailto:$email"));
                        },*/
                        style: TextStyle(fontSize: 15.sp),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Row(
                children: [
                  Card(
                    color: const Color(0xff2B2B2C),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0).w,
                      child: Icon(Icons.location_on, color: Colors.yellow, size: 25.sp),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("LOCATION", style: TextStyle(color: Colors.grey)),
                      SelectableText(location, maxLines: 2, style: TextStyle(fontSize: 15.sp)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      launchUrl(Uri.parse(linkedinLink));
                    },
                    icon: Image.asset(
                      "assets/icons/linkedin.png",
                      color: Colors.grey,
                      width: 25.sp,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      launchUrl(Uri.parse(githubLink));
                    },
                    icon: Image.asset("assets/icons/github.png", color: Colors.grey, width: 25.sp),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the mobile about card widget
  ///
  /// Similar to [aboutCardWidget] but with:
  /// - Larger text sizes
  /// - Full width layout
  /// - Adjusted spacing for mobile
  ///
  /// @return Card widget with profile information (full width for mobile)
  Widget aboutCardWidgetMobile() {
    return Padding(
      padding: EdgeInsets.only(top: 100.sp),
      child: SizedBox(
        width: 1000.w,
        child: Card(
          shadowColor: Colors.white,
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.all(20.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10.h),
                SizedBox(
                  height: 700.sp,
                  child: AspectRatio(
                    aspectRatio: 3 / 4,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                      child: Image.asset("assets/profileImage.png", fit: BoxFit.cover),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  "Ali Haydar AYAR",
                  style: TextStyle(fontSize: 100.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.h),
                Card(
                  color: const Color(0xff2B2B2C),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(profileTitle, style: TextStyle(fontSize: 60.sp)),
                  ),
                ),
                SizedBox(height: 30.h),
                const Divider(),
                SizedBox(height: 30.h),
                Row(
                  children: [
                    Card(
                      color: const Color(0xff2B2B2C),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.mail_outline, color: Colors.yellow, size: 100.sp),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("EMAIL", style: TextStyle(color: Colors.grey)),
                        SelectableText(
                          email,
                          maxLines: 2,
                          /*onTap: () {
                            launchUrl(Uri.parse("mailto:$email"));
                          },*/
                          style: TextStyle(fontSize: 50.sp),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Row(
                  children: [
                    Card(
                      color: const Color(0xff2B2B2C),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.location_on, color: Colors.yellow, size: 100.sp),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("LOCATION", style: TextStyle(color: Colors.grey)),
                        SelectableText(location, maxLines: 2, style: TextStyle(fontSize: 50.sp)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        launchUrl(Uri.parse(linkedinLink));
                      },
                      icon: Image.asset(
                        "assets/icons/linkedin.png",
                        color: Colors.grey,
                        width: 80.sp,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        launchUrl(Uri.parse(githubLink));
                      },
                      icon: Image.asset(
                        "assets/icons/github.png",
                        color: Colors.grey,
                        width: 80.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
