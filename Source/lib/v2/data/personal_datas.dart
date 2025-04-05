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
