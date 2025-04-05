import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myportfolio/controllers/version_controller.dart';
import 'package:myportfolio/v1/entry.dart';
import 'package:myportfolio/v2/entry.dart';

class NestView extends StatelessWidget {
  const NestView({super.key});

  @override
  Widget build(BuildContext context) {
    final version = Get.find<VersionController>().currentVersion;
    return SafeArea(
      child: Obx(() {
        return Stack(
          children: [
            version.value == "v1" ? V1Entry() : V2Entry(),
            Positioned(
              right: 20,
              top: 20,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Switch(
                    value: version.value == "v1",
                    onChanged: (value) {
                      final newVersion = value ? "v1" : "v2";
                      version.value = newVersion;
                    },
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
