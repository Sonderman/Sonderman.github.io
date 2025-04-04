import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myportfolio/globals.dart';

class ResumePage extends StatefulWidget {
  const ResumePage({super.key});

  @override
  State<ResumePage> createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
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
            "Resume",
            style: TextStyle(
              color: titleColor,
              fontSize: isMobile ? 80.sp : 30.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.h),
          Card(color: Colors.yellow, child: SizedBox(width: isMobile ? 180.w : 60.w, height: 10.h)),
          SizedBox(height: 20.h),
          educationTimeline(),
          SizedBox(height: 50.h),
          experienceTimeline(),
          SizedBox(height: 50.h),
          Text(
            "My Skills",
            style: TextStyle(
              color: titleColor,
              fontSize: isMobile ? 75.sp : 30.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.h),
          Card(
            shadowColor: Colors.white,
            elevation: 2,
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  skillItem(name: "Flutter", skillValue: 4),
                  SizedBox(height: 10.h),
                  skillItem(name: "Dart", skillValue: 4),
                  SizedBox(height: 10.h),
                  skillItem(name: "Unity Engine", skillValue: 3),
                  SizedBox(height: 10.h),
                  skillItem(name: "C#", skillValue: 4),
                  SizedBox(height: 10.h),
                  skillItem(name: "Java", skillValue: 3),
                  SizedBox(height: 10.h),
                  skillItem(name: "Firebase", skillValue: 4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget skillItem({required String name, required int skillValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: TextStyle(fontSize: isMobile ? 60.sp : 20.sp)),
        LinearProgressIndicator(
          value: skillValue * 0.2,
          borderRadius: BorderRadius.circular(20),
          color: Colors.yellow,
          backgroundColor: Colors.grey,
          minHeight: 12,
        ),
      ],
    );
  }

  Widget educationTimeline() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: isMobile ? 300.sp : 100.sp,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: isMobile ? 250.sp : 75.sp,
                    height: isMobile ? 250.sp : 75.sp,
                    child: Card(
                      color: const Color(0xff2B2B2C),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/icons/book.png", color: Colors.yellow),
                      ),
                    ),
                  ),
                  Container(height: 40.h, width: isMobile ? 10.sp : 1.sp, color: Colors.yellow),
                ],
              ),
            ),
            SizedBox(width: 30.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.sp),
                  Text(
                    "Education",
                    style: TextStyle(
                      color: titleColor,
                      fontSize: isMobile ? 100.sp : 40.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: isMobile ? 300.sp : 100.sp,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(radius: isMobile ? 50.sp : 15.sp, backgroundColor: Colors.yellow),
                  /*Container(
                    height: 60.h,
                    width: 1.w,
                    color: Colors.yellow,
                  ),*/
                ],
              ),
            ),
            SizedBox(width: 30.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Karabuk University, Karabuk/Turkey",
                    style: TextStyle(
                      color: titleColor,
                      fontSize: isMobile ? 75.sp : 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text("2015 - 2020", style: TextStyle(color: Colors.orange)),
                  SizedBox(height: 15.h),
                  const Text("Bachelor of Computer Engineering"),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget experienceTimeline() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: isMobile ? 300.sp : 100.sp,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: isMobile ? 250.sp : 75.sp,
                    height: isMobile ? 250.sp : 75.sp,
                    child: Card(
                      color: const Color(0xff2B2B2C),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/icons/suitcase.png", color: Colors.yellow),
                      ),
                    ),
                  ),
                  Container(height: 40.h, width: isMobile ? 10.sp : 1.sp, color: Colors.yellow),
                ],
              ),
            ),
            SizedBox(width: 30.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.sp),
                  Text(
                    "Experiences",
                    style: TextStyle(
                      color: titleColor,
                      fontSize: isMobile ? 100.sp : 40.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        experienceItem(
          title: "Flutter & Unity Game Developer | Freelancer",
          year: "Apr 2024 - Present",
          extras: "Have published 80+ apps on mobile platforms.",
        ),
        experienceItem(
          isLast: true,
          title: "Game Developer",
          year: "Mar 2023 - Mar 2024",
          extras: '''I took part in the development process of 2 mobile games.
  - Sky Wars Online: Istanbul
  - Zombie Rush Drive''',
        ),
      ],
    );
  }

  Row experienceItem({
    bool isLast = false,
    required String title,
    required String year,
    required String extras,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: isMobile ? 300.sp : 100.sp,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(radius: isMobile ? 50.sp : 15.sp, backgroundColor: Colors.yellow),
              if (!isLast)
                Container(height: 100.h, width: isMobile ? 10.sp : 1.sp, color: Colors.yellow),
            ],
          ),
        ),
        SizedBox(width: 30.w),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: titleColor,
                  fontSize: isMobile ? 75.sp : 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(year, style: const TextStyle(color: Colors.orange)),
              SizedBox(height: 15.h),
              Text(extras),
            ],
          ),
        ),
      ],
    );
  }
}
