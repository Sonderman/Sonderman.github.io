import 'package:flutter/material.dart';
import 'package:githubweb/responsive_widget.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  List<Widget> navButtons() => [
        NavButton(
          text: "about",
          onPressed: () async {
            await launch("https://docdro.id/cUeToaL");
          },
        ),
        NavButton(
          text: "work",
          onPressed: () {
            // html.window.open("https://pawan.live", "Pk");
          },
        ),
        NavButton(
          text: "contact",
          onPressed: () async {
            await launch("https://mailto:alihaydar338@gmail.com");
          },
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: Scaffold(
        backgroundColor: Colors.black,
        drawer: ResponsiveWidget.isSmallScreen(context)
            ? Drawer(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: navButtons(),
                ),
              )
            : null,
        body: SingleChildScrollView(
          child: AnimatedPadding(
            duration: const Duration(seconds: 1),
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),
            child: ResponsiveWidget(
              largeScreen: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  NavHeader(navButtons: navButtons()),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  ProfileInfo(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  SocialInfo(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NavHeader extends StatelessWidget {
  final List<Widget> navButtons;

  const NavHeader({Key? key, required this.navButtons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: Row(
        mainAxisAlignment: ResponsiveWidget.isSmallScreen(context)
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const PKDot(),
//          Spacer(),
          ResponsiveWidget.isSmallScreen(context) == false
              ? Row(
                  children: navButtons,
                )
              : const Text("")
        ],
      ),
    );
  }
}

class PKDot extends StatelessWidget {
  const PKDot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Text(
          "Online",
          textScaleFactor: 2,
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
  final text;
  final onPressed;
  final Color color;

  const NavButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.color = Colors.orange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4.0),
        child: OutlinedButton(
          child: Text(text),
          onPressed: () {},
        ));
  }
}

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({Key? key}) : super(key: key);

  profileImage(context) => Container(
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
            image: NetworkImage(
                "https://miro.medium.com/max/1187/1*0FqDC0_r1f5xFz3IywLYRA.jpeg"),
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget profileData(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          "Hi there! My name is",
          textScaleFactor: 2,
          style: TextStyle(color: Colors.orange),
        ),
        const Text(
          "AliHaydar\nAYAR",
          textScaleFactor: 5,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "I am Software Developer.",
          softWrap: true,
          textScaleFactor: 1.5,
          style: TextStyle(color: Colors.white70),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              child: const Text("Resume"),
              onPressed: () async {
                //await launch("https://docdro.id/cUeToaL");

                showDialog(
                    context: context,
                    builder: (dcontext) => SimpleDialog(
                          backgroundColor: Colors.blue,
                          children: [
                            SizedBox(
                                width: 600,
                                height: 800,
                                child: SfPdfViewer.asset("mycv.pdf"))
                          ],
                        ));
              },
            ),
            const SizedBox(
              width: 20,
            ),
            OutlinedButton(
              child: const Text("Say Hi!"),
              onPressed: () async {
                await launch("https://mailto:alihaydar338@gmail.com");
              },
            )
          ],
        )
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
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          profileImage(context),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          profileData(context)
        ],
      ),
    );
  }
}

class SocialInfo extends StatelessWidget {
  const SocialInfo({Key? key}) : super(key: key);

  List<Widget> socialMediaWidgets() {
    return [
      NavButton(
        text: "Github",
        onPressed: () async {
          await launch("https://github.com/Sonderman");
        },
        color: Colors.blue,
      ),
      NavButton(
        text: "Linkedin",
        onPressed: () async {
          await launch("https://www.linkedin.com/in/alihaydar-ayar-b45a4315b/");
        },
        color: Colors.blue,
      ),
    ];
  }

  Widget copyRightText() => const Text(
        "Ali Haydar AYAR ©️2021",
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
