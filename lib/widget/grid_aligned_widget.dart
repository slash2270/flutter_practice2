import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../model/model_view.dart';

class GridAlignedWidget extends StatelessWidget {
  const GridAlignedWidget({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlignedGridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemBuilder: (context, index) {
        return GridViewTile(
          index: index,
          extent: (index % 7 + 1) * 30,
        );
      },
    );
  }
}