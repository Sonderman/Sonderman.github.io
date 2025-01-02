import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myportfolio/globals.dart';
import 'package:myportfolio/pages/about_page.dart';
import 'package:myportfolio/pages/activity_preview_page.dart';
import 'package:myportfolio/pages/projects_page.dart';
import 'package:myportfolio/pages/resume_page.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 2;
  List pages = [
    const AboutPage(),
    const ResumePage(),
    const ProjectsPage(),
    const ActivityPreviewPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(child: LayoutBuilder(builder: (context, ori) {
        if (ori.maxWidth > 800) {
          return Center(
            child: SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(child: aboutCardWidget()),
                  SizedBox(
                    width: 30.w,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      headerWidget(),
                      SizedBox(
                        height: 30.h,
                      ),
                      Card(
                        shadowColor: Colors.white,
                        elevation: 2,
                        child: SizedBox(
                          width: 0.6.sw,
                          child: pages[selectedPage],
                        ),
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
                    SizedBox(
                      height: 30.sp,
                    ),
                    Card(
                      shadowColor: Colors.white,
                      elevation: 2,
                      child: SizedBox(
                        width: 0.9.sw,
                        child: pages[selectedPage],
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      })),
    );
  }

  Widget headerWidget() {
    TextStyle buttonTextStyle = TextStyle(
        color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold);
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
              SizedBox(
                width: 20.w,
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      selectedPage = 0;
                    });
                  },
                  child: Text(
                    "About",
                    style: selectedPage == 0
                        ? buttonTextStyle.copyWith(color: Colors.yellow)
                        : buttonTextStyle,
                  )),
              TextButton(
                  onPressed: () {
                    setState(() {
                      selectedPage = 1;
                    });
                  },
                  child: Text(
                    "Resume",
                    style: selectedPage == 1
                        ? buttonTextStyle.copyWith(color: Colors.yellow)
                        : buttonTextStyle,
                  )),
              TextButton(
                  onPressed: () {
                    setState(() {
                      selectedPage = 2;
                    });
                  },
                  child: Text(
                    "Projects",
                    style: selectedPage == 2
                        ? buttonTextStyle.copyWith(color: Colors.yellow)
                        : buttonTextStyle,
                  )),
              SizedBox(
                width: 20.w,
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      selectedPage = 3;
                    });
                  },
                  child: Text(
                    "Activity",
                    style: selectedPage == 3
                        ? buttonTextStyle.copyWith(color: Colors.yellow)
                        : buttonTextStyle,
                  )),
              SizedBox(
                width: 20.w,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomNavWidget() {
    TextStyle buttonTextStyle = TextStyle(
        color: Colors.white, fontSize: 60.sp, fontWeight: FontWeight.bold);
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
              SizedBox(
                width: 20.w,
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      selectedPage = 0;
                    });
                  },
                  child: Text(
                    "About",
                    style: selectedPage == 0
                        ? buttonTextStyle.copyWith(color: Colors.yellow)
                        : buttonTextStyle,
                  )),
              TextButton(
                  onPressed: () {
                    setState(() {
                      selectedPage = 1;
                    });
                  },
                  child: Text(
                    "Resume",
                    style: selectedPage == 1
                        ? buttonTextStyle.copyWith(color: Colors.yellow)
                        : buttonTextStyle,
                  )),
              TextButton(
                  onPressed: () {
                    setState(() {
                      selectedPage = 2;
                    });
                  },
                  child: Text(
                    "Projects",
                    style: selectedPage == 2
                        ? buttonTextStyle.copyWith(color: Colors.yellow)
                        : buttonTextStyle,
                  )),
              SizedBox(
                width: 20.w,
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      selectedPage = 3;
                    });
                  },
                  child: Text(
                    "Activity",
                    style: selectedPage == 3
                        ? buttonTextStyle.copyWith(color: Colors.yellow)
                        : buttonTextStyle,
                  )),
              SizedBox(
                width: 20.w,
              ),
            ],
          ),
        ),
      ),
    );
  }

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
                    child: Image.asset(
                      "assets/profileImage.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "Ali Haydar AYAR",
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.h,
              ),
              Card(
                color: const Color(0xff2B2B2C),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    profileTitle,
                    style: TextStyle(
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              const Divider(),
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  Card(
                    color: const Color(0xff2B2B2C),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0).w,
                      child: Icon(
                        Icons.mail_outline,
                        color: Colors.yellow,
                        size: 25.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "EMAIL",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SelectableText(
                        email,
                        maxLines: 2,
                        /*onTap: () {
                          launchUrl(Uri.parse("mailto:$email"));
                        },*/
                        style: TextStyle(fontSize: 15.sp),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  Card(
                    color: const Color(0xff2B2B2C),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0).w,
                      child: Icon(
                        Icons.location_on,
                        color: Colors.yellow,
                        size: 25.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "LOCATION",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SelectableText(
                        location,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 15.sp,
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
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
                      )),
                  IconButton(
                      onPressed: () {
                        launchUrl(Uri.parse(githubLink));
                      },
                      icon: Image.asset(
                        "assets/icons/github.png",
                        color: Colors.grey,
                        width: 25.sp,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

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
                SizedBox(
                  height: 700.sp,
                  child: AspectRatio(
                    aspectRatio: 3 / 4,
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0)),
                      child: Image.asset(
                        "assets/profileImage.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  "Ali Haydar AYAR",
                  style:
                      TextStyle(fontSize: 100.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Card(
                  color: const Color(0xff2B2B2C),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      profileTitle,
                      style: TextStyle(
                        fontSize: 60.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                const Divider(),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  children: [
                    Card(
                      color: const Color(0xff2B2B2C),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.mail_outline,
                          color: Colors.yellow,
                          size: 100.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "EMAIL",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SelectableText(
                          email,
                          maxLines: 2,
                          /*onTap: () {
                            launchUrl(Uri.parse("mailto:$email"));
                          },*/
                          style: TextStyle(fontSize: 50.sp),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  children: [
                    Card(
                      color: const Color(0xff2B2B2C),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.location_on,
                          color: Colors.yellow,
                          size: 100.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "LOCATION",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SelectableText(
                          location,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 50.sp,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
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
                        )),
                    IconButton(
                        onPressed: () {
                          launchUrl(Uri.parse(githubLink));
                        },
                        icon: Image.asset(
                          "assets/icons/github.png",
                          color: Colors.grey,
                          width: 80.sp,
                        )),
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
