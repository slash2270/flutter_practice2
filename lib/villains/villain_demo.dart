import 'package:flutter/material.dart';
import 'package:flutter_practice2/villains/villain_list.dart';
import 'package:flutter_practice2/villains/villain_profile.dart';
import 'package:flutter_practice2/villains/villain_transition.dart';

class VillainContent extends StatefulWidget {
  const VillainContent({Key? key}) : super(key: key);

  @override
  _VillainContentState createState() => _VillainContentState();
}

class _VillainContentState extends State<VillainContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Villain Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (v) => const VillainGrid())),
              child: const Text("Grid"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (v) => const VillainProfile())),
              child: const Text("Profile1"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (v) => const VillainProfile2())),
              child: const Text("Profile2"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (v) => const VillainList())),
              child: const Text("List"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (v) => const VillainProfile2())),
              child: const Text("Profile2 with no hero"),
            ),
          ],
        ),
      ),
    );
  }
}