import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myportfolio/globals.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  bool isMobile = false;
  @override
  Widget build(BuildContext context) {
    isMobile = 1.sw < 800;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About Me",
            style: TextStyle(
                color: titleColor,
                fontSize: isMobile ? 80.sp : 30.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.h,
          ),
          Card(
            color: Colors.yellow,
            child: SizedBox(
              width: isMobile ? 180.w : 60.w,
              height: 10.h,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            aboutText,
            style: TextStyle(
              color: textColor,
              fontSize: isMobile ? 70.sp : 20.sp,
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
            "What I'm Doing",
            style: TextStyle(
                color: titleColor,
                fontSize: isMobile ? 80.sp : 30.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30.h,
          ),
          isMobile
              ? Column(
                  children: widgetlist(),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widgetlist(),
                ),
        ],
      ),
    );
  }

  List<Widget> widgetlist() {
    return [
      Card(
        shadowColor: Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: isMobile ? 1200.w : 300.sp,
            child: Row(
              children: [
                Image.asset(
                  "assets/icons/phone.png",
                  width: isMobile ? 200.sp : 70.sp,
                ),
                SizedBox(
                  width: isMobile ? 50.w : 15.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mobile Applications",
                        style: TextStyle(
                            color: titleColor,
                            fontSize: isMobile ? 50.sp : 25.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        "Professional development of applications for iOS and Android.",
                        style: TextStyle(
                            color: textColor,
                            fontSize: isMobile ? 50.sp : 20.sp),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      SizedBox(
        width: 20.w,
        height: 20.h,
      ),
      Card(
        shadowColor: Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: isMobile ? 1200.w : 300.sp,
            child: Row(
              children: [
                Image.asset(
                  "assets/icons/game.png",
                  width: isMobile ? 200.sp : 75.sp,
                  color: Colors.yellow,
                ),
                SizedBox(
                  width: isMobile ? 60.w : 15.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mobile Games",
                        style: TextStyle(
                            color: titleColor,
                            fontSize: isMobile ? 50.sp : 25.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        "Professional development of Casual/Hypercasual games for iOS and Android.",
                        style: TextStyle(
                            color: textColor,
                            fontSize: isMobile ? 50.sp : 20.sp),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ];
  }
}
