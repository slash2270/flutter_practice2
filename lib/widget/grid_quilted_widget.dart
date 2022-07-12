import 'package:flutter/material.dart';
import 'package:flutter_practice2/model/model_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GridQuiltedWidget extends StatelessWidget{
  const GridQuiltedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: const [
          QuiltedGridTile(2, 2),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 2),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
            (context, index) => GridViewTile(index: index),
      ),
    );
  }

}