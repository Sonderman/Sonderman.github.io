/// Global variables and constants used throughout the application
///
/// Contains:
/// - Button styles
/// - Color constants
/// - Text content
/// - Profile information
import 'package:flutter/material.dart';

/// Green button style used for project buttons
///
/// Uses semi-transparent green background color (ARGB: 175, 76, 175, 79)
var projectsButtonStyleGreen = ButtonStyle(
  backgroundColor: WidgetStateProperty.all<Color>(const Color.fromARGB(175, 76, 175, 79)),
);

/// Red button style used for project buttons
///
/// Uses solid red background color
var projectsButtonStyleRed = ButtonStyle(
  backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
);

/// Default text color used throughout the app
///
/// Light gray color (Hex: #c1c1c1)
const textColor = Color(0xffc1c1c1);

/// Title text color used for headings
///
/// Off-white color (Hex: #f9f9f9)
const titleColor = Color(0xfff9f9f9);

/// Professional title displayed in profile section
///
/// Used in about card widgets
const String profileTitle = "Software Developer";

/// Contact email address
///
/// Used in profile section and contact functionality
const String email = "alihaydar338@gmail.com";

/// Location information
///
/// Displays work location preference
const String location = "Remote/Turkey";

/// LinkedIn profile URL
///
/// Used for social media link in profile section
const String linkedinLink = "https://www.linkedin.com/in/ali-haydar-ayar-b45a4315b/";

/// GitHub profile URL
///
/// Used for social media link in profile section
const String githubLink = "https://github.com/Sonderman";

/// Detailed about me text displayed in profile section
///
/// Contains professional background and skills information
const String aboutText =
    '''Hello! I am Ali Haydar. I graduated from Karabük University in computer engineering and I am passionate about software development. I have been working with the Flutter framework for more than 2 years and I am constantly improving myself in this field. Additionally, I have 1 year of work experience with Unity Engine and took part in mobile game development processes.

The complex application I developed with Flutter and the mobile games I published with Unity gave me the opportunity to showcase my talents and creativity in the software world. These experiences encouraged me to further my technical skills and develop further in new projects.

I am currently improving myself further in Flutter and looking for new job opportunities in this field. I look forward to contributing and developing unique applications as part of an innovative team.

I am someone who likes to take responsibility, is prone to teamwork and is willing to constantly learn. I look forward to collaborating on new projects and achieving great success together. Feel free to contact me!''';

String githubAll({required bool isMobile}) {
  String width = isMobile ? '''width="100%"''' : "";
  return '''
<div align="center">
  <img src="https://github-readme-stats.vercel.app/api?username=Sonderman&hide_title=false&hide_rank=false&show_icons=true&include_all_commits=true&count_private=true&disable_animations=false&theme=dracula&locale=en&hide_border=false&order=1" height="20%" $width alt="stats graph"  />
  <img src="https://github-readme-stats.vercel.app/api/top-langs?username=Sonderman&locale=en&hide_title=false&layout=compact&card_width=320&langs_count=5&theme=dracula&hide_border=false&order=2" height="20%" $width alt="languages graph"  />
  <img src="https://github-readme-activity-graph.vercel.app/graph?username=Sonderman&radius=16&theme=react&area=true&order=5" width="100%" alt="activity-graph graph"  />
</div>
<img src="https://raw.githubusercontent.com/Sonderman/Sonderman/output/snake.svg" width="100%" alt="Snake animation" />
''';
}
