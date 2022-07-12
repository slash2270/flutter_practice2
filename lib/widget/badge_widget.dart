import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class BadgeWidget extends StatefulWidget {
  const BadgeWidget({Key? key}) : super(key: key);

  @override
  _BadgeWidgetState createState() => _BadgeWidgetState();
}

class _BadgeWidgetState extends State<BadgeWidget> {
  int _counter = 0;
  bool showElevatedButtonBadge = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: _bottomNavigationBar(),
        appBar: AppBar(
          leading: Badge(
            position: BadgePosition.topEnd(top: 10, end: 10),
            badgeContent: null,
            child: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
          ),
          title: const Text('TwentyEight Page', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          actions: <Widget>[
            _shoppingCartBadge(),
          ],
          bottom: _tabBar(),
        ),
        body: Column(
          children: <Widget>[
            _addRemoveCartButtons(),
            _textBadge(),
            _directionalBadge(),
            _elevatedButtonBadge(),
            _chipWithZeroPadding(),
            expandedBadge(),
            _badgeWithZeroPadding(),
            _badgesWithBorder(),
            _listView(),
          ],
        ),
      ),
    );
  }

  Widget expandedBadge() {
    return Expanded(
      child: Center(
        child: Badge(
          badgeContent: const Text('10'),
          child: const Icon(Icons.person, size: 30),
        ),
      ),
    );
  }

  Widget _shoppingCartBadge() {
    return Badge(
      position: BadgePosition.topEnd(top: 0, end: 3),
      animationDuration: const Duration(milliseconds: 300),
      animationType: BadgeAnimationType.slide,
      badgeContent: Text(
        _counter.toString(),
        style: const TextStyle(color: Colors.white),
      ),
      child: IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {}),
    );
  }

  PreferredSizeWidget _tabBar() {
    return TabBar(tabs: [
      Tab(
        icon: Badge(
          badgeColor: Colors.blue,
          badgeContent: const Text(
            '3',
            style: TextStyle(color: Colors.white),
          ),
          child: const Icon(Icons.account_balance_wallet, color: Colors.grey),
        ),
      ),
      Tab(
        icon: Badge(
          shape: BadgeShape.square,
          borderRadius: BorderRadius.circular(5),
          position: BadgePosition.topEnd(top: -12, end: -20),
          padding: const EdgeInsets.all(2),
          badgeContent: const Text(
            '新',
            style: TextStyle(
                color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
          ),
          child: Text(
            '音樂',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
      ),
    ]);
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        const BottomNavigationBarItem(
          label: '活動',
          icon: Icon(Icons.event),
        ),
        const BottomNavigationBarItem(
          label: '訊息',
          icon: Icon(Icons.message),
        ),
        BottomNavigationBarItem(
          label: '安裝',
          icon: Badge(
            shape: BadgeShape.circle,
            position: BadgePosition.center(),
            borderRadius: BorderRadius.circular(100),
            badgeContent: Container(
              height: 5,
              width: 5,
              decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            ),
            child: const Icon(Icons.settings),
          ),
        ),
      ],
    );
  }

  Widget _addRemoveCartButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _counter++;
                });
              },
              icon: const Icon(Icons.add),
              label: const Text('添加到購物車')),
          ElevatedButton.icon(
              onPressed: () {
                if (_counter > 0) {
                  setState(() {
                    _counter--;
                  });
                }
              },
              icon: const Icon(Icons.remove),
              label: const Text('從購物車中刪除')),
        ],
      ),
    );
  }

  Widget _textBadge() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Badge(
        padding: const EdgeInsets.all(6),
        gradient: const LinearGradient(colors: [
          Colors.black,
          Colors.red,
        ]),
        badgeContent: const Text(
          '!',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        position: BadgePosition.topStart(top: -15),
        child: const Text('這是一個文本'),
      ),
    );
  }

  Widget _elevatedButtonBadge() {
    return Badge(
      showBadge: showElevatedButtonBadge,
      padding: const EdgeInsets.all(8),
      badgeColor: Colors.deepPurple,
      badgeContent: const Text(
        '!',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            showElevatedButtonBadge = !showElevatedButtonBadge;
          });
        },
        child: const Text('凸起按鈕'),
      ),
    );
  }

  Widget _chipWithZeroPadding() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
      Text('零填充芯片:'),
      Chip(
        label: Text('哈瞜'),
        padding: EdgeInsets.all(0),
      ),
    ]);
  }

  Widget _badgeWithZeroPadding() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('徽章:'),
        for (int i = 0; i < 5; i++)
          _getExampleBadge(padding: (i * 2).toDouble())
      ],
    );
  }

  Widget _getExampleBadge({double? padding}) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Badge(
        badgeColor: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(20),
        padding: EdgeInsets.all(padding ?? 4),
        shape: BadgeShape.square,
        badgeContent: const Text(
          '哈瞜',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _badgesWithBorder() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text('帶邊框的徽章：'),
          Badge(
            position: BadgePosition.topEnd(top: 0, end: 2),
            elevation: 0,
            shape: BadgeShape.circle,
            badgeColor: Colors.red,
            borderSide: const BorderSide(color: Colors.black),
            child: const Icon(
              Icons.person,
              size: 30,
            ),
          ),
          Badge(
            position: BadgePosition.topEnd(top: -5, end: -5),
            shape: BadgeShape.square,
            badgeColor: Colors.blue,
            badgeContent: const SizedBox(
              height: 5,
              width: 5,
            ),
            elevation: 0,
            borderSide: const BorderSide(
              color: Colors.black,
              width: 3,
            ),
            child: const Icon(
              Icons.games_outlined,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _listView() {
    Widget _listTile(String title, String value) {
      return ListTile(
        dense: true,
        title: Text(title, style: const TextStyle(fontSize: 16)),
        trailing: SizedBox(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Badge(
                elevation: 0,
                shape: BadgeShape.circle,
                padding: const EdgeInsets.all(7),
                badgeContent: Text(
                  value,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.separated(
        itemCount: 3,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return _listTile('訊息', '2');
            case 1:
              return _listTile('朋友', '7');
            case 2:
            default:
              return _listTile('活動', '!');
          }
        },
      ),
    );
  }

  Widget _directionalBadge() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Badge(
        elevation: 0,
        position: BadgePosition.topEnd(),
        padding: const EdgeInsetsDirectional.only(end: 4),
        badgeColor: Colors.transparent,
        badgeContent: const Icon(Icons.error, size: 16.0, color: Colors.red),
        child: const Text('這是RTL'),
      ),
    );
  }
}