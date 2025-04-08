import '../models/project_modelv2.dart';

// Personal Information
const String fullName = "Ali Haydar AYAR";
const String jobTitle = "Software Developer";
final List<String> jobTitles = const [
  "Flutter & Unity Game Developer",
  "Mobile App Developer",
  "Software Engineer",
];

// About Section Content
const String aboutParagraph1 =
    "Hello! I am Ali Haydar. I graduated from Karabük University in computer engineering and I am passionate about software development. I have been working with the Flutter framework for more than 2 years and I am constantly improving myself in this field. Additionally, I have 1 year of work experience with Unity Engine and took part in mobile game development processes.";
const String aboutParagraph2 =
    "The complex application I developed with Flutter and the mobile games I published with Unity gave me the opportunity to showcase my talents and creativity in the software world. These experiences encouraged me to further my technical skills and develop further in new projects.";
const String aboutParagraph3 =
    "I am currently improving myself further in Flutter and looking for new job opportunities in this field. I look forward to contributing and developing unique applications as part of an innovative team.";
const String aboutParagraph4 =
    "I am someone who likes to take responsibility, is prone to teamwork and is willing to constantly learn. I look forward to collaborating on new projects and achieving great success together. Feel free to contact me!";

// Services Data
class Service {
  final String title;
  final String description;

  const Service({required this.title, required this.description});
}

final List<Service> services = const [
  Service(
    title: "Mobile Applications",
    description: "Professional development of applications for iOS and Android.",
  ),
  Service(
    title: "Mobile Games",
    description: "Professional development of Casual/Hypercasual games for iOS and Android.",
  ),
];

// Skills Data
class Skill {
  final String name;
  final int percentage;

  const Skill({required this.name, required this.percentage});
}

final List<Skill> skills = const [
  Skill(name: "Flutter", percentage: 90),
  Skill(name: "Dart", percentage: 85),
  Skill(name: "Unity Engine", percentage: 75),
  Skill(name: "C#", percentage: 70),
];

// Contact Information
const String email = "alihaydar338@gmail.com";
const String location = "Remote/Turkey";
const String linkedInUrl = "https://www.linkedin.com/in/ali-haydar-ayar-b45a4315b/";
const String githubUrl = "https://github.com/sonderman";

// UI Text
const String viewProjectsText = "View Projects";
const String getInTouchText = "Get in Touch";

// GitHub Stats
String githubAll() {
  // The isMobile parameter is retained for future use, but responsiveness is now handled via CSS.
  return '''
<style>
  /* Make all images responsive within their container */
  img {
    max-width: 100%;
    height: auto;
    display: block;
    margin: 0 auto 10px auto; /* center images with spacing */
  }
  /* Outer scrollable container to prevent clipping */
  .scroll-container {
    max-width: 100%;
    max-height: 100%;
    overflow-y: auto;
    overflow-x: hidden;
  }
  /* Center the inner container and add some padding */
  .github-graphs-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 10px;
    box-sizing: border-box;
    width: 100%;
  }
  /* Arrange top 3 graphs side by side on wide screens */
  .top-graphs {
    display: flex;
    flex-direction: column;
    width: 100%;
    gap: 10px;
  }
  @media (min-width: 768px) {
    .top-graphs {
      flex-direction: row;
      justify-content: center;
      align-items: flex-start;
    }
    .top-graphs img {
      flex: 1;
      max-width: 33%;
      margin: 0; /* remove vertical margins for horizontal layout */
    }
  }
</style>
<div class="scroll-container">
  <div class="github-graphs-container top-graphs">
    <img src="https://github-readme-stats.vercel.app/api?username=Sonderman&hide_title=false&hide_rank=false&show_icons=true&include_all_commits=true&count_private=true&disable_animations=false&theme=dracula&locale=en&hide_border=false&order=1" alt="stats graph" />
    <img src="https://github-readme-stats.vercel.app/api/top-langs?username=Sonderman&locale=en&hide_title=false&layout=compact&card_width=320&langs_count=5&theme=dracula&hide_border=false&order=2" alt="languages graph" />
    <img src="https://streak-stats.demolab.com?user=Sonderman&locale=en&mode=daily&theme=dracula&hide_border=false&border_radius=5&order=3" alt="streak graph" />
  </div>
  <div class="github-graphs-container">
    <img src="https://github-readme-activity-graph.vercel.app/graph?username=Sonderman&radius=16&theme=react&area=true&order=5" alt="activity-graph graph" />
  </div>
  <div class="github-graphs-container">
    <img src="https://raw.githubusercontent.com/Sonderman/Sonderman/output/snake.svg" alt="Snake animation" />
  </div>
</div>
''';
}

// Resume Data
/// Represents a single entry in the resume timeline (Education or Experience).
class ResumeItem {
  final String date;
  final String title;
  final String? subtitle;
  final List<String>? details;

  const ResumeItem({required this.date, required this.title, this.subtitle, this.details});
}

/// List containing education history items.
final List<ResumeItem> educationHistory = const [
  ResumeItem(
    date: '2015 - 2020',
    title: 'Bachelor of Computer Engineering',
    subtitle: 'Karabuk University, Karabuk/Turkey',
    details: null,
  ),
];

/// List containing work experience history items.
final List<ResumeItem> experienceHistory = const [
  ResumeItem(
    date: 'Apr 2024 - Present',
    title: 'Flutter & Unity Game Developer | Freelancer',
    subtitle: null,
    details: ['Have published 80+ apps on mobile platforms.'],
  ),
  ResumeItem(
    date: 'Mar 2023 - Mar 2024',
    title: 'Game Developer',
    subtitle: null,
    details: [
      'I took part in the development process of 2 mobile games:',
      'Sky Wars Online: Istanbul',
      'Zombie Rush Drive',
    ],
  ),
];

// -------------------- PROJECT LIST --------------------

final List<ProjectModel> projectList = [
  ProjectModel(
    title: "Daysayar",
    description: "With this app you can challenge with time to reach your targets.",
    type: ProjectType.app,
    category: ProjectCategory.madeByMe,
    platforms: [ProjectPlatform.android],
    createdDate: DateTime(2024),
    storeLinks: ["https://play.google.com/store/apps/details?id=com.sondermium.daysayar"],
    images: [
      "assets/images/apps/daysayar-1.png",
      "assets/images/apps/daysayar-2.png",
      "assets/images/apps/daysayar-3.png",
      "assets/images/apps/daysayar-4.png",
      "assets/images/apps/daysayar-5.png",
    ],
  ),
  ProjectModel(
    title: "Macro Data Refinement",
    description:
        "Dive into the world of Macro Data Refinement, a unique puzzle game where numbers meet strategy! Your mission is to meticulously refine complex data grids to unlock famous cities around the globe.",
    type: ProjectType.app,
    category: ProjectCategory.madeByMe,
    platforms: [ProjectPlatform.android],
    createdDate: DateTime(2025),
    storeLinks: [
      "https://play.google.com/store/apps/details?id=com.sondermium.macrodatarefinement",
    ],
    images: [
      "assets/images/apps/macrodata-1.png",
      "assets/images/apps/macrodata-2.png",
      "assets/images/apps/macrodata-3.png",
      "assets/images/apps/macrodata-4.png",
      "assets/images/apps/macrodata-5.png",
      "assets/images/apps/macrodata-6.png",
    ],
  ),
  ProjectModel(
    title: "Task Manager",
    description: "You can manage your routine tasks with this app.",
    type: ProjectType.app,
    category: ProjectCategory.madeByMe,
    platforms: [ProjectPlatform.android],
    createdDate: DateTime(2024),
    storeLinks: ["https://play.google.com/store/apps/details?id=com.sondermium.taskmanager"],
    images: [
      "assets/images/apps/taskmanager-1.png",
      "assets/images/apps/taskmanager-2.png",
      "assets/images/apps/taskmanager-3.png",
      "assets/images/apps/taskmanager-4.png",
      "assets/images/apps/taskmanager-5.png",
      "assets/images/apps/taskmanager-6.png",
    ],
  ),
  ProjectModel(
    title: "Angry Bird Game Clone",
    description: "",
    images: ["assets/images/games/angrybird-1.png"],
    createdDate: DateTime(2022),
    category: ProjectCategory.madeByMe,
    platforms: [ProjectPlatform.desktop],
    type: ProjectType.game,
    githubLink: "https://github.com/Sonderman/AngryBirdGameUnity",
    playableAssetPath: "angrybird",
  ),
  ProjectModel(
    title: "Platformer Game",
    description: "",
    images: ["assets/images/games/platformer-1.png"],
    createdDate: DateTime(2021),
    category: ProjectCategory.madeByMe,
    platforms: [ProjectPlatform.desktop],
    type: ProjectType.game,
    githubLink: "https://github.com/Sonderman/PlatformerUnityGame",
    playableAssetPath: "platformer",
  ),
  ProjectModel(
    title: "Sky Wars Online: Istanbul",
    description: "",
    images: ["assets/images/games/skw-1.png"],
    createdDate: DateTime(2023),
    category: ProjectCategory.contributed,
    platforms: [ProjectPlatform.android],
    type: ProjectType.game,
    storeLinks: [
      "https://play.google.com/store/apps/details?id=com.atlasyazilim.SkyConqueror&hl=en_US",
    ],
  ),
  ProjectModel(
    title: "Zombie Rush Drive",
    description: "",
    images: [
      "assets/images/games/zrd-1.png",
      "assets/images/games/zrd-2.png",
      "assets/images/games/zrd-3.png",
      "assets/images/games/zrd-4.png",
    ],
    createdDate: DateTime(2023),
    category: ProjectCategory.contributed,
    platforms: [ProjectPlatform.android],
    type: ProjectType.game,
    storeLinks: [
      "https://play.google.com/store/apps/details?id=com.AtlasGameStudios.ZombieRushDrive&hl=en",
    ],
  ),
  ProjectModel(
    title: "Yaren: Tanışma・Sohbet",
    description: "",
    type: ProjectType.app,
    category: ProjectCategory.contributed,
    platforms: [ProjectPlatform.android],
    createdDate: DateTime(2024, 11, 26),
    images: ["assets/images/apps/yaren-1.png"],
    storeLinks: ["https://play.google.com/store/apps/details?id=com.yaren.chatapp"],
  ),
  ProjectModel(
    title: "Collector: Haberin Merkezi",
    description: "",
    type: ProjectType.app,
    category: ProjectCategory.contributed,
    platforms: [ProjectPlatform.android, ProjectPlatform.ios],
    createdDate: DateTime(2024, 12, 20),
    images: ["assets/images/apps/collector-1.png"],
    storeLinks: [
      "https://play.google.com/store/apps/details?id=com.collector.collector.mobile&hl=tr",
      "https://apps.apple.com/tr/app/collector-haberin-merkezi/id6450546836?l=tr",
    ],
  ),
  ProjectModel(
    title: "Tekx - Flört ve Arkadaşlık",
    description: "",
    type: ProjectType.app,
    category: ProjectCategory.contributed,
    platforms: [ProjectPlatform.android],
    createdDate: DateTime(2024, 12, 29),
    images: ["assets/images/apps/tekx-1.png"],
    storeLinks: ["https://play.google.com/store/apps/details?id=com.tekx.chatapp&hl=tr"],
  ),
];
