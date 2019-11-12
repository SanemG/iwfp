import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iwfpapp/screens/shop/main.dart';
import 'package:iwfpapp/screens/cards/main.dart';
import 'package:iwfpapp/screens/contrib/main.dart';
import 'package:iwfpapp/screens/user/main.dart';
import 'package:iwfpapp/services/mode.dart';

class Dest {
  final String title;
  final IconData icon;
  final MaterialColor color;
  final Key btnKey;
  final Key titleKey;
  const Dest(this.title, this.icon, this.color, this.btnKey, this.titleKey);
}

const List<Dest> allDests = <Dest>[
  Dest('Shop Now!', Icons.shopping_cart, Colors.teal, Key('shop_nav_btn'),
      Key('shop_title')),
  Dest('Manage Cards', Icons.credit_card, Colors.cyan, Key('cards_nav_btn'),
      Key('cards_title')),
  Dest('My Settings', Icons.account_circle, Colors.orange, Key('user_nav_btn'),
      Key('user_title')),
  Dest('Contribute', Icons.favorite, Colors.blue, Key('contrib_nav_btn'),
      Key('contrib_title')),
];

class DestView extends StatefulWidget {
  final RunningMode mode;
  const DestView(this.mode, {Key key}) : super(key: key);
  @override
  _DestView createState() {
    return _DestView();
  }
}

class _DestView extends State<DestView> {
  int _currentIndex = 0;
  List<Widget> _children = [];
  final List<Dest> destinations = allDests;

  @override
  void initState() {
    super.initState();
    _children = [
      ShopNow(),
      ManageCard(),
      UserSettings(widget.mode),
      Contrib(),
    ];
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget renderActionBtn(BuildContext context) {
    if (_currentIndex == 1) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_card');
        },
        backgroundColor: Colors.cyan,
        child: Icon(Icons.add),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.mode.devifyString(destinations[_currentIndex].title),
              key: destinations[_currentIndex].titleKey),
          backgroundColor: destinations[_currentIndex].color,
        ),
        backgroundColor: destinations[_currentIndex].color[100],
        body: SafeArea(bottom: true, child: _children[_currentIndex]),
        floatingActionButton: renderActionBtn(context),
        bottomNavigationBar: BottomNavigationBar(
          key: Key('bottom_nav_bar'),
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: destinations.map((Dest destination) {
            return BottomNavigationBarItem(
                icon: Icon(destination.icon, key: destination.btnKey),
                backgroundColor: destination.color,
                title: Text(destination.title));
          }).toList(),
        ));
  }
}
