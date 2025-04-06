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
