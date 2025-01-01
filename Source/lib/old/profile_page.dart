import 'package:flutter/material.dart';
import 'package:myportfolio/old/responsive_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webviewx/webviewx.dart';
import '../globals.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  List<Widget> navButtons() => [
        NavButton(
          text: "contact",
          onPressed: () {
            launchUrl(Uri.parse("https://mailto:alihaydar338@gmail.com"));
          },
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: AnimatedPadding(
            duration: const Duration(seconds: 1),
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),
            child: ResponsiveWidget(
              largeScreen: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  NavHeader(navButtons: navButtons()),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  const ProfileInfo(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  const Projects(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  const SocialInfo(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Projects extends StatelessWidget {
  const Projects({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Games made by me",
          textScaler: TextScaler.linear(2),
          style: TextStyle(color: Colors.green),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          style: projectsButtonStyleGreen,
          child: const Text("Play Angry Bird Game Clone"),
          onPressed: () async {
            double frameHeight = 700.0;
            double frameWidth = 1000.0;
            String src =
                """<iframe width="100%" height="${frameHeight - 50}" style="border:none;" src="assets/assets/games/angrybird/index.html"></iframe>""";
            showDialog(
                context: context,
                builder: (dcontext) => AlertDialog(
                      content: WebViewX(
                        height: frameHeight,
                        width: frameWidth,
                        initialContent: src,
                        initialSourceType: SourceType.html,
                      ),
                    ));
          },
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          style: projectsButtonStyleGreen,
          child: const Text("Play Platformer Game"),
          onPressed: () async {
            double frameHeight = 700.0;
            double frameWidth = 1000.0;
            String src =
                """<iframe width="100%" height="${frameHeight - 50}" style="border:none;" src="assets/assets/games/platformer/index.html"></iframe>""";
            showDialog(
                context: context,
                builder: (dcontext) => AlertDialog(
                      content: WebViewX(
                        height: frameHeight,
                        width: frameWidth,
                        initialContent: src,
                        initialSourceType: SourceType.html,
                      ),
                    ));
          },
        ),
        const SizedBox(
          height: 40,
        ),
        const Text(
          "Games that i have contributed",
          textScaler: TextScaler.linear(2),
          style: TextStyle(color: Colors.green),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          style: projectsButtonStyleGreen,
          child: const Text("Sky Wars Online : Istanbul (Google Play)"),
          onPressed: () {
            launchUrl(Uri.parse(
                "https://play.google.com/store/apps/details?id=com.atlasyazilim.SkyConqueror&hl=en_US"));
          },
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          style: projectsButtonStyleGreen,
          child: const Text("Zombie Rush Drive (Google Play)"),
          onPressed: () {
            launchUrl(Uri.parse(
                "https://play.google.com/store/apps/details?id=com.AtlasGameStudios.ZombieRushDrive&hl=en"));
          },
        ),
      ],
    );
  }
}

class NavHeader extends StatelessWidget {
  final List<Widget> navButtons;

  const NavHeader({super.key, required this.navButtons});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: Row(
        mainAxisAlignment: ResponsiveWidget.isSmallScreen(context)
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
        children: const <Widget>[PKDot()],
      ),
    );
  }
}

class PKDot extends StatelessWidget {
  const PKDot({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Text(
          "Online",
          textScaler: TextScaler.linear(2),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        AnimatedContainer(
          duration: const Duration(seconds: 1),
          height: 8,
          width: 8,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.orange,
          ),
        ),
      ],
    );
  }
}

class NavButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color color;

  const NavButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.color = Colors.orange});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4.0),
        child: OutlinedButton(
          onPressed: onPressed,
          child: Text(text),
        ));
  }
}

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  Widget profileImage(context) => Container(
        height: ResponsiveWidget.isSmallScreen(context)
            ? MediaQuery.of(context).size.height * 0.25
            : MediaQuery.of(context).size.width * 0.25,
        width: ResponsiveWidget.isSmallScreen(context)
            ? MediaQuery.of(context).size.height * 0.25
            : MediaQuery.of(context).size.width * 0.25,
        decoration: const BoxDecoration(
          backgroundBlendMode: BlendMode.luminosity,
          color: Colors.deepOrange,
//            borderRadius: BorderRadius.circular(40),
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage("assets/profile2.jpg"),
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget profileData(context) {
    return Column(
      crossAxisAlignment: ResponsiveWidget.isSmallScreen(context)
          ? CrossAxisAlignment.center
          : ResponsiveWidget.isMediumScreen(context)
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          "Hi there! My name is",
          textScaler: TextScaler.linear(2),
          style: TextStyle(color: Colors.orange),
        ),
        const Text(
          "Ali Haydar",
          textScaler: TextScaler.linear(5),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "I am Game & Mobile Application Developer.",
          softWrap: true,
          textScaler: TextScaler.linear(1.5),
          style: TextStyle(color: Colors.white70),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              style: projectsButtonStyleRed,
              child: const Text("Resume"),
              onPressed: () async {
                //await launch("https://docdro.id/cUeToaL");
                showDialog(
                    context: context,
                    builder: (dcontext) => AlertDialog(
                          content: Image.asset("assets/cv-game.png"),
                        ));
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[profileImage(context), profileData(context)],
      ),
      smallScreen: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          profileImage(context),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          profileData(context),
        ],
      ),
    );
  }
}

class SocialInfo extends StatelessWidget {
  const SocialInfo({super.key});

  List<Widget> socialMediaWidgets() {
    return [
      NavButton(
        text: "Github",
        onPressed: () {
          launchUrl(Uri.parse("https://github.com/Sonderman"));
        },
        color: Colors.blue,
      ),
      NavButton(
        text: "Linkedin",
        onPressed: () {
          launchUrl(Uri.parse(
              "https://www.linkedin.com/in/alihaydar-ayar-b45a4315b/"));
        },
        color: Colors.blue,
      ),
      NavButton(
        text: "contact",
        onPressed: () {
          launchUrl(Uri.parse("https://mailto:alihaydar338@gmail.com"));
        },
      ),
    ];
  }

  Widget copyRightText() => const Text(
        "Ali Haydar AYAR ©️2024",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: socialMediaWidgets(),
          ),
          copyRightText(),
        ],
      ),
      smallScreen: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: socialMediaWidgets(),
      ),
    );
  }
}
