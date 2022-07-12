import 'package:flutter/material.dart';
import 'package:flutter_practice2/model/model_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GridWovenWidget extends StatelessWidget{
  const GridWovenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      gridDelegate: SliverWovenGridDelegate.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        pattern: const [
          WovenGridTile(1),
          WovenGridTile(5 / 7,
            crossAxisRatio: 0.9,
            alignment: AlignmentDirectional.centerEnd,
          ),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
            (context, index) => GridViewTile(index: index),
      ),
    );
  }

}