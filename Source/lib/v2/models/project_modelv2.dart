import 'package:flutter/material.dart';
import 'package:myportfolio/v1/v1_configs.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

/// Enum representing project ownership category
enum ProjectCategory { madeByMe, contributed }

/// Enum representing project type
enum ProjectType { app, game }

/// Enum representing supported platforms
enum ProjectPlatform { android, ios, web, desktop }

/// Model class representing a project, shared between V1 and V2
class ProjectModel {
  String title;
  String description;
  ProjectType type;
  ProjectCategory category;
  List<ProjectPlatform> platforms;
  DateTime createdDate;
  List<String> images;
  String? githubLink;
  List<String>? storeLinks;
  String? playableAssetPath;

  ProjectModel({
    required this.title,
    required this.description,
    required this.type,
    required this.category,
    required this.platforms,
    required this.createdDate,
    required this.images,
    this.playableAssetPath,
    this.githubLink,
    this.storeLinks,
  });

  /// Static helper to generate a playable button widget
  static Widget playButton({required BuildContext context, required String gameFolder}) {
    return Tooltip(
      message: "Play",
      child: IconButton(
        onPressed: () {
          double frameHeight = 700.0;
          double frameWidth = 1000.0;
          String src =
              """<iframe width="100%" height="${frameHeight - 50}" style="border:none;" src="games/$gameFolder/index.html "></iframe>""";
          String src2 =
              """<iframe width="100%" height="${frameHeight - 50}" style="border:none;" src="assets/games/$gameFolder/index.html "></iframe>""";

          showDialog(
            context: context,
            builder:
                (dcontext) => AlertDialog(
                  content: WebViewX(
                    height: frameHeight,
                    width: frameWidth,
                    initialContent: isDebug ? src2 : src,
                    initialSourceType: SourceType.html,
                  ),
                ),
          );
        },
        icon: const Icon(Icons.play_arrow, color: Colors.green),
      ),
    );
  }
}
