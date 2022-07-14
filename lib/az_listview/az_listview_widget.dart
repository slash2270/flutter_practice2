import 'package:flutter/material.dart';
import 'package:flutter_practice2/az_listview/ui/car_models_page.dart';
import 'package:flutter_practice2/az_listview/ui/citylist_custom_header_page.dart';
import 'package:flutter_practice2/az_listview/ui/citylist_page.dart';
import 'package:flutter_practice2/az_listview/ui/contacts_list_page.dart';
import 'package:flutter_practice2/az_listview/ui/contacts_page.dart';
import 'package:flutter_practice2/az_listview/ui/github_language_page.dart';
import 'package:flutter_practice2/az_listview/ui/large_data_page.dart';
import 'package:flutter_practice2/util/function_util.dart';

class AzListViewDemo extends StatefulWidget {
  const AzListViewDemo({Key? key}) : super(key: key);

  @override
  _AzListViewDemoState createState() => _AzListViewDemoState();
}

class _AzListViewDemoState extends State<AzListViewDemo> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
      delegate: SliverChildListDelegate(
        [
          ListTile(
            title: const Text('GitHub Languages', style: TextStyle(color: Colors.grey, backgroundColor: Colors.transparent, fontSize: 17), textAlign: TextAlign.center,),
            onTap: () => _functionUtil.navigateTo(context, (context) => const GitHubLanguagePage()),
          ),
          ListTile(
            title: const Text('Contacts', style: TextStyle(color: Colors.grey, backgroundColor: Colors.transparent, fontSize: 17), textAlign: TextAlign.center,),
            onTap: () => _functionUtil.navigateTo(context, (context) => const ContactsPage()),
          ),
          ListTile(
            title: const Text('Contacts List', style: TextStyle(color: Colors.grey, backgroundColor: Colors.transparent, fontSize: 17), textAlign: TextAlign.center,),
            onTap: () => _functionUtil.navigateTo(context, (context) => const ContactListPage()),
          ),
          ListTile(
            title: const Text('City List', style: TextStyle(color: Colors.grey, backgroundColor: Colors.transparent, fontSize: 17), textAlign: TextAlign.center,),
            onTap: () => _functionUtil.navigateTo(context, (context) => const CityListPage()),
          ),
          ListTile(
            title: const Text('City List(Custom header)', style: TextStyle(color: Colors.grey, backgroundColor: Colors.transparent, fontSize: 17), textAlign: TextAlign.center,),
            onTap: () => _functionUtil.navigateTo(context, (context) => const CityListCustomHeaderPage()),
          ),
          ListTile(
            title: const Text('Car models', style: TextStyle(color: Colors.grey, backgroundColor: Colors.transparent, fontSize: 17), textAlign: TextAlign.center,),
            onTap: () => _functionUtil.navigateTo(context, (context) => const CarModelsPage()),
          ),
          ListTile(
            title: const Text('10000 data', style: TextStyle(color: Colors.grey, backgroundColor: Colors.transparent, fontSize: 17), textAlign: TextAlign.center,),
            onTap: () => _functionUtil.navigateTo(context, (context) => const LargeDataPage()),
          ),
        ].toList(growable: false),
      ), itemExtent: 50.0,
    );
    /*return ListPage([
      PageInfo("GitHub Languages", (ctx) => const GitHubLanguagePage(), false),
      PageInfo("Contacts", (ctx) => const ContactsPage(), false),
      PageInfo("Contacts List", (ctx) => const ContactListPage()),
      PageInfo("City List", (ctx) => const CityListPage(), false),
      PageInfo("City List(Custom header)", (ctx) => const CityListCustomHeaderPage()),
      PageInfo("Car models", (ctx) => const CarModelsPage(), false),
      PageInfo("10000 data", (ctx) => const LargeDataPage(), false),
    ]);*/
  }
}
