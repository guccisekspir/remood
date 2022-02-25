import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:remood/blocs/databaseBloc/bloc/database_bloc.dart';
import 'package:remood/blocs/navbarBloc.dart';
import 'package:remood/models/users.dart';
import 'package:remood/pages/navigationPages/collabPage.dart';
import 'package:remood/pages/navigationPages/eventsPage.dart';
import 'package:remood/pages/navigationPages/homePage.dart';
import 'package:remood/pages/navigationPages/profilePage.dart';

import '../locator.dart';

class NavigationPage extends StatefulWidget {
  final Users currentUser;

  const NavigationPage({Key? key, required this.currentUser}) : super(key: key);
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  late BottomNavBarBloc _bottomNavBarBloc;
  int bottomNavBarIndex = 0;
  late Users currentUser;
  @override
  void initState() {
    currentUser = widget.currentUser;
    _bottomNavBarBloc = BottomNavBarBloc();
    super.initState();
  }

  @override
  void dispose() {
    _bottomNavBarBloc.close();
    super.dispose();
  }

  DatabaseBloc databaseBloc = getIt<DatabaseBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      //Safe areada ne gözükmesini istiyorsan onu yapmak gerekiyor
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, image: DecorationImage(image: AssetImage("assets/icons/coin.png"))),
            ),
            Text(currentUser.moodcoin.toString() + " Mood Points", style: GoogleFonts.roboto(fontSize: 15)),
            const Spacer(),
            const CircleAvatar(
              child: Icon(LineIcons.tasks),
            ),
            const Spacer(),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                AutoSizeText(
                  currentUser.name! + "\n" + currentUser.department!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(fontSize: 10),
                ),
                const SizedBox(
                  width: 5,
                ),
                Stack(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                          image: DecorationImage(image: NetworkImage(currentUser.photoUrl!))),
                    ),
                    Container(
                      width: 15,
                      height: 15,
                      decoration: const BoxDecoration(
                        color: Colors.greenAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: BlocListener(
        bloc: databaseBloc,
        listener: (context, state) {
          if (state is UserUpdated) {
            setState(() {
              currentUser = state.updatedUser;
            });
          }
        },
        child: StreamBuilder(
          //bloc yapımızı seçimlerden haberdar etmek
          stream: _bottomNavBarBloc.itemStream,
          initialData: _bottomNavBarBloc.defaultItem,
          builder:
              // ignore: missing_return
              (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data!) {
                case NavBarItem.home:
                  return HomePage(currentUser: currentUser);

                case NavBarItem.collab:
                  return CollabPage(currentUser: currentUser);
                case NavBarItem.events:
                  return EventsPage(currentUser: currentUser);
                case NavBarItem.profile:
                  return ProfilePage(currentUser: currentUser);
              }
            }
            return Container();
          },
        ),
      ),
      bottomNavigationBar: StreamBuilder(
          //blocdaki streami dinlemek
          stream: _bottomNavBarBloc.itemStream,
          initialData: _bottomNavBarBloc.defaultItem,
          builder: (context, snapshot) {
            return AnimatedBottomNavigationBar.builder(
              backgroundColor: Colors.deepPurpleAccent,
              splashColor: Colors.white,
              activeIndex: bottomNavBarIndex,
              gapLocation: GapLocation.none,

              notchSmoothness: NotchSmoothness.softEdge,
              onTap: (index) => setState(() => {_bottomNavBarBloc.pickItem(index), bottomNavBarIndex = index}),
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

  List<IconData> iconList = [LineIcons.home, LineIcons.handHoldingHeart, LineIcons.tasks, LineIcons.user];

  List<String> navbarString = ["Home", "Collab", "Events", "Profile"];
}
