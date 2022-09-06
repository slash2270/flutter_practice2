import 'package:flutter/material.dart';
import 'package:flutter_practice2/villains/villain_util.dart';
import 'package:flutter_villains/villain.dart';

// image from https://unsplash.com/photos/pAs4IM6OGWI
class VillainProfile extends StatefulWidget {
  const VillainProfile({Key? key}) : super(key: key);

  @override
  _VillainProfileState createState() => _VillainProfileState();
}

class _VillainProfileState extends State<VillainProfile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Villain Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            child: const Hero(
                tag: "profile",
                child: CircleAvatar(
                    backgroundImage: AssetImage("assets/joe-gardner.jpg"))),
            onTap: () {
              Navigator.of(context).push(BlankRoute(const VillainProfile2()));
            },
          ),
        ),
      ),
    );
  }
}

class VillainProfile2 extends StatefulWidget {
  const VillainProfile2({Key? key}) : super(key: key);

  @override
  _VillainProfile2State createState() => _VillainProfile2State();
}

class _VillainProfile2State extends State<VillainProfile2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Villain Profile2"),
      ),
      backgroundColor: const Color(0xffdddddd),
      body: Center(
        child: ListView(
          children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Villain(
                  animateEntrance: false,
                  villainAnimation: VillainAnimation.fade(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Hero(
                          tag: "profile",
                          child: CircleAvatar(
                            backgroundImage:
                            AssetImage("assets/joe-gardner.jpg"),
                            radius: 50.0,
                          )),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Villain(
                        villainAnimation: VillainAnimation.fromBottom(
                            relativeOffset: 0.4,
                            to: const Duration(milliseconds: 150)),
                        animateExit: false,
                        secondaryVillainAnimation: VillainAnimation.fade(),
                        child: Text(
                          "這是一些很棒的文字。 這是一個簡短的摘要，包含有用的信息。 這需要更長一點，所以我會繼續寫。",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                      Villain(
                        villainAnimation:
                        VillainAnimation.fromBottom(relativeOffset: 0.4),
                        animateExit: false,
                        secondaryVillainAnimation: VillainAnimation.fade(),
                        child: const Divider(
                          color: Colors.black,
                          height: 32.0,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Villain(
                            villainAnimation: VillainAnimation.fromBottom(
                                relativeOffset: 0.8,
                                curve: Curves.fastOutSlowIn,
                                from: const Duration(milliseconds: 100),
                                to: const Duration(milliseconds: 250)),
                            secondaryVillainAnimation: VillainAnimation.fade(),
                            animateExit: false,
                            child: Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffea4c89)),
                              width: 32.0,
                              height: 32.0,
                              child: const Center(
                                  child: Text(
                                    "A",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  )),
                            ),
                          ),
                          Villain(
                            villainAnimation: VillainAnimation.fromBottom(
                                relativeOffset: 0.8,
                                curve: Curves.fastOutSlowIn,
                                from: const Duration(milliseconds: 150),
                                to: const Duration(milliseconds: 300)),
                            secondaryVillainAnimation: VillainAnimation.fade(),
                            animateExit: false,
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blueAccent,
                                ),
                                width: 32.0,
                                height: 32.0,
                                child: const Center(
                                    child: Text(
                                      "B",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20.0),
                                    )),
                              ),
                            ),
                          ),
                          Villain(
                            secondaryVillainAnimation: VillainAnimation.fade(),
                            villainAnimation: VillainAnimation.fromBottom(
                                relativeOffset: 0.8,
                                curve: Curves.fastOutSlowIn,
                                from: const Duration(milliseconds: 200),
                                to: const Duration(milliseconds: 350)),
                            animateExit: false,
                            child: Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.redAccent),
                              width: 32.0,
                              height: 32.0,
                              child: const Center(
                                  child: Text(
                                    "C",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 64.0,
            ),
            Villain(
              villainAnimation: VillainAnimation.fromBottom(
                  relativeOffset: 0.05,
                  from: const Duration(milliseconds: 300),
                  to: const Duration(milliseconds: 400)),
              secondaryVillainAnimation: VillainAnimation.fade(),
              child: Card(
                child: Center(
                  child: Column(
                    children: const <Widget>[
                      ListTile(
                        title: Text("Info card"),
                        subtitle: Text("More info"),
                      ),
                      ListTile(
                        title: Text("Ideas start running out"),
                        subtitle: Text("Yup no idea"),
                      ),
                      ListTile(
                        title: Text("Some text"),
                        subtitle: Text("A text specifying the text above"),
                      ),
                      ListTile(
                        title: Text("Please"),
                        subtitle: Text("A text specifying the text above"),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}