import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/v2_theme.dart';
import '../models/project_modelv2.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:math' as math;
import 'package:webviewx_plus/webviewx_plus.dart';
import 'package:myportfolio/v1/v1_configs.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  Future<void> _launchUrlHelper(String url) async {
    final Uri? launchUri = Uri.tryParse(url);
    if (launchUri == null || url == '#') {
      debugPrint('Invalid or placeholder URL: $url');
      return;
    }
    try {
      bool launched = await launchUrl(launchUri);
      if (!launched) {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL $url: $e');
    }
  }

  /// Shows a fullscreen image preview dialog with carousel.
  void _showImagePreviewDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Image Preview",
      transitionDuration: V2Theme.transitionSlow,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Container(
          color: Colors.black.withOpacity(0.9),
          child: SafeArea(
            child: Stack(
              children: [
                Center(
                  child: CarouselSlider(
                    items:
                        widget.project.images
                            .map(
                              (imagePath) => Image.asset(
                                imagePath,
                                fit: BoxFit.contain,
                                errorBuilder:
                                    (context, error, stackTrace) => const Center(
                                      child: Icon(Icons.image_not_supported, color: Colors.white),
                                    ),
                              ),
                            )
                            .toList(),
                    options: CarouselOptions(
                      viewportFraction: 1.0,
                      height: double.infinity,
                      enableInfiniteScroll: true,
                      enlargeCenterPage: false,
                      autoPlay: false,
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.white, size: 30),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
            child: child,
          ),
        );
      },
    );
  }

  /// Shows a detailed project overview dialog with animations.
  /// On mobile devices, the dialog is fullscreen for better usability.
  void _showProjectDetailsDialog(BuildContext context, bool isMobile) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Project Details",
      transitionDuration: V2Theme.transitionSlow,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: ScaleTransition(
              scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
              child: Container(
                width: isMobile ? MediaQuery.of(context).size.width : 600,
                height: isMobile ? MediaQuery.of(context).size.height : null,
                margin: isMobile ? EdgeInsets.zero : EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: V2Colors.card,
                  borderRadius: BorderRadius.circular(isMobile ? 0 : V2Theme.borderRadiusLg),
                  boxShadow: [V2Theme.shadowLg],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(isMobile ? 0 : V2Theme.borderRadiusLg),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.project.title,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: V2Colors.text,
                          ),
                        ),
                        SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: [
                            Chip(
                              label: Text(
                                widget.project.type.name.toUpperCase(),
                                style: TextStyle(color: V2Colors.text),
                              ),
                              backgroundColor: V2Colors.primaryLight,
                            ),
                            Chip(
                              label: Text(
                                widget.project.category.name.toUpperCase(),
                                style: TextStyle(color: V2Colors.text),
                              ),
                              backgroundColor: V2Colors.primaryLight,
                            ),
                            Chip(
                              label: Text(
                                "${widget.project.createdDate.year}-${widget.project.createdDate.month.toString().padLeft(2, '0')}-${widget.project.createdDate.day.toString().padLeft(2, '0')}",
                                style: TextStyle(color: V2Colors.text),
                              ),
                              backgroundColor: V2Colors.primaryLight,
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: GestureDetector(
                            onTap: () => _showImagePreviewDialog(context),
                            child:
                                widget.project.images.length > 1
                                    ? CarouselSlider(
                                      items:
                                          widget.project.images
                                              .map(
                                                (imagePath) => Image.asset(
                                                  imagePath,
                                                  fit: BoxFit.cover,
                                                  errorBuilder:
                                                      (context, error, stackTrace) => const Center(
                                                        child: Icon(Icons.image_not_supported),
                                                      ),
                                                ),
                                              )
                                              .toList(),
                                      options: CarouselOptions(
                                        viewportFraction: 1.0,
                                        height: double.infinity,
                                        autoPlay: true,
                                        autoPlayInterval: const Duration(seconds: 2),
                                        enableInfiniteScroll: true,
                                        enlargeCenterPage: false,
                                      ),
                                    )
                                    : Image.asset(
                                      widget.project.images.isNotEmpty
                                          ? widget.project.images[0]
                                          : '',
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Center(child: Icon(Icons.image_not_supported)),
                                    ),
                          ),
                        ),
                        SizedBox(height: 8),
                        ElevatedButton.icon(
                          onPressed: () => _showImagePreviewDialog(context),
                          icon: Icon(Icons.photo_library),
                          label: Text("View Images"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: V2Colors.secondary,
                            foregroundColor: V2Colors.primary,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          widget.project.description,
                          style: TextStyle(fontSize: 16, color: V2Colors.text),
                        ),
                        SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          children:
                              widget.project.platforms.map((platform) {
                                String label = platform.name.toUpperCase();
                                return Chip(
                                  label: Text(label, style: TextStyle(color: V2Colors.text)),
                                  backgroundColor: V2Colors.primaryLight,
                                );
                              }).toList(),
                        ),
                        SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          children: [
                            if (widget.project.githubLink != null)
                              ElevatedButton.icon(
                                onPressed: () => _launchUrlHelper(widget.project.githubLink!),
                                icon: Icon(Icons.code),
                                label: Text("GitHub"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: V2Colors.secondary,
                                  foregroundColor: V2Colors.primary,
                                ),
                              ),
                            if (widget.project.storeLinks != null)
                              ...widget.project.storeLinks!.asMap().entries.map((entry) {
                                final url = entry.value;
                                final idx = entry.key;
                                final platform =
                                    (widget.project.platforms.length > idx)
                                        ? widget.project.platforms[idx]
                                        : ProjectPlatform.android;
                                final assetPath =
                                    platform == ProjectPlatform.android
                                        ? "assets/icons/google_play.png"
                                        : "assets/icons/app_store.png";
                                return IconButton(
                                  onPressed: () => _launchUrlHelper(url),
                                  icon: Image.asset(assetPath, width: 30),
                                  tooltip: 'Store Link',
                                );
                              }),
                            if (widget.project.playableAssetPath != null)
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.of(context).pop();

                                  double frameHeight = 700.0;
                                  double frameWidth = 1000.0;
                                  String src =
                                      """<iframe width="100%" height="${frameHeight - 50}" style="border:none;" src="games/${widget.project.playableAssetPath!}/index.html "></iframe>""";
                                  String src2 =
                                      """<iframe width="100%" height="${frameHeight - 50}" style="border:none;" src="assets/games/${widget.project.playableAssetPath!}/index.html "></iframe>""";

                                  showDialog(
                                    context: context,
                                    builder:
                                        (dcontext) => AlertDialog(
                                          content: SizedBox(
                                            height: frameHeight,
                                            width: frameWidth,
                                            child: WebViewX(
                                              height: frameHeight,
                                              width: frameWidth,
                                              initialContent: isDebug ? src2 : src,
                                              initialSourceType: SourceType.html,
                                            ),
                                          ),
                                        ),
                                  );
                                },
                                icon: Icon(Icons.play_arrow),
                                label: Text("Play Demo"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: V2Colors.secondary,
                                  foregroundColor: V2Colors.primary,
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("Close"),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: V2Colors.text,
                              side: BorderSide(color: V2Colors.secondary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return GestureDetector(
      onTap: () => _showProjectDetailsDialog(context, isMobile),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: V2Colors.card,
            borderRadius: BorderRadius.circular(V2Theme.borderRadiusMd),
            boxShadow: _isHovered ? [V2Theme.shadowLg] : [V2Theme.shadowMd],
          ),
          clipBehavior: Clip.antiAlias,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(V2Theme.borderRadiusMd),
                    ),
                    child: AnimatedScale(
                      scale: _isHovered ? 1.05 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      child:
                          widget.project.images.length > 1
                              ? CarouselSlider(
                                items:
                                    widget.project.images
                                        .map(
                                          (imagePath) => Image.asset(
                                            imagePath,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) => const Center(
                                                  child: Icon(Icons.image_not_supported),
                                                ),
                                          ),
                                        )
                                        .toList(),
                                options: CarouselOptions(
                                  viewportFraction: 1.0,
                                  height: double.infinity,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 2),
                                  enableInfiniteScroll: true,
                                  enlargeCenterPage: false,
                                ),
                              )
                              : Image.asset(
                                widget.project.images.isNotEmpty ? widget.project.images[0] : '',
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) =>
                                        const Center(child: Icon(Icons.image_not_supported)),
                              ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        widget.project.title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: V2Colors.text,
                        ),
                        minFontSize: 12,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Icon(
                            widget.project.type == ProjectType.game
                                ? Icons.games
                                : Icons.phone_android,
                            size: math.max(24, 30.sp),
                          ),
                          const Spacer(),
                          if (widget.project.githubLink != null)
                            IconButton(
                              onPressed: () => _launchUrlHelper(widget.project.githubLink!),
                              icon: Image.asset(
                                "assets/icons/github.png",
                                color: V2Colors.text,
                                width: math.max(24, 30.sp),
                              ),
                              tooltip: 'GitHub',
                            ),
                          if (widget.project.storeLinks != null)
                            ...widget.project.storeLinks!.asMap().entries.map((entry) {
                              final url = entry.value;
                              final idx = entry.key;
                              final platform =
                                  (widget.project.platforms.length > idx)
                                      ? widget.project.platforms[idx]
                                      : ProjectPlatform.android;
                              final assetPath =
                                  platform == ProjectPlatform.android
                                      ? "assets/icons/google_play.png"
                                      : "assets/icons/app_store.png";
                              return IconButton(
                                onPressed: () => _launchUrlHelper(url),
                                icon: Image.asset(assetPath, width: math.max(24, 30.sp)),
                                tooltip: 'Store Link',
                              );
                            }),
                          if (widget.project.playableAssetPath != null && !isMobile)
                            Padding(
                              padding: EdgeInsets.only(left: 12.w),
                              child: ProjectModel.playButton(
                                context: context,
                                gameFolder: widget.project.playableAssetPath!,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
