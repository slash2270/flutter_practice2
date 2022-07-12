import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../model/model_view.dart';

class GridStairedWidget extends StatelessWidget{
  const GridStairedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      gridDelegate: SliverStairedGridDelegate(
        crossAxisSpacing: 48,
        mainAxisSpacing: 24,
        startCrossAxisDirectionReversed: true,
        pattern: const [
          StairedGridTile(0.5, 1),
          StairedGridTile(0.5, 3 / 4),
          StairedGridTile(1.0, 10 / 4),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
            (context, index) => GridViewTile(index: index),
      ),
    );
  }

}