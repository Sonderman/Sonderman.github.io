import 'dart:convert'; // Required for json decoding
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'package:myportfolio/globals.dart';
import 'package:auto_size_text/auto_size_text.dart'; // Import the auto_size_text package
import 'package:url_launcher/url_launcher.dart';
import 'package:webviewx_plus/webviewx_plus.dart'; // For launching URLs

/// A page widget that displays a preview of a GitHub profile fetched from the GitHub API.
///
/// This widget fetches user data from `https://api.github.com/users/Sonderman`
/// and displays key information like avatar, name, bio, followers, and public repos.
class ActivityPage extends StatefulWidget {
  /// Creates an [ActivityPage] widget.
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

/// State class for [ActivityPage].
///
/// Manages the state related to fetching and displaying GitHub profile data:
/// - Loading state (_isLoading)
/// - Error state (_error)
/// - Fetched profile data (_profileData)
class _ActivityPageState extends State<ActivityPage> {
  /// Indicates whether data is currently being fetched.
  bool _isLoading = true;

  /// Stores any error message encountered during fetching. Null if no error.
  String? _error;

  /// Stores the fetched GitHub profile data as a Map. Null if not fetched yet or error occurred.
  Map<String, dynamic>? _profileData;

  /// The GitHub username to fetch data for.
  final String _username = 'Sonderman';

  /// Fetches the GitHub profile data from the API when the widget is initialized.
  @override
  void initState() {
    super.initState();
    _fetchGitHubProfile();
  }

  /// Asynchronous function to fetch profile data from the GitHub API.
  ///
  /// Updates the state based on the API response (success, error, loading).
  Future<void> _fetchGitHubProfile() async {
    // Ensure the widget is still mounted before updating state.
    if (!mounted) return;

    // Set loading state to true initially.
    setState(() {
      _isLoading = true;
      _error = null; // Clear previous errors
    });

    try {
      // Construct the API URL.
      final url = Uri.parse('https://api.github.com/users/$_username');
      // Make the GET request.
      final response = await http.get(url);

      // Check if the widget is still mounted after the async operation.
      if (!mounted) return;

      // Handle the response based on the status code.
      if (response.statusCode == 200) {
        // Successful response: decode JSON and update state.
        setState(() {
          _profileData = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        // Error response: update state with error message.
        setState(() {
          _error = 'Failed to load profile: ${response.statusCode} ${response.reasonPhrase}';
          _isLoading = false;
        });
      }
    } catch (e) {
      // Handle network or other exceptions.
      if (!mounted) return;
      setState(() {
        _error = 'Failed to load profile: $e';
        _isLoading = false;
      });
    }
  }

  /// Builds the main content of the page based on the current state.
  ///
  /// Displays:
  /// - A loading indicator if [_isLoading] is true.
  /// - An error message if [_error] is not null.
  /// - The profile information if data was fetched successfully ([_profileData] is not null).
  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_isLoading) {
      // Display a loading indicator while fetching data.
      content = const Center(child: CircularProgressIndicator());
    } else if (_error != null) {
      // Display an error message if fetching failed.
      content = Center(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Text(
            _error!,
            style: TextStyle(color: Colors.red, fontSize: 16.sp),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else if (_profileData != null) {
      // Display the fetched profile data if successful.
      content = _buildProfileView(_profileData!);
    } else {
      // Fallback case (should ideally not happen).
      content = Center(child: Text('No data available.', style: TextStyle(fontSize: 16.sp)));
    }

    // Return the content within a container, adjusting height as needed.
    // Using Padding adds some space around the content.
    return Container(
      padding: EdgeInsets.all(20.w),
      // Set a minimum height or use constraints if needed for layout.
      // height: 600.h, // You might adjust or remove fixed height
      constraints: BoxConstraints(minHeight: 400.h), // Example minimum height
      child: content,
    );
  }

  /// Builds the UI widget to display the fetched GitHub profile information.
  ///
  /// @param data The Map containing the profile data from the API.
  /// @return A widget (typically a Column or ListView) displaying the profile details.
  Widget _buildProfileView(Map<String, dynamic> data) {
    // Use LayoutBuilder for responsiveness.
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWide = constraints.maxWidth > 600; // Example breakpoint

        // Pass constraints to the layout methods
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            // Allow scrolling if content overflows
            child:
                isWide
                    ? _buildWideLayout(data, constraints)
                    : _buildNarrowLayout(data, constraints),
          ),
        );
      },
    );
  }

  /// Builds the layout for wider screens (e.g., desktop).
  /// @param data The profile data.
  /// @param constraints The layout constraints provided by LayoutBuilder.
  Widget _buildWideLayout(Map<String, dynamic> data, BoxConstraints constraints) {
    final String avatarUrl = data['avatar_url'] ?? '';
    final String name = data['name'] ?? _username;
    final String login = data['login'] ?? _username;
    final String bio = data['bio'] ?? 'No bio available.';
    final int followers = data['followers'] ?? 0;
    final int following = data['following'] ?? 0;
    final int publicRepos = data['public_repos'] ?? 0;
    final String profileUrl = data['html_url'] ?? 'https://github.com/$_username';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          "Activity",
          style: TextStyle(color: titleColor, fontSize: 30.sp, fontWeight: FontWeight.bold),
          maxLines: 1, // Ensure title doesn't wrap unexpectedly
        ),
        SizedBox(height: 20.h),
        // Use constraints for the yellow card width
        Card(color: Colors.yellow, child: SizedBox(width: 60.w, height: 10.h)),
        SizedBox(height: 40.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar - Make size relative to constraints
            if (avatarUrl.isNotEmpty)
              ClipOval(
                child: Image.network(
                  avatarUrl,
                  // Use constraints, clamp size between min/max values if needed
                  width: (constraints.maxWidth * 0.2).clamp(80.0, 150.0),
                  height: (constraints.maxWidth * 0.2).clamp(80.0, 150.0),
                  fit: BoxFit.cover,
                  // Optional: Add loading/error builders for the image
                  loadingBuilder:
                      (context, child, progress) =>
                          progress == null ? child : const CircularProgressIndicator(),
                  errorBuilder:
                      (context, error, stackTrace) =>
                          Icon(Icons.person, size: (constraints.maxWidth * 0.2).clamp(80.0, 150.0)),
                ),
              ),
            SizedBox(width: 20.w),

            // Profile Details - Wrap in Expanded to take available horizontal space
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    name,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ), // Added missing parenthesis
                    maxLines: 1,
                  ),
                  AutoSizeText(
                    '@$login',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey,
                    ), // Added missing parenthesis
                    maxLines: 1,
                  ),
                  SizedBox(height: 10.h),
                  AutoSizeText(
                    bio,
                    style: TextStyle(fontSize: 16.sp),
                  ), // Ensure this one is also AutoSizeText
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
                    onPressed: () => _launchURL(profileUrl),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueGrey, // Text color
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
        // Make WebViewX height relative to screen height and wrap in Center
        Center(
          child: WebViewX(
            width: constraints.maxWidth, // Use constraints for width
            height: constraints.maxWidth * 0.8, // Adjust height proportionally
            initialSourceType: SourceType.html,
            initialContent: githubAll(isMobile: false),
            ignoreAllGestures: true, // Corrected indentation and placement
          ),
        ),
      ],
    );
  }

  /// Builds the layout for narrower screens (e.g., mobile).
  /// @param data The profile data.
  /// @param constraints The layout constraints provided by LayoutBuilder.
  Widget _buildNarrowLayout(Map<String, dynamic> data, BoxConstraints constraints) {
    final String avatarUrl = data['avatar_url'] ?? '';
    final String name = data['name'] ?? _username;
    final String login = data['login'] ?? _username;
    final String bio = data['bio'] ?? 'No bio available.';
    final int followers = data['followers'] ?? 0;
    final int following = data['following'] ?? 0;
    final int publicRepos = data['public_repos'] ?? 0;
    final String profileUrl = data['html_url'] ?? 'https://github.com/$_username';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          "Activity",
          style: TextStyle(color: titleColor, fontSize: 80.sp, fontWeight: FontWeight.bold),
          maxLines: 1, // Ensure title doesn't wrap unexpectedly
        ),
        SizedBox(height: 20.h),
        // Use constraints for the yellow card width - Adjusted percentage for narrow layout
        Card(color: Colors.yellow, child: SizedBox(width: 180.w, height: 10.h)),
        SizedBox(height: 40.h),
        // Avatar - Make size relative to constraints and center it
        if (avatarUrl.isNotEmpty)
          Center(
            // Center the avatar in narrow layout
            child: ClipOval(
              child: Image.network(
                avatarUrl,
                // Use constraints, clamp size between min/max values if needed
                width: (constraints.maxWidth * 0.3).clamp(
                  80.0,
                  120.0,
                ), // Adjusted width relative to narrow screen
                height: (constraints.maxWidth * 0.3).clamp(
                  80.0,
                  120.0,
                ), // Adjusted height relative to narrow screen
                fit: BoxFit.cover,
                loadingBuilder:
                    (context, child, progress) =>
                        progress == null ? child : const CircularProgressIndicator(),
                errorBuilder:
                    (context, error, stackTrace) => Icon(
                      Icons.person,
                      size: (constraints.maxWidth * 0.3).clamp(80.0, 120.0),
                    ), // Adjusted error icon size
              ),
            ),
          ),
        SizedBox(height: 15.h),
        // Profile Details - Ensure text is centered
        AutoSizeText(
          name,
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        AutoSizeText(
          '@$login',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.h),
        AutoSizeText(bio, style: TextStyle(fontSize: 14.sp), textAlign: TextAlign.center),
        SizedBox(height: 15.h),
        // Stats - wrap if necessary or display vertically
        Wrap(
          // Use Wrap for better adaptability
          spacing: 10.w,
          runSpacing: 5.h,
          alignment: WrapAlignment.center,
          children: [
            _buildStatItem(Icons.people_outline, '$followers followers'),
            _buildStatItem(Icons.person_outline, '$following following'),
            _buildStatItem(Icons.book_outlined, '$publicRepos repositories'),
          ],
        ),
        SizedBox(height: 20.h),
        ElevatedButton.icon(
          icon: const Icon(Icons.link),
          label: const AutoSizeText('View on GitHub'),
          onPressed: () => _launchURL(profileUrl),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blueGrey, // Text color
          ),
        ),
        SizedBox(height: 20.h), // Add spacing before the graph
        // GitHub Contribution Graph
        // Make WebViewX height relative to screen height and wrap in Center
        Center(
          child: WebViewX(
            width: constraints.maxWidth, // Use constraints for width
            height: constraints.maxWidth * 1.5, // Adjust height proportionally
            initialSourceType: SourceType.html,
            initialContent: githubAll(isMobile: true),
            ignoreAllGestures: true, // Corrected indentation and placement
          ),
        ),
      ],
    );
  }

  /// Helper widget to build a statistic item (e.g., followers).
  Widget _buildStatItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Take minimum space needed
      children: [
        Icon(icon, size: 16.sp, color: Colors.grey),
        SizedBox(width: 4.w),
        AutoSizeText(text, style: TextStyle(fontSize: 14.sp)),
      ],
    );
  }

  /// Helper function to launch a URL using the url_launcher package.
  ///
  /// Includes basic error handling.
  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      // Log error or show a snackbar to the user if launching fails
      debugPrint('Could not launch $urlString');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Could not open link: $urlString')));
      }
    }
  }
}
