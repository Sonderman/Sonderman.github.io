import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  TestPage({Key key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.black,
        ),
        drawerEdgeDragWidth: 0.0,
        drawer: MediaQuery.of(context).size.width < 800
            ? Drawer(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: <Widget>[
                    OutlineButton(
                      child: Text("about"),
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                      onPressed: () {},
                      highlightedBorderColor: Colors.orange,
                    ),
                    OutlineButton(
                      child: Text("work"),
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                      onPressed: () {},
                      highlightedBorderColor: Colors.orange,
                    ),
                    OutlineButton(
                      child: Text("contact"),
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                      onPressed: () {},
                      highlightedBorderColor: Colors.orange,
                    ),
                  ],
                ),
              )
            : null,
        body: SingleChildScrollView(
          child: AnimatedPadding(
            duration: Duration(seconds: 1),
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[],
            ),
          ),
        ));
  }
}
