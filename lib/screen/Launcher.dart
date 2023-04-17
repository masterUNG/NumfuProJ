import 'package:flutter/material.dart';
import 'package:numfu/screen/Test.dart';
import 'package:numfu/screen/feedback.dart';
import 'package:numfu/screen/wallet.dart';
import 'package:numfu/screen/history.dart';
import 'package:numfu/screen/index.dart';
import 'package:numfu/screen/profile.dart';
import 'package:numfu/utility/app_service.dart';
import 'package:numfu/utility/my_constant.dart';
import 'package:numfu/utility/sqlite_helper.dart';

class Launcher extends StatefulWidget {
  static const routeName = '/';

  const Launcher({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LauncherState();
  }
}

class _LauncherState extends State<Launcher> {
  int _selectedIndex = 0;
  final List<Widget> _pageWidget = <Widget>[
    const Index(),
    const Wallet(),
    const History(),
    Profile(),
  ];
  final List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.wallet),
      label: 'Wallet',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.history),
      label: 'History',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    AppService().findPostion();
    SQLiteHelper().readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: _pageWidget.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: _menuBar,
        currentIndex: _selectedIndex,
        backgroundColor: MyCostant.black,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
