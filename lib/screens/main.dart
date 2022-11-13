
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';

import '../my_theme.dart';
import 'cart.dart';
import 'category_list.dart';
import 'filter.dart';
import 'home.dart';
import 'profile.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _currentIndex = 0;
  final _children = [
    Home(),
    const CategoryList(
      is_base_category: true,
    ),
    Home(),
    const Cart(has_bottomnav: true),
    Profile()
  ];

  void onTapped(int i) {
    setState(() {
      _currentIndex = i;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    //re appear statusbar in case it was not there in the previous page
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _children[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //specify the location of the FAB
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom ==
            0.0, // if the kyeboard is open then hide, else show
        child: FloatingActionButton(
          backgroundColor: MyTheme.splash_screen_color,
          // backgroundColor: MyTheme.accent_color,
          onPressed: () {},
          tooltip: "start FAB",
          elevation: 0.0,
          child: Container(
            margin: const EdgeInsets.all(0.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const Filter();
                }));
              },
              child: Icon(
                Icons.search,
                color: MyTheme.white,
                size: 32,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: onTapped,
            currentIndex: _currentIndex,
            backgroundColor: Colors.white.withOpacity(0.8),
            // fixedColor: Theme.of(context).accentColor,
            fixedColor: MyTheme.splash_screen_color,
            unselectedItemColor: const Color.fromRGBO(153, 153, 153, 1),
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/home.png",
                    color: _currentIndex == 0
                        ? MyTheme.splash_screen_color
                        // ? Theme.of(context).accentColor
                        : const Color.fromRGBO(153, 153, 153, 1),
                    height: 20,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/categories.png",
                    color: _currentIndex == 1
                        ? MyTheme.splash_screen_color
                        : const Color.fromRGBO(153, 153, 153, 1),
                    height: 20,
                  ),
                  label: "Categories"),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.circle,
                  color: Colors.transparent,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/cart.png",
                    color: _currentIndex == 3
                        ? MyTheme.splash_screen_color
                        : const Color.fromRGBO(153, 153, 153, 1),
                    height: 20,
                  ),
                  label: "Cart"),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/profile.png",
                    color: _currentIndex == 4
                        ? MyTheme.splash_screen_color
                        : const Color.fromRGBO(153, 153, 153, 1),
                    height: 20,
                  ),
                  label: "Profile"),
            ],
          ),
        ),
      ),
    );
  }
}
