import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/v2_theme.dart';
import '../models/project.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  IconData _getPlatformIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'mobile':
        return Icons.phone_android;
      case 'web':
        return Icons.web;
      default:
        return Icons.device_unknown;
    }
  }

  IconData _getLinkIcon(String linkType) {
    switch (linkType.toLowerCase()) {
      case 'playstore':
        return Icons.shop;
      case 'appstore':
        return Icons.apple;
      case 'github':
        return Icons.code;
      default:
        return Icons.link;
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return MouseRegion(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with fixed aspect ratio
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(V2Theme.borderRadiusMd)),
                child: AnimatedScale(
                  scale: _isHovered ? 1.05 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  child: Image.asset(
                    widget.project.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) =>
                            const Center(child: Icon(Icons.image_not_supported)),
                  ),
                ),
              ),
            ),
            // Content
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
                      ...widget.project.platforms.map(
                        (platform) => Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: Icon(
                            _getPlatformIcon(platform),
                            color: V2Colors.textMuted,
                            size: 18.sp,
                          ),
                        ),
                      ),
                      const Spacer(),
                      ...widget.project.links.entries.map(
                        (entry) => Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: InkWell(
                            onTap: () => _launchUrlHelper(entry.value),
                            borderRadius: BorderRadius.circular(20.r),
                            child: Container(
                              width: 30.w,
                              height: 30.h,
                              decoration: const BoxDecoration(
                                color: V2Colors.primaryLight,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _getLinkIcon(entry.key),
                                color: V2Colors.text,
                                size: 16.sp,
                              ),
                            ),
                          ),
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
    );
  }
}
