import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

enum ProjectCategory { madeByMe, contributed }

enum ProjectType { app, game }

enum ProjectPlatform { android, ios, web, desktop }

class ProjectModel {
  String title;
  String description;
  ProjectType type;
  ProjectCategory category;
  ProjectPlatform platform;
  DateTime createdDate;
  List<String> images;
  String? githubLink;
  String? storeLink;
  Widget? playable;
  ProjectModel({
    required this.title,
    required this.description,
    required this.type,
    required this.category,
    required this.platform,
    required this.createdDate,
    required this.images,
    this.playable,
    this.githubLink,
    this.storeLink,
  });

  static Widget playButton(
      {required BuildContext context, required String gameFolder}) {
    return IconButton(
        onPressed: () {
          double frameHeight = 700.0;
          double frameWidth = 1000.0;
          String src =
              """<iframe width="100%" height="${frameHeight - 50}" style="border:none;" src="assets/assets/games/$gameFolder/index.html "></iframe>""";
          showDialog(
              context: context,
              builder: (dcontext) => AlertDialog(
                    content: WebViewX(
                      height: frameHeight,
                      width: frameWidth,
                      initialContent: src,
                      initialSourceType: SourceType.html,
                    ),
                  ));
        },
        icon: const Icon(
          Icons.play_arrow,
          color: Colors.green,
        ));
  }
}
