import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart'; // Import AutoSizeText
import 'package:myportfolio/v2/theme/v2_theme.dart'; // Import theme
import 'package:myportfolio/v2/widgets/section_header.dart'; // Import SectionHeader
import 'package:flutter_animate/flutter_animate.dart'; // Import flutter_animate
import '../models/project_modelv2.dart'; // Import the Project model
import '../widgets/project_card.dart'; // Import ProjectCard
import '../data/personal_datas.dart'; // Import projectList

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
  List<ProjectModel> _allProjects = []; // Holds all projects
  List<ProjectModel> _filteredSortedProjects = []; // Holds the full filtered/sorted list
  List<ProjectModel> _displayedProjects = []; // Holds projects currently visible
  int _itemsToShow = 6; // Initial number of projects to show
  static const int _itemsPerLoad = 6; // Number of projects to load each time

  @override
  void initState() {
    super.initState();
    // Initialize with actual data
    _allProjects = List.from(projectList);
    _itemsToShow = 6; // Reset items to show on init
    _applyFiltersAndSort(); // Apply initial filter/sort and update displayed list
  }

  // Method to filter and sort projects
  void _applyFiltersAndSort() {
    List<ProjectModel> filtered = [];

    // Apply Filter
    if (_currentFilter == 'all') {
      filtered = List.from(_allProjects);
    } else {
      filtered =
          _allProjects
              .where(
                (p) =>
                    (_currentFilter == 'made' && p.category == ProjectCategory.madeByMe) ||
                    (_currentFilter == 'contributed' && p.category == ProjectCategory.contributed),
              )
              .toList();
    }

    // Apply Sort
    filtered.sort((a, b) {
      int comparison = a.createdDate.compareTo(b.createdDate);

      // Handle sort criteria (only date for now)
      if (_selectedSort == 'date-desc' || _selectedSort == 'date-asc') {
        return comparison;
      }
      return 0;
    });

    // Handle sort direction toggle
    if ((_selectedSort == 'date-desc' && !_isAscending) ||
        (_selectedSort == 'date-asc' && _isAscending)) {
      filtered = filtered.reversed.toList();
    }

    _filteredSortedProjects = filtered;
    _itemsToShow = 6;
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
      color: V2Colors.primary, // Match original section background
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
                  backgroundColor: V2Colors.secondary,
                  foregroundColor: V2Colors.primary,
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                  textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                child: const AutoSizeText(
                  'Load More Projects',
                  minFontSize: 10,
                ), // Added minFontSize
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
      spacing: V2Theme.spacingSm.w, // Use theme spacing
      runSpacing: V2Theme.spacingSm.h,
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
        AutoSizeText(
          'Sort by:',
          style: TextStyle(color: V2Colors.textMuted),
          minFontSize: 10,
        ), // Added minFontSize
        SizedBox(width: V2Theme.spacingSm.w),
        // Dropdown Button
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: V2Colors.primaryLight,
            borderRadius: BorderRadius.circular(V2Theme.borderRadiusSm),
          ),
          child: DropdownButton<String>(
            value: _selectedSort, // Use state variable
            dropdownColor: V2Colors.primaryLight,
            underline: Container(),
            icon: Icon(Icons.arrow_drop_down, color: V2Colors.text),
            style: TextStyle(color: V2Colors.text, fontFamily: V2Fonts.body),
            items: const [
              DropdownMenuItem(
                value: 'date-desc',
                child: AutoSizeText('Date: Descending', minFontSize: 10),
              ), // Added minFontSize
              DropdownMenuItem(
                value: 'date-asc',
                child: AutoSizeText('Date: Ascending', minFontSize: 10),
              ), // Added minFontSize
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
        SizedBox(width: V2Theme.spacingSm.w),
        // Direction Button
        InkWell(
          onTap: () {
            setState(() {
              _isAscending = !_isAscending;
            });
            _applyFiltersAndSort();
          },
          borderRadius: BorderRadius.circular(V2Theme.borderRadiusSm),
          child: Container(
            width: 35.w,
            height: 35.h,
            decoration: BoxDecoration(
              color: V2Colors.primaryLight,
              borderRadius: BorderRadius.circular(V2Theme.borderRadiusSm),
            ),
            child: Icon(
              _isAscending ? Icons.arrow_upward : Icons.arrow_downward, // Use state variable
              color: V2Colors.text,
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
        child: AutoSizeText(
          'No projects match the current filter.',
          style: TextStyle(color: V2Colors.textMuted),
          minFontSize: 10, // Added minFontSize
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
        crossAxisSpacing: V2Theme.spacingMd.w,
        mainAxisSpacing: V2Theme.spacingMd.h,
        childAspectRatio: 1.3,
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
        backgroundColor: isActive ? V2Colors.secondary : Colors.transparent,
        foregroundColor: isActive ? V2Colors.primary : V2Colors.text,
        side: isActive ? null : BorderSide(color: V2Colors.primaryLight, width: 2),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(V2Theme.borderRadiusMd)),
        elevation: 0,
      ),
      child: AutoSizeText(
        label,
        style: const TextStyle(fontWeight: FontWeight.w500),
        minFontSize: 10,
      ), // Added minFontSize
    );
  }
}
