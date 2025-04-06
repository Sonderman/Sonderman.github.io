import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myportfolio/controllers/version_controller.dart';
import 'package:myportfolio/v1/entry.dart';
import 'package:myportfolio/v2/entry.dart';
import 'package:myportfolio/v2/theme/v2_theme.dart';

class NestView extends StatelessWidget {
  const NestView({super.key});

  @override
  Widget build(BuildContext context) {
    final version = Get.find<VersionController>().currentVersion;
    return SafeArea(
      child: Obx(() {
        bool isV1 = version.value == "v1";
        return Stack(
          children: [
            isV1 ? V1Entry() : Theme(data: buildV2Theme(), child: V2Entry()),
            Align(
              alignment: isV1 ? Alignment.topRight : Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Theme(
                  data: ThemeData.dark(),
                  child: Material(
                    elevation: 8,
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Switch to ${isV1 ? "v2" : "v1"}"),
                          Switch(
                            value: version.value == "v1",
                            onChanged: (value) {
                              final newVersion = value ? "v1" : "v2";
                              version.value = newVersion;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
