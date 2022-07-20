import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';

class DraggableBottomSheetDemo extends StatelessWidget {
  const DraggableBottomSheetDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [
      Icons.ac_unit,
      Icons.account_balance,
      Icons.adb,
      Icons.add_photo_alternate,
      Icons.format_line_spacing
    ];

    return Scaffold(
        body: DraggableBottomSheet(
          backgroundWidget: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text('Draggable Bottom Sheet Demo'),
              backgroundColor: Colors.deepOrange,
            ),
            body: SizedBox(
              height: 400,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(vertical: 32),
                itemCount: icons.length,
                itemBuilder: (context, index) => Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.grey, borderRadius: BorderRadius.circular(20)),
                  child: Icon(
                    icons[index],
                    color: Colors.white,
                    size: 60,
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 10),
              ),
            ),
          ),
          previewChild: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20), topRight: Radius.circular(20))),
            child: Column(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 6,
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  '拖我',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: icons.map((icon) {
                      return Container(
                        width: 50,
                        height: 50,
                        margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 6.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(
                          icon,
                          color: Colors.pink,
                          size: 40,
                        ),
                      );
                    }).toList())
              ],
            ),
          ),
          expandedChild: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20), topRight: Radius.circular(20))),
            child: Column(
              children: <Widget>[
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 30,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Hey...我在擴大!!!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: GridView.builder(
                      itemCount: icons.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) => Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(
                          icons[index],
                          color: Colors.pink,
                          size: 40,
                        ),
                      )),
                )
              ],
            ),
          ),
          minExtent: 150,
          maxExtent: MediaQuery.of(context).size.height * 0.8,
        ));
  }
}