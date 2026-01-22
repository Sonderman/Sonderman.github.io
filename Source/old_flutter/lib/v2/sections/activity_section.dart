import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:http/http.dart' as http;
import 'package:myportfolio/v2/data/personal_datas.dart';
import 'package:myportfolio/v2/theme/v2_theme.dart';
import 'package:myportfolio/v2/widgets/section_header.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

/// ActivitySection displays GitHub profile info, contribution graph, and repositories.
/// Now dynamically fetches GitHub profile data like v1.
class ActivitySection extends StatefulWidget {
  const ActivitySection({super.key});

  @override
  State<ActivitySection> createState() => _ActivitySectionState();
}

class _ActivitySectionState extends State<ActivitySection> {
  /// Loading state for GitHub profile fetch
  bool _isLoading = true;

  /// Error message if fetch fails
  String? _error;

  /// GitHub profile data
  Map<String, dynamic>? _profileData;

  /// Loading state for repositories fetch
  bool _reposLoading = true;

  /// Error message if repo fetch fails
  String? _reposError;

  /// List of repositories
  List<Map<String, dynamic>> _repositories = [];

  /// GitHub username
  final String _username = 'Sonderman';

  @override
  void initState() {
    super.initState();
    _fetchGitHubProfile();
    _fetchRepositories();
  }

  /// Fetch GitHub profile data from API
  Future<void> _fetchGitHubProfile() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final url = Uri.parse('https://api.github.com/users/$_username');
      final response = await http.get(url);

      if (!mounted) return;

      if (response.statusCode == 200) {
        setState(() {
          _profileData = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'Failed to load profile: ${response.statusCode} ${response.reasonPhrase}';
          _isLoading = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Failed to load profile: $e';
        _isLoading = false;
      });
    }
  }

  /// Fetch user's repositories from GitHub API
  Future<void> _fetchRepositories() async {
    if (!mounted) return;

    setState(() {
      _reposLoading = true;
      _reposError = null;
    });

    try {
      final url = Uri.parse('https://api.github.com/users/$_username/repos?per_page=100');
      final response = await http.get(url);

      if (!mounted) return;

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        // Sort repos by updated date descending
        data.sort((a, b) {
          final aDate = DateTime.tryParse(a['updated_at'] ?? '') ?? DateTime(1970);
          final bDate = DateTime.tryParse(b['updated_at'] ?? '') ?? DateTime(1970);
          return bDate.compareTo(aDate);
        });
        // Take top 5 recent repos
        final recentRepos =
            data.take(5).map<Map<String, dynamic>>((repo) => repo as Map<String, dynamic>).toList();

        setState(() {
          _repositories = recentRepos;
          _reposLoading = false;
        });
      } else {
        setState(() {
          _reposError =
              'Failed to load repositories: ${response.statusCode} ${response.reasonPhrase}';
          _reposLoading = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _reposError = 'Failed to load repositories: $e';
        _reposLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: V2Colors.primaryLight,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 80.h),
        child: Column(
          children: [
            const SectionHeader(title: 'Activity'),
            SizedBox(height: 40.h),

            // GitHub Profile Section
            Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24.w),
                  margin: EdgeInsets.only(bottom: 40.h),
                  decoration: BoxDecoration(
                    color: V2Colors.card,
                    borderRadius: BorderRadius.circular(V2Theme.borderRadiusMd),
                    boxShadow: [V2Theme.shadowMd],
                  ),
                  child:
                      _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : _error != null
                          ? Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Text(
                                _error!,
                                style: TextStyle(color: Colors.red, fontSize: 16.sp),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                          : _profileData != null
                          ? _buildProfileCard(_profileData!)
                          : const Text('No data available'),
                )
                .animate()
                .fadeIn(duration: 600.ms)
                .slideY(begin: 0.2, duration: 600.ms, curve: Curves.easeOut),

            // GitHub Contributions Graph
            Container(
                  padding: EdgeInsets.all(16.w),
                  margin: EdgeInsets.only(bottom: 40.h),
                  decoration: BoxDecoration(
                    color: V2Colors.card,
                    borderRadius: BorderRadius.circular(V2Theme.borderRadiusMd),
                    boxShadow: [V2Theme.shadowMd],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(V2Theme.borderRadiusMd - 4.r),
                    child: Center(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final width = constraints.maxWidth * 0.8;
                          final screenHeight = MediaQuery.of(context).size.height;
                          final bool isWideScreen = width > 1200;
                          final double containerHeight =
                              isWideScreen
                                  ? screenHeight *
                                      0.8 // 80% of screen height on wide screens
                                  : screenHeight * 0.6; // 60% on smaller screens

                          return SizedBox(
                            width: width,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: containerHeight),
                              child: WebViewX(
                                width: width,
                                height: containerHeight,
                                initialSourceType: SourceType.html,
                                initialContent: githubAll(),
                                ignoreAllGestures: isWideScreen ? true : false,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
                .animate()
                .fadeIn(duration: 600.ms, delay: 100.ms)
                .slideY(begin: 0.2, duration: 600.ms, delay: 100.ms, curve: Curves.easeOut),

            // GitHub Repositories List
            Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: V2Colors.card,
                    borderRadius: BorderRadius.circular(V2Theme.borderRadiusMd),
                    boxShadow: [V2Theme.shadowMd],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        'Recent Repositories',
                        style: TextStyle(
                          fontFamily: V2Fonts.heading,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: V2Colors.text,
                        ),
                        minFontSize: 10,
                      ),
                      SizedBox(height: 20.h),
                      if (_reposLoading)
                        const Center(child: CircularProgressIndicator())
                      else if (_reposError != null)
                        Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Text(
                            _reposError!,
                            style: TextStyle(color: Colors.red, fontSize: 16.sp),
                            textAlign: TextAlign.center,
                          ),
                        )
                      else if (_repositories.isEmpty)
                        Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Text(
                            'No repositories found.',
                            style: TextStyle(fontSize: 16.sp, color: V2Colors.textMuted),
                          ),
                        )
                      else
                        LayoutBuilder(
                          builder: (context, constraints) {
                            bool isWide = constraints.maxWidth > 600;
                            return Wrap(
                              spacing: 20.w,
                              runSpacing: 20.h,
                              children:
                                  _repositories.map((repo) {
                                    return Container(
                                      width:
                                          isWide
                                              ? (constraints.maxWidth - 20.w) / 2
                                              : constraints.maxWidth,
                                      padding: EdgeInsets.all(16.w),
                                      decoration: BoxDecoration(
                                        color: V2Colors.primaryLight,
                                        borderRadius: BorderRadius.circular(12.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.05),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              final url =
                                                  'https://github.com/Sonderman/${repo['name']}';
                                              _launchUrlHelper(url);
                                            },
                                            child: AutoSizeText(
                                              repo['name'] ?? 'No name',
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold,
                                                color: V2Colors.accent1,
                                                decoration: TextDecoration.underline,
                                                decorationColor: V2Colors.accent1,
                                              ),
                                              minFontSize: 12,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          AutoSizeText(
                                            repo['description'] ?? 'No description',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: V2Colors.textMuted,
                                            ),
                                            minFontSize: 10,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 12.h),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.circle,
                                                color: _getLanguageColor(repo['language'] ?? ''),
                                                size: 12.sp,
                                              ),
                                              SizedBox(width: 6.w),
                                              AutoSizeText(
                                                repo['language'] ?? 'Unknown',
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: V2Colors.textMuted,
                                                ),
                                                minFontSize: 10,
                                              ),
                                              SizedBox(width: 16.w),
                                              Icon(
                                                Icons.star_border,
                                                color: V2Colors.secondary,
                                                size: 14.sp,
                                              ),
                                              SizedBox(width: 4.w),
                                              AutoSizeText(
                                                (repo['stargazers_count'] ?? 0).toString(),
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: V2Colors.textMuted,
                                                ),
                                                minFontSize: 10,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                            );
                          },
                        ),
                      SizedBox(height: 20.h),
                      Align(
                        alignment: Alignment.center,
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.open_in_new, size: 16),
                          label: const AutoSizeText('View All Repositories', minFontSize: 10),
                          onPressed:
                              () =>
                                  _launchUrlHelper('https://github.com/Sonderman?tab=repositories'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: V2Colors.secondary,
                            side: BorderSide(color: V2Colors.secondary.withOpacity(0.5)),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                .animate()
                .fadeIn(duration: 600.ms, delay: 200.ms)
                .slideY(begin: 0.2, duration: 600.ms, delay: 200.ms, curve: Curves.easeOut),
          ],
        ),
      ),
    );
  }

  /// Build GitHub profile card with avatar, name, username, bio, stats, and button
  Widget _buildProfileCard(Map<String, dynamic> data) {
    final String avatarUrl = data['avatar_url'] ?? '';
    final String name = data['name'] ?? _username;
    final String login = data['login'] ?? _username;
    final String bio = data['bio'] ?? 'No bio available.';
    final int followers = data['followers'] ?? 0;
    final int following = data['following'] ?? 0;
    final int publicRepos = data['public_repos'] ?? 0;
    final String profileUrl = data['html_url'] ?? 'https://github.com/$_username';

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWide = constraints.maxWidth > 600;

        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (avatarUrl.isNotEmpty)
                ClipOval(
                  child: Image.network(
                    avatarUrl,
                    width: (constraints.maxWidth * 0.15).clamp(80.0, 150.0),
                    height: (constraints.maxWidth * 0.15).clamp(80.0, 150.0),
                    fit: BoxFit.cover,
                    loadingBuilder:
                        (context, child, progress) =>
                            progress == null ? child : const CircularProgressIndicator(),
                    errorBuilder:
                        (context, error, stackTrace) => Icon(
                          Icons.person,
                          size: (constraints.maxWidth * 0.15).clamp(80.0, 150.0),
                        ),
                  ),
                ),
              SizedBox(width: 20.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      name,
                      style: TextStyle(
                        fontFamily: V2Fonts.heading,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: V2Colors.text,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      '@$login',
                      style: TextStyle(fontSize: 16.sp, color: V2Colors.textMuted),
                      maxLines: 1,
                    ),
                    SizedBox(height: 10.h),
                    AutoSizeText(bio, style: TextStyle(fontSize: 16.sp, color: V2Colors.text)),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        _buildStatItem(Icons.people_outline, '$followers followers'),
                        SizedBox(width: 10.w),
                        _buildStatItem(Icons.person_outline, '$following following'),
                        SizedBox(width: 10.w),
                        _buildStatItem(Icons.book_outlined, '$publicRepos repositories'),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.link),
                      label: const AutoSizeText('View on GitHub'),
                      onPressed: () => _launchUrlHelper(profileUrl),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: V2Colors.secondary,
                        foregroundColor: V2Colors.primary,
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                        textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (avatarUrl.isNotEmpty)
                ClipOval(
                  child: Image.network(
                    avatarUrl,
                    width: (constraints.maxWidth * 0.3).clamp(80.0, 120.0),
                    height: (constraints.maxWidth * 0.3).clamp(80.0, 120.0),
                    fit: BoxFit.cover,
                    loadingBuilder:
                        (context, child, progress) =>
                            progress == null ? child : const CircularProgressIndicator(),
                    errorBuilder:
                        (context, error, stackTrace) => Icon(
                          Icons.person,
                          size: (constraints.maxWidth * 0.3).clamp(80.0, 120.0),
                        ),
                  ),
                ),
              SizedBox(height: 15.h),
              AutoSizeText(
                name,
                style: TextStyle(
                  fontFamily: V2Fonts.heading,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: V2Colors.text,
                ),
                textAlign: TextAlign.center,
              ),
              AutoSizeText(
                '@$login',
                style: TextStyle(fontSize: 14.sp, color: V2Colors.textMuted),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              AutoSizeText(
                bio,
                style: TextStyle(fontSize: 14.sp, color: V2Colors.text),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15.h),
              Wrap(
                spacing: 10.w,
                runSpacing: 5.h,
                alignment: WrapAlignment.center,
                children: [
                  _buildStatItem(Icons.people_outline, '$followers followers'),
                  _buildStatItem(Icons.person_outline, '$following following'),
                  _buildStatItem(Icons.book_outlined, '$publicRepos repositories'),
                ],
              ),
              SizedBox(height: 15.h),
              ElevatedButton.icon(
                icon: const Icon(Icons.link),
                label: const AutoSizeText('View on GitHub'),
                onPressed: () => _launchUrlHelper(profileUrl),
                style: ElevatedButton.styleFrom(
                  backgroundColor: V2Colors.secondary,
                  foregroundColor: V2Colors.primary,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  /// Build a stat item with icon and text
  Widget _buildStatItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16.sp, color: V2Colors.textMuted),
        SizedBox(width: 4.w),
        AutoSizeText(text, style: TextStyle(fontSize: 14.sp, color: V2Colors.textMuted)),
      ],
    );
  }

  /// Helper to launch URLs safely
  Future<void> _launchUrlHelper(String url) async {
    final Uri? launchUri = Uri.tryParse(url);
    if (launchUri == null) {
      debugPrint('Invalid URL: $url');
      return;
    }
    try {
      bool launched = await launchUrl(launchUri, mode: LaunchMode.externalApplication);
      if (!launched) {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL $url: $e');
    }
  }

  /// Get color for language dot
  Color _getLanguageColor(String language) {
    switch (language.toLowerCase()) {
      case 'dart':
        return Colors.blue.shade300;
      case 'c#':
        return Colors.green.shade400;
      case 'javascript':
        return Colors.yellow.shade600;
      default:
        return V2Colors.textMuted;
    }
  }
}
