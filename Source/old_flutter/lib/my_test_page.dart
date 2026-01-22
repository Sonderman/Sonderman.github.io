import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 0.2.sh,
              width: 0.2.sh,
              color: Colors.black,
            ),
            Container(
              height: 0.2.sh,
              width: 0.2.sh,
              color: Colors.blue,
            ),
            Container(
              height: 0.2.sh,
              width: 0.2.sh,
              color: Colors.yellow,
            ),
          ],
        ));
  }
}
