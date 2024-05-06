import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late WebViewXController webviewController;
  String src =
      """<iframe style="width: 100%; height: 800px; border: 0 ;scrolling=no " src="assets/assets/games/platformer/index.html"></iframe>""";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Divider(
              color: Colors.black,
              height: 5,
            ),
            WebViewX(
              height: 1000,
              width: 1200,
              initialContent: src,
              initialSourceType: SourceType.html,
              onWebViewCreated: (controller) {
                webviewController = controller;
              },
            ),
            const Divider(
              color: Colors.black,
              height: 5,
            ),
          ],
        ));
  }
}
