import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/function_util.dart';
import 'package:flutter_practice2/staggered_gridView/grid_aligned_widget.dart';
import 'package:flutter_practice2/staggered_gridView/grid_masonry_widget.dart';
import 'package:flutter_practice2/staggered_gridView/grid_staggered_widget.dart';
import 'package:flutter_practice2/staggered_gridView/grid_staired_widget.dart';
import 'package:flutter_practice2/staggered_gridView/grid_woven_widget.dart';

import 'grid_quilted_widget.dart';

class StaggeredGridViewDemo extends StatefulWidget {
  const StaggeredGridViewDemo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StaggeredGridViewDemoState();
  }
}

class StaggeredGridViewDemoState extends State<StaggeredGridViewDemo> {

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      delegate: SliverChildListDelegate([
        const MenuEntry(
          title: 'Staggered',
          imageName: 'staggered',
          destination: GridStaggeredWidget(),
        ),
        const MenuEntry(
          title: 'Masonry',
          imageName: 'masonry',
          destination: GridMasonryWidget(),
        ),
        const MenuEntry(
          title: 'Quilted',
          imageName: 'quilted',
          destination: GridQuiltedWidget(),
        ),
        const MenuEntry(
          title: 'Woven',
          imageName: 'woven',
          destination: GridWovenWidget(),
        ),
        const MenuEntry(
          title: 'Staired',
          imageName: 'staired',
          destination: GridStairedWidget(),
        ),
        const MenuEntry(
            title: 'Aligned',
            imageName: 'aligned',
            destination: GridAlignedWidget()),
      ]),
    );
    /*return GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      children: const [
        MenuEntry(
          title: 'Staggered',
          imageName: 'staggered',
          destination: GridStaggeredWidget(),
        ),
        MenuEntry(
          title: 'Masonry',
          imageName: 'masonry',
          destination: GridMasonryWidget(),
        ),
        MenuEntry(
          title: 'Quilted',
          imageName: 'quilted',
          destination: GridQuiltedWidget(),
        ),
        MenuEntry(
          title: 'Woven',
          imageName: 'woven',
          destination: GridWovenWidget(),
        ),
        MenuEntry(
          title: 'Staired',
          imageName: 'staired',
          destination: GridStairedWidget(),
        ),
        MenuEntry(
          title: 'Aligned',
          imageName: 'aligned',
          destination: GridAlignedWidget()
        ),
      ],
    );*/
  }

}

class MenuEntry extends StatelessWidget {
  const MenuEntry({Key? key, required this.title, required this.imageName, required this.destination,}) : super(key: key);

  final String title;
  final Widget destination;
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => destination,
            ),
          );
        },
        child: Stack(
          children: [
            Image.asset(
              'assets/$imageName.png',
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: FractionallySizedBox(
                heightFactor: 0.25,
                alignment: Alignment.bottomCenter,
                child: ColoredBox(
                  color: Colors.black.withOpacity(0.75),
                  child: Center(
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}