import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myportfolio/v2/theme/app_theme.dart'; // Import theme
import 'package:myportfolio/v2/widgets/section_header.dart'; // Import SectionHeader
import 'package:flutter_animate/flutter_animate.dart'; // Import flutter_animate
import 'package:intl/intl.dart'; // Import for date formatting

import '../models/project.dart'; // Import the Project model
import '../widgets/project_card.dart'; // Import ProjectCard

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  // State variables
  String _currentFilter = 'all';
  String _selectedSort = 'date-desc';
  bool _isAscending = false; // false = descending, true = ascending
  List<Project> _allProjects = []; // Holds all projects
  List<Project> _filteredSortedProjects = []; // Holds the full filtered/sorted list
  List<Project> _displayedProjects = []; // Holds projects currently visible
  int _itemsToShow = 6; // Initial number of projects to show
  static const int _itemsPerLoad = 6; // Number of projects to load each time

  // Actual project data from v1, mapped to v2 Project model
  final List<Project> _actualProjects = [
    Project(
      title: "Angry Bird Game Clone",
      imagePath:
          "assets/images/games/angrybird-1.png", // Assuming single image for simplicity in v2 card
      date: DateFormat('yyyy-MM-dd').format(DateTime(2022)), // Format date
      category: 'made', // Map from ProjectCategory.madeByMe
      platforms: ['desktop'], // Map from ProjectPlatform.desktop
      links: {
        'github': "https://github.com/Sonderman/AngryBirdGameUnity",
        // 'playable': // v1 had a widget, ignore for now
      },
    ),
    Project(
      title: "Platformer Game",
      imagePath: "assets/images/games/platformer-1.png",
      date: DateFormat('yyyy-MM-dd').format(DateTime(2021)),
      category: 'made',
      platforms: ['desktop'],
      links: {
        'github': "https://github.com/Sonderman/PlatformerUnityGame",
        // 'playable': // v1 had a widget, ignore for now
      },
    ),
    Project(
      title: "Sky Wars Online: Istanbul",
      imagePath: "assets/images/games/skw-1.png",
      date: DateFormat('yyyy-MM-dd').format(DateTime(2023)),
      category: 'contributed', // Map from ProjectCategory.contributed
      platforms: ['android'], // Map from ProjectPlatform.android
      links: {
        'playstore':
            "https://play.google.com/store/apps/details?id=com.atlasyazilim.SkyConqueror&hl=en_US",
      },
    ),
    Project(
      title: "Zombie Rush Drive",
      // Using first image for v2 card, v1 had multiple
      imagePath: "assets/images/games/zrd-1.png",
      date: DateFormat('yyyy-MM-dd').format(DateTime(2023)),
      category: 'contributed',
      platforms: ['android'],
      links: {
        'playstore':
            "https://play.google.com/store/apps/details?id=com.AtlasGameStudios.ZombieRushDrive&hl=en",
      },
    ),
    Project(
      title: "Yaren: Tanışma・Sohbet",
      imagePath: "assets/images/apps/yaren-1.png",
      date: DateFormat('yyyy-MM-dd').format(DateTime(2024, 11, 26)),
      category: 'contributed',
      platforms: ['android'],
      links: {'playstore': "https://play.google.com/store/apps/details?id=com.yaren.chatapp"},
    ),
    Project(
      title: "Collector: Haberin Merkezi",
      imagePath: "assets/images/apps/collector-1.png",
      date: DateFormat('yyyy-MM-dd').format(DateTime(2024, 12, 20)),
      category: 'contributed',
      platforms: ['android', 'ios'], // Map from list
      links: {
        'playstore':
            "https://play.google.com/store/apps/details?id=com.collector.collector.mobile&hl=tr",
        'appstore': "https://apps.apple.com/tr/app/collector-haberin-merkezi/id6450546836?l=tr",
      },
    ),
    Project(
      title: "Tekx - Flört ve Arkadaşlık",
      imagePath: "assets/images/apps/tekx-1.png",
      date: DateFormat('yyyy-MM-dd').format(DateTime(2024, 12, 29)),
      category: 'contributed',
      platforms: ['android'],
      links: {'playstore': "https://play.google.com/store/apps/details?id=com.tekx.chatapp&hl=tr"},
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Initialize with actual data
    _allProjects = List.from(_actualProjects);
    _itemsToShow = 6; // Reset items to show on init
    _applyFiltersAndSort(); // Apply initial filter/sort and update displayed list
  }

  // Method to filter and sort projects
  void _applyFiltersAndSort() {
    List<Project> filtered = [];

    // Apply Filter
    if (_currentFilter == 'all') {
      filtered = List.from(_allProjects);
    } else {
      filtered = _allProjects.where((p) => p.category == _currentFilter).toList();
    }

    // Apply Sort
    filtered.sort((a, b) {
      // Assuming date format YYYY-MM-DD for comparison
      final dateA = DateTime.tryParse(a.date) ?? DateTime(1900);
      final dateB = DateTime.tryParse(b.date) ?? DateTime(1900);
      int comparison = dateA.compareTo(dateB);

      // Handle sort criteria (only date for now)
      if (_selectedSort == 'date-desc' || _selectedSort == 'date-asc') {
        // The direction is handled separately after sorting
        return comparison;
      }
      // Add other sort criteria here if needed
      return 0;
    });

    // Handle sort direction toggle
    if ((_selectedSort == 'date-desc' && !_isAscending) ||
        (_selectedSort == 'date-asc' && _isAscending)) {
      // Descending order needed (compareTo sorts ascending by default)
      filtered = filtered.reversed.toList();
    }
    // If ascending needed, the default compareTo order is correct

    // Store the full filtered list
    _filteredSortedProjects = filtered;
    // Reset items to show when filters/sort change
    _itemsToShow = 6;
    // Update the displayed list based on itemsToShow
    _updateDisplayedProjects();
  }

  // Helper method to update the displayed projects list based on _itemsToShow
  void _updateDisplayedProjects() {
    setState(() {
      final totalItems = _filteredSortedProjects.length;
      _displayedProjects = _filteredSortedProjects.take(_itemsToShow).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary, // Match original section background
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 60.w,
          vertical: 80.h,
        ), // Increased vertical padding
        child: Column(
          children: [
            // Section Header
            const SectionHeader(title: 'Projects'),
            SizedBox(height: 40.h),

            // Filter Buttons
            _buildFilterButtons(),
            SizedBox(height: 30.h),

            // Sort Controls
            _buildSortControls(),
            SizedBox(height: 30.h),

            // Projects Grid
            _buildProjectsGrid(),
            SizedBox(height: 40.h),

            // Load More Button (Conditional)
            if (_displayedProjects.length < _filteredSortedProjects.length)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    // Increase items to show, capped at total available
                    _itemsToShow = (_itemsToShow + _itemsPerLoad).clamp(
                      0,
                      _filteredSortedProjects.length,
                    );
                  });
                  _updateDisplayedProjects(); // Update the displayed list
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                  textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                child: const Text('Load More Projects'),
              ),
          ],
        ),
      ),
    );
  }

  // Helper widget for filter buttons
  Widget _buildFilterButtons() {
    return Wrap(
      // Use Wrap for responsiveness
      alignment: WrapAlignment.center,
      spacing: AppTheme.spacingSm.w, // Use theme spacing
      runSpacing: AppTheme.spacingSm.h,
      children: [
        _FilterButton(
          label: 'All',
          filterValue: 'all',
          currentFilter: _currentFilter, // Use state variable
          onPressed: () {
            setState(() {
              _currentFilter = 'all';
            });
            _applyFiltersAndSort();
          },
        ),
        _FilterButton(
          label: 'Made by me',
          filterValue: 'made',
          currentFilter: _currentFilter, // Use state variable
          onPressed: () {
            setState(() {
              _currentFilter = 'made';
            });
            _applyFiltersAndSort();
          },
        ),
        _FilterButton(
          label: 'Contributed by me',
          filterValue: 'contributed',
          currentFilter: _currentFilter, // Use state variable
          onPressed: () {
            setState(() {
              _currentFilter = 'contributed';
            });
            _applyFiltersAndSort();
          },
        ),
      ],
    );
  }

  // Helper widget for sort controls
  Widget _buildSortControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end, // Align to the right like original
      children: [
        Text('Sort by:', style: TextStyle(color: AppColors.textMuted)),
        SizedBox(width: AppTheme.spacingSm.w),
        // Dropdown Button
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusSm),
          ),
          child: DropdownButton<String>(
            value: _selectedSort, // Use state variable
            dropdownColor: AppColors.primaryLight,
            underline: Container(),
            icon: Icon(Icons.arrow_drop_down, color: AppColors.text),
            style: TextStyle(color: AppColors.text, fontFamily: AppFonts.body),
            items: const [
              DropdownMenuItem(value: 'date-desc', child: Text('Date: Descending')),
              DropdownMenuItem(value: 'date-asc', child: Text('Date: Ascending')),
            ],
            onChanged: (String? newValue) {
              if (newValue != null && newValue != _selectedSort) {
                setState(() {
                  _selectedSort = newValue;
                });
                _applyFiltersAndSort();
              }
            },
          ),
        ),
        SizedBox(width: AppTheme.spacingSm.w),
        // Direction Button
        InkWell(
          onTap: () {
            setState(() {
              _isAscending = !_isAscending;
            });
            _applyFiltersAndSort();
          },
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusSm),
          child: Container(
            width: 35.w,
            height: 35.h,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusSm),
            ),
            child: Icon(
              _isAscending ? Icons.arrow_upward : Icons.arrow_downward, // Use state variable
              color: AppColors.text,
              size: 20.sp,
            ),
          ),
        ),
      ],
    ); // Close Row
  }

  // Helper widget for the projects grid
  Widget _buildProjectsGrid() {
    if (_displayedProjects.isEmpty) {
      return const Center(
        child: Text(
          'No projects match the current filter.',
          style: TextStyle(color: AppColors.textMuted),
        ),
      );
    }

    // Determine crossAxisCount based on context width
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 1200 ? 3 : (screenWidth > 768 ? 2 : 1);

    return GridView.builder(
      key: ValueKey(
        '$_currentFilter-$_selectedSort-$_isAscending',
      ), // Add key to force rebuild on filter/sort change
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: AppTheme.spacingMd.w,
        mainAxisSpacing: AppTheme.spacingMd.h,
        childAspectRatio: 0.85, // Adjusted aspect ratio slightly
      ),
      // Use the length of the *currently displayed* projects
      itemCount: _displayedProjects.length,
      itemBuilder: (context, index) {
        final project = _displayedProjects[index];
        // Add scroll animation to ProjectCard
        return ProjectCard(project: project)
            .animate()
            .fadeIn(duration: 600.ms, delay: (100 * (index % crossAxisCount)).ms)
            .slideY(
              begin: 0.2,
              duration: 600.ms,
              delay: (100 * (index % crossAxisCount)).ms,
              curve: Curves.easeOut,
            );
      },
    );
  }
}

// Internal helper widget for filter buttons to manage styling
class _FilterButton extends StatelessWidget {
  final String label;
  final String filterValue;
  final String currentFilter;
  final VoidCallback onPressed;

  const _FilterButton({
    required this.label,
    required this.filterValue,
    required this.currentFilter,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = currentFilter == filterValue;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? AppColors.secondary : Colors.transparent,
        foregroundColor: isActive ? AppColors.primary : AppColors.text,
        side: isActive ? null : BorderSide(color: AppColors.primaryLight, width: 2),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.borderRadiusMd)),
        elevation: 0,
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }
}
