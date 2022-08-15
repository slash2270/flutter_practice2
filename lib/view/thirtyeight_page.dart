import 'package:flutter/material.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_practice2/facebook/facebook_demo.dart';
import 'package:flutter_practice2/demo/scroll_to_index_demo.dart';
import 'package:flutter_practice2/facebook/facebook_login_web.dart';
import 'package:flutter_practice2/inner_drawer/inner_demo.dart';
import 'package:flutter_practice2/instagram/instagram_view.dart';
import 'package:full_screen_menu/full_screen_menu.dart';
import 'package:provider/provider.dart';

import '../az_listview/common/index.dart';
import '../demo/argon_buttons_demo.dart';
import '../inner_drawer/inner_drawer_notifier.dart';
import '../line/line_demo.dart';
import '../util/constants.dart';
import '../util/function_util.dart';
import '../widget/fab_bottom_appbar_widget.dart';
import '../widget/foldable_saidebar_widget.dart';

class ThirtyEightPage extends StatefulWidget {
  const ThirtyEightPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ThirtyEightPageState();
  }
}

class ThirtyEightPageState extends State<ThirtyEightPage> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    _initLine();
    super.initState();
  }

  _initLine(){
    LineSDK.instance.setup(Constants.lineId).then((_) {
      LogUtil.e('LineSDK Prepared');
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (FullScreenMenu.isVisible) {
          FullScreenMenu.hide();
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ThirtyEight Page'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, Constants.routeHome);
              },
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillViewport(
                delegate: SliverChildListDelegate([
                  Image.asset(
                    'assets/google_maps.png',
                    width: 700,
                    fit: BoxFit.fitWidth,
                  ),
                  ChangeNotifierProvider(
                    create: (context) => InnerDrawerNotifier(),
                    child: const InnerDemo(),
                  ),
                  const ArgonButtonDemo(),
                  const ScrollToIndexDemo(title: 'Scroll To Index Demo'),
                  const LineDemo(),
                  FacebookLoginDemo(plugin: FacebookLogin(debug: true)),
                  const FacebookLoginWeb(),
                  const InstagramView(),
                ])
            )
          ],
        ),
        drawer: const FoldableSiderbarWidget(),
        bottomNavigationBar: FABBottomAppBarWidget(
          color: Colors.grey,
          selectedColor: Theme.of(context).accentColor,
          notchedShape: const CircularNotchedRectangle(),
          onTabSelected: (index) {},
          items: [
            FABBottomAppBarItem(iconData: Icons.format_list_bulleted, text: '列表'),
            FABBottomAppBarItem(iconData: Icons.people, text: '人'),
            FABBottomAppBarItem(iconData: Icons.attach_money, text: '錢'),
            FABBottomAppBarItem(iconData: Icons.more_horiz, text: '點'),
          ], centerItemText: '', backgroundColor: Colors.transparent,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () => showFullScreenMenu(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

}