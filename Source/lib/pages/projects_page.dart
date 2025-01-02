import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:myportfolio/globals.dart';
import 'package:myportfolio/models/project_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  int selectedTab = 0;
  List<ProjectModel> projects = [];
  bool isMobile = false;
  bool isAscending = true;

  @override
  void didChangeDependencies() {
    projects = [
      ProjectModel(
          title: "Angry Bird Game Clone",
          description: "",
          images: ["assets/images/games/angrybird-1.png"],
          createdDate: DateTime(2022),
          category: ProjectCategory.madeByMe,
          platform: ProjectPlatform.desktop,
          type: ProjectType.game,
          githubLink: "https://github.com/Sonderman/AngryBirdGameUnity",
          playable: ProjectModel.playButton(
              context: context, gameFolder: "angrybird")),
      ProjectModel(
          title: "Platformer Game",
          description: "",
          images: ["assets/images/games/platformer-1.png"],
          createdDate: DateTime(2021),
          category: ProjectCategory.madeByMe,
          platform: ProjectPlatform.desktop,
          type: ProjectType.game,
          githubLink: "https://github.com/Sonderman/PlatformerUnityGame",
          playable: ProjectModel.playButton(
              context: context, gameFolder: "platformer")),
      ProjectModel(
          title: "Sky Wars Online: Istanbul",
          description: "",
          images: ["assets/images/games/skw-1.png"],
          createdDate: DateTime(2023),
          category: ProjectCategory.contributed,
          platform: ProjectPlatform.android,
          type: ProjectType.game,
          storeLink:
              "https://play.google.com/store/apps/details?id=com.atlasyazilim.SkyConqueror&hl=en_US"),
      ProjectModel(
          title: "Zombie Rush Drive",
          description: "",
          images: [
            "assets/images/games/zrd-1.png",
            "assets/images/games/zrd-2.png",
            "assets/images/games/zrd-3.png",
            "assets/images/games/zrd-4.png"
          ],
          createdDate: DateTime(2023),
          category: ProjectCategory.contributed,
          platform: ProjectPlatform.android,
          type: ProjectType.game,
          storeLink:
              "https://play.google.com/store/apps/details?id=com.AtlasGameStudios.ZombieRushDrive&hl=en"),
      ProjectModel(
          title: "Yaren: Tanışma・Sohbet",
          description: "",
          type: ProjectType.app,
          category: ProjectCategory.contributed,
          platform: ProjectPlatform.android,
          createdDate: DateTime(2024, 11, 26),
          images: ["assets/images/apps/yaren-1.png"],
          storeLink:
              "https://play.google.com/store/apps/details?id=com.yaren.chatapp"),
      ProjectModel(
          title: "Collector: Haberin Merkezi",
          description: "",
          type: ProjectType.app,
          category: ProjectCategory.contributed,
          platform: ProjectPlatform.android,
          createdDate: DateTime(2024, 12, 20),
          images: ["assets/images/apps/collector-1.png"],
          storeLink:
              "https://play.google.com/store/apps/details?id=com.collector.collector.mobile&hl=tr"),
      ProjectModel(
          title: "Tekx - Flört ve Arkadaşlık",
          description: "",
          type: ProjectType.app,
          category: ProjectCategory.contributed,
          platform: ProjectPlatform.android,
          createdDate: DateTime(2024, 12, 29),
          images: ["assets/images/apps/tekx-1.png"],
          storeLink:
              "https://play.google.com/store/apps/details?id=com.tekx.chatapp&hl=tr"),
    ];
    //projects.shuffle();
    sortByDate();
    super.didChangeDependencies();
  }

  void sortByDate() {
    if (isAscending) {
      projects.sort(
        (a, b) => b.createdDate.millisecondsSinceEpoch
            .compareTo(a.createdDate.millisecondsSinceEpoch),
      );
    } else {
      projects.sort(
        (a, b) => a.createdDate.millisecondsSinceEpoch
            .compareTo(b.createdDate.millisecondsSinceEpoch),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    isMobile = 1.sw < 800;
    List<ProjectModel> filteredlist = [];
    switch (selectedTab) {
      case 0:
        filteredlist = projects;
        break;
      case 1:
        filteredlist = projects
            .where(
              (element) => element.category == ProjectCategory.madeByMe,
            )
            .toList();
        break;
      case 2:
        filteredlist = projects
            .where(
              (element) => element.category == ProjectCategory.contributed,
            )
            .toList();
        break;
    }
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Projects",
            style: TextStyle(
                color: titleColor,
                fontSize: isMobile ? 80.sp : 30.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: <Widget>[
                  Card(
                    color: Colors.yellow,
                    child: SizedBox(
                      width: isMobile ? 180.w : 60.w,
                      height: 10.h,
                    ),
                  ),
                ] +
                (isMobile
                    ? <Widget>[
                        const Spacer(),
                        Text(
                            "Sort by Date: ${isAscending ? "Ascending" : "Descending"}"),
                        SizedBox(
                          width: 15.sp,
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isAscending = !isAscending;
                                sortByDate();
                              });
                            },
                            icon: Icon(isAscending
                                ? Icons.arrow_upward
                                : Icons.arrow_downward)),
                      ]
                    : [Container()]),
          ),
          SizedBox(
            height: 40.h,
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedTab = 0;
                  });
                },
                child: Text(
                  "All",
                  style: TextStyle(
                      color: selectedTab == 0 ? Colors.yellow : titleColor,
                      fontSize: isMobile ? 60.sp : 25.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedTab = 1;
                  });
                },
                child: Text(
                  "Made by me",
                  style: TextStyle(
                      color: selectedTab == 1 ? Colors.yellow : titleColor,
                      fontSize: isMobile ? 60.sp : 25.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedTab = 2;
                  });
                },
                child: Text(
                  "Contributed by me",
                  style: TextStyle(
                      color: selectedTab == 2 ? Colors.yellow : titleColor,
                      fontSize: isMobile ? 60.sp : 25.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              !isMobile
                  ? Row(
                      children: [
                        Text(
                            "Sort by Date: ${isAscending ? "Ascending" : "Descending"}"),
                        SizedBox(
                          width: 15.sp,
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isAscending = !isAscending;
                                sortByDate();
                              });
                            },
                            icon: Icon(isAscending
                                ? Icons.arrow_upward
                                : Icons.arrow_downward)),
                      ],
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          SizedBox(
            height: 40.h,
          ),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile ? 2 : 3, // Yatayda 3 öğe
                crossAxisSpacing: 10.sp, // Yatay boşluk
                mainAxisSpacing: 15.sp, // Dikey boşluk
                mainAxisExtent: isMobile ? 1400.sp : 500.w),
            itemCount: filteredlist.length,
            itemBuilder: (context, index) {
              ProjectModel project = filteredlist[index];
              String createdDate = DateFormat('dd-MM-yyyy')
                  .format(project.createdDate)
                  .toString();
              return Card(
                shadowColor: Colors.white,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(createdDate),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Center(
                        child: Card(
                          shadowColor: Colors.white,
                          elevation: 2,
                          clipBehavior: Clip.hardEdge,
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0)),
                          ),
                          child: project.images.length > 1
                              ? CarouselSlider(
                                  items: project.images
                                      .map(
                                        (e) => Image.asset(
                                          e,
                                          fit: BoxFit.cover,
                                          height: isMobile ? 600.sp : 180.sp,
                                        ),
                                      )
                                      .toList(),
                                  options: CarouselOptions(
                                      height: isMobile ? 600.sp : 180.sp,
                                      autoPlay: true,
                                      autoPlayInterval:
                                          const Duration(seconds: 2)),
                                )
                              : Image.asset(
                                  project.images[0],
                                  fit: BoxFit.cover,
                                  height: isMobile ? 600.sp : 180.sp,
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: isMobile ? 500.w : 200.w,
                            child: Text(
                              project.title,
                              style: TextStyle(
                                fontSize: isMobile ? 60.sp : 20.sp,
                              ),
                            ),
                          ),
                          if (project.playable != null && !isMobile)
                            const Spacer(),
                          if (project.playable != null && !isMobile)
                            project.playable!,
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Icon(project.type == ProjectType.game
                              ? Icons.games
                              : Icons.phone_android),
                          const Spacer(),
                          if (project.githubLink != null)
                            IconButton(
                                onPressed: () {
                                  launchUrl(Uri.parse(project.githubLink!));
                                },
                                icon: Image.asset(
                                  "assets/icons/github.png",
                                  color: titleColor,
                                  width: isMobile ? 75.sp : 25.sp,
                                )),
                          if (project.storeLink != null)
                            IconButton(
                                onPressed: () {
                                  launchUrl(Uri.parse(project.storeLink!));
                                },
                                icon: Image.asset(
                                  project.platform == ProjectPlatform.android
                                      ? "assets/icons/google_play.png"
                                      : "assets/icons/app_store.png",
                                  width: isMobile ? 75.sp : 25.sp,
                                )),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
