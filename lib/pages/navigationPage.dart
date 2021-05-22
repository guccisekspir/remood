import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:remood/blocs/navbarBloc.dart';
import 'package:remood/models/users.dart';

class NavigationPage extends StatefulWidget {
  final Users currentUser;

  const NavigationPage({Key? key, required this.currentUser}) : super(key: key);
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  late BottomNavBarBloc _bottomNavBarBloc;
  int bottomNavBarIndex = 0;
  @override
  void initState() {
    _bottomNavBarBloc = BottomNavBarBloc();
    super.initState();
  }

  @override
  void dispose() {
    _bottomNavBarBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      //Safe areada ne gözükmesini istiyorsan onu yapmak gerekiyor
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
        //bloc yapımızı seçimlerden haberdar etmek
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder:
            // ignore: missing_return
            (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data!) {
              case NavBarItem.Home:
                return Container(
                  color: Colors.deepOrange,
                );

              case NavBarItem.Collab:
                return Container(
                  color: Colors.amber,
                );
              case NavBarItem.Events:
                return Container(
                  color: Colors.pink,
                );
              case NavBarItem.Profile:
                return Container(
                  color: Colors.red,
                );
            }
          }
          return Container();
        },
      ),
      bottomNavigationBar: StreamBuilder(
          //blocdaki streami dinlemek
          stream: _bottomNavBarBloc.itemStream,
          initialData: _bottomNavBarBloc.defaultItem,
          builder: (context, snapshot) {
            return AnimatedBottomNavigationBar.builder(
              backgroundColor: Color(0XFF41E1F2),
              splashColor: Colors.white,
              activeIndex: bottomNavBarIndex,
              gapLocation: GapLocation.none,

              notchSmoothness: NotchSmoothness.softEdge,
              onTap: (index) => setState(() => {
                    _bottomNavBarBloc.pickItem(index),
                    bottomNavBarIndex = index
                  }),
              itemCount: 4,
              tabBuilder: (int index, bool isActive) {
                final color = isActive ? Colors.white : Colors.black;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      iconList[index],
                      size: 24,
                      color: color,
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: AutoSizeText(
                        navbarString[index],
                        maxLines: 1,
                        style: GoogleFonts.lilitaOne(color: color),
                      ),
                    )
                  ],
                );
              },
              //other params
            );
          }),
    );
  }

  List<IconData> iconList = [
    LineIcons.home,
    LineIcons.handHoldingHeart,
    LineIcons.tasks,
    LineIcons.user
  ];

  List<String> navbarString = ["Home", "Collab", "Events", "Profile"];
}
