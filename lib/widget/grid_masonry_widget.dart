import 'package:flutter/material.dart';
import 'package:flutter_practice2/model/model_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GridMasonryWidget extends StatelessWidget{
  const GridMasonryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemBuilder: (context, index) {
        return GridViewTile(
          index: index,
          extent: (index % 5 + 1) * 100,
        );
      },
    );
  }

}