import 'package:flutter/material.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';

class FoldableSiderbarWidget extends StatefulWidget{
  const FoldableSiderbarWidget({Key? key}) : super(key: key);

  @override
  State<FoldableSiderbarWidget> createState() => _FoldableSiderbarWidgetState();
}

class _FoldableSiderbarWidgetState extends State<FoldableSiderbarWidget> {

  FSBStatus drawerStatus = FSBStatus.FSB_CLOSE;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FoldableSidebarBuilder(
          drawerBackgroundColor: Colors.deepOrange,
          drawer: CustomDrawer(closeDrawer: (){
            setState(() {
              drawerStatus = FSBStatus.FSB_CLOSE;
            });
          },),
          screenContents: Container(
            color: Colors.black.withAlpha(200),
            child: const Center(child: Text("Click on FAB to Open Drawer",style: TextStyle(fontSize: 20,color: Colors.white),),),
          ),
          status: drawerStatus,
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black87,
            child: const Icon(Icons.menu_book,color: Colors.white,),
            onPressed: () {
              setState(() {
                drawerStatus = drawerStatus == FSBStatus.FSB_OPEN ? FSBStatus.FSB_CLOSE : FSBStatus.FSB_OPEN;
              });
            }),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key, required this.closeDrawer}) : super(key: key);

  final Function closeDrawer;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      color: Colors.white,
      width: mediaQuery.size.width * 0.60,
      height: mediaQuery.size.height,
      child: Column(
        children: <Widget>[
          Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey.withAlpha(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/rps_logo.png",
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("後門工作室")
                ],
              )),
          ListTile(
            onTap: (){
              debugPrint("點擊資料");
            },
            leading: const Icon(Icons.person),
            title: const Text("資料"),
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              debugPrint("點擊設定");
            },
            leading: const Icon(Icons.settings),
            title: const Text("設定"),
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              debugPrint("點擊付款");
            },
            leading: const Icon(Icons.payment),
            title: const Text("付款"),
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              debugPrint("點擊通知");
            },
            leading: const Icon(Icons.notifications),
            title: const Text("通知"),
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              debugPrint("點擊登出");
            },
            leading: const Icon(Icons.exit_to_app),
            title: const Text("登出"),
          ),
        ],
      ),
    );
  }
}