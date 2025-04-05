# Portfolio Redesign v2 Flutter Conversion Plan (Updated)

## Overall Goal

Convert the original static web portfolio project located in `lib/portfolioredesign2` into a functional Flutter web application within the `lib/v2` directory, replicating the design, content, and features while leveraging Flutter's capabilities.

## Summary of Findings (Original vs. Flutter `lib/v2`) - Updated

*   **Implemented/Partially Implemented:**
    *   Basic project structure (`lib/v2` with theme, widgets, sections).
    *   **Single-page application structure:** `HomePage` contains all sections.
    *   **Section Widgets:** Content from former pages moved into dedicated section widgets.
    *   Theme definition (`AppTheme` with constants) based on CSS variables.
    *   Global widgets integrated (`Preloader`, `CustomCursor`).
    *   **Scroll Navigation:** `NavMenu` updated for scroll-to-section, sticky behavior, **active state highlighting**, **hover underline animation**, **background blur**.
    *   Responsive `NavMenu` with custom mobile overlay integration.
    *   `HomePage` structure with Hero section layout, static content, image, icons, buttons, **refined entry animations**, **refined typing animation**, floating icon animation, **refined parallax effect**.
    *   **Canvas-based `ParticlesBackground`** integrated into `HomePage`.
    *   `Footer` integrated into `HomePage`, **responsive layout**, **social icon URL launching**, **social icon hover effects**.
    *   `BackToTopButton` integrated into `HomePage`, **hover effect implemented**.
    *   `AboutSection`: **Responsive layout**, **image frame border/hover effects**, **URL launching**, **skill bar animation**, **scroll-triggered animations**.
    *   `ResumeSection`: **Visual timeline structure (line/dots)**, **dot pulse animation**, **scroll-triggered animations**, **data populated**.
    *   `ProjectsSection`: **Filter buttons UI**, **Sort controls UI**, `ProjectCard` widget created, **data integrated in responsive grid**, **card animations**, **URL launching in cards**, **Filter/Sort logic implemented**, **"Load More" logic implemented**.
    *   `ActivitySection`: Basic structure with **scroll-triggered animations**, **basic Profile Card UI**, **Contributions Graph (static image)**, **basic Repo List UI (with clickable names & View All button)**. (Dynamic data fetching is TODO).
    *   `ContactSection`: **Responsive layout**, **contact info cards UI (with hover)**, **contact form UI with validation/state (submission removed)**, **scroll-triggered animations**, **URL launching for info links**.
    *   **Global scroll-triggered animations** added for main sections in `HomePage`.
    *   **MobileNavOverlay:** Social icon URL launching implemented, **icons updated (Font Awesome)**.
    *   **Footer:** Logo scroll-to-top implemented.
    *   **Hover Effects:** Added to NavMenu Contact button, About Service cards.

*   **Missing/Incomplete:**
    *   `MobileNavOverlay`: Icons updated. (Task Complete).
    *   `ActivitySection`: Implement dynamic data fetching for profile, graph, and repos (optional). Repo links and View All button added.
    *   `ContactSection`: Form submission functionality removed as requested. (Task Complete in current scope).
    *   `ProjectsSection`: Refine filter/sort animations (if needed). Consider adding project detail view/modal.
    *   General Responsiveness: Thorough testing and refinement across all sections and common screen sizes.
    *   End-to-end Testing: Complete testing of all features, interactions, links, and form submission.
    *   Image Assets: Ensure all image paths are correct and assets are optimized (e.g., compression, appropriate formats).
    *   Refine remaining minor hover effects or animations globally if needed.
    *   Code Cleanup & Documentation: Review code for clarity, add comments where necessary.

## Proposed Plan (Updated)

1.  **[DONE] Setup & Theming:** Define Flutter theme & constants. Integrate `flutter_screenutil`. Integrate `Preloader` & `CustomCursor`.
2.  **[DONE] Navigation Refinement:** Add 'Activity' link. Implement mobile nav overlay. Refine desktop `NavItem` styles & Contact button style. Implement sticky nav & background blur.
3.  **[DONE] Hero Section Implementation & Refinement:** Build layout, content. Integrate Canvas Particles. Implement & refine animations (entry, typing, floating, parallax). Integrate Footer & BackToTop.
4.  **[DONE] Single-Page Restructuring:** Create section widgets. Integrate sections into `HomePage`. Implement scroll navigation & active state in `NavMenu`. Implement NavItem hover animation.
5.  **[DONE] Implement Section Content & Features (Phase 1 - UI & Basic Interactivity):**
    *   **`AboutSection`:** Implement responsive layout, image effects, URL launching, skill bar animation, scroll animations.
    *   **`ResumeSection`:** Implement timeline structure (line/dots/pulse), scroll animations.
    *   **`ProjectsSection`:** Implement filter/sort UI, `ProjectCard` widget, grid display with placeholder data & card animations, URL launching.
    *   **`ActivitySection`:** Implement basic structure with scroll animations.
    *   **`ContactSection`:** Implement responsive layout, info cards UI, basic form UI/validation/state, scroll animations, URL launching.
6.  **[DONE] Footer & Back-to-Top Refinement:** Implement hover effects & URL launching. Implement Footer responsive layout. Add global section scroll animations.
7.  **[DONE] Implement Remaining Logic & Data:**
    *   `ResumeSection`: Data populated.
    *   `ProjectsSection`: Filter/sort logic, data handling, "Load More" logic implemented.
    *   `ActivitySection`: Basic content UI (profile, graph, repos) implemented, repo links and View All button added. (Data fetching optional/TODO).
    *   `ContactSection`: Form submission logic removed.
    *   `MobileNavOverlay`: URL launching implemented.
    *   `Footer`: Logo navigation implemented.
    *   Hover effects added for Contact Cards, NavMenu Contact Button, About Service Cards.
8.  **[TODO] Final Refinement & Testing:**
    *   Refine remaining minor hover effects (if any).
    *   Test responsiveness thoroughly.
    *   Test visuals and functionality across browsers/devices.
    *   Optimize assets (images).
    *   Perform end-to-end testing.

## High-Level Flow (Updated)

```mermaid
graph TD
    A[Start: Original Project Analysis] --> B{Identify Components & Features};
    B --> C{Analyze Flutter `lib/v2` Progress};
    C --> D{List Remaining Work};
    D --> E[Create Detailed Plan];
    E --> F[User Review & Approval];
    F -- Approved --> G{Switch to Code Mode};
    G --> H[Implement Theme & Global Widgets];
    H --> I[Refine Navigation (Initial)];
    I --> J[Implement Hero Section];
    J --> K[Restructure to Single-Page App & Refine Nav];
    K --> L[Implement Section UI & Basic Interactivity];
    L --> M[Implement Remaining Logic & Data];
    M --> N[Final Refinement & Testing];
    N --> O[Completion];
    F -- Changes Requested --> E;
```
## Current Implementation Phase (Phase 7 Focus)

This phase focuses on implementing the remaining logic and data population for key sections:

*   **Task #91: `ResumeSection` Data Population:**
    *   Gather actual resume data (experience, education, skills).
    *   Define data models if necessary (or use simple structures).
    *   Integrate data into the existing timeline UI components.
*   **Task #92: `ProjectsSection` Logic & Data:**
    *   **Data Handling:** Decide on data source (static list, JSON). Implement data loading/parsing. Define `Project` model if not already done precisely.
    *   **Filtering:** Implement logic to filter projects based on categories/tags selected via filter buttons. Update the displayed grid dynamically.
    *   **Sorting:** Implement logic to sort projects based on selected criteria (date, title). Update the displayed grid dynamically.
    *   **"Load More":** Implement logic if the project list is long, showing an initial set and loading more on button click.


## TODO List (Updated Detailed)

1.  **[DONE] Theme/Setup:** Define App Theme & Constants, Integrate Preloader/Cursor.
2.  **[DONE] Navigation:** Add 'Activity' Link, Custom Mobile Nav, Refine Desktop Nav (incl. Contact Button Hover), Sticky Nav, Scroll-to-Section Logic, Active State, Hover Underline, Background Blur.
3.  **[DONE] HomePage Structure:** Hero Layout, Basic Content, Integrate Footer/BackToTop, Integrate All Section Widgets.
4.  **[DONE] Hero Section Refinement:** Refine Parallax, Canvas Particles, Entry Animations, Typing Animation.
5.  **[DONE] `AboutSection` Implementation:** Responsive Layout, Image Effects, URL Launching, Skill Bar Animation, Scroll Animations, Service Card Hover Effects.
6.  **[DONE] `ResumeSection` Implementation:** Timeline Structure (line/dots/pulse), Scroll Animations, Data Populated.
7.  **[DONE] `ProjectsSection` Implementation:** Filter/Sort UI, `ProjectCard` Widget, Grid Display (Actual Data), Card Animations, URL Launching, Filter/Sort Logic, Data Handling, "Load More" Logic.
8.  **[Partial] `ActivitySection` Implementation:** Basic Structure, Scroll Animations, Basic Content UI (Profile, Graph, Repos with Links & View All Button). **[TODO] Implement Dynamic Data Fetching (Optional).**
9.  **[DONE] `ContactSection` Implementation:** Responsive Layout, Info Cards UI (with Hover), Basic Form UI/Validation/State, Scroll Animations, URL Launching. **(Form Submission Removed).**
10. **[DONE] Footer & BackToTop Refinement:** Implement BackToTop Hover, Footer URL Launching, Footer Responsive Layout, Footer Logo Navigation.
11. **[DONE] Global Animations:** Implement scroll-triggered animations for main sections.
12. **[DONE] Specific Hover Effects:** Contact Cards, NavMenu Contact Button, About Service Cards implemented. **[TODO] Review for any other minor refinements.**
13. **[DONE] `MobileNavOverlay`:** URL launching implemented, Icons updated (Font Awesome).
14. **[DONE] `Footer`:** Logo navigation to top implemented.
15. **[TODO] Responsiveness:** Test and refine layouts/widgets across all sections for common screen sizes.
16. **[TODO] Testing & Optimization:** End-to-end testing, cross-browser checks, image optimization.