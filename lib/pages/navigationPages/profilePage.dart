import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:remood/helpers/sizeHelper.dart';
import 'package:remood/models/users.dart';
import 'package:remood/widgets/badges.dart';

class ProfilePage extends StatefulWidget {
  final Users currentUser;

  const ProfilePage({Key? key, required this.currentUser}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Users currentUser;
  SizeHelper sizeHelper = SizeHelper();
  @override
  void initState() {
    // TODO: implement initState
    currentUser = widget.currentUser;
    super.initState();
  }

  TextStyle textStyle1 = GoogleFonts.lilitaOne(color: Colors.white, fontSize: 25);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: sizeHelper.width,
        height: sizeHelper.height,
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.cyan, Colors.lightBlue])),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.cyanAccent,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(currentUser.photoUrl!),
              ),
            ),
            Text(
              currentUser.name!,
              style: textStyle1,
            ),
            Text(
              currentUser.department!,
              style: textStyle1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Rozetleri", style: GoogleFonts.lilitaOne(color: Colors.black, fontSize: 25)),
            ),
            badgeMaker(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Ulasılabilirlik", style: GoogleFonts.lilitaOne(color: Colors.black, fontSize: 25)),
            ),
            const Text(
              "Müsait Zaman \nDilimleri\n 11:00-15:00\nGMT+3",
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(
                  LineIcons.instagram,
                  color: Colors.pink,
                  size: 60,
                ),
                Icon(
                  LineIcons.github,
                  color: Colors.white,
                  size: 60,
                ),
                Icon(
                  LineIcons.telegram,
                  size: 60,
                ),
                Icon(
                  LineIcons.whatSApp,
                  color: Colors.lightGreenAccent,
                  size: 60,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Son etkinlikleri", style: GoogleFonts.lilitaOne(color: Colors.black, fontSize: 25)),
            ),
          ],
        ),
      ),
    );
  }

  Widget badgeMaker() {
    double size = 60;
    List<Widget> badges = [];
    if (currentUser.farkindalikRank! % 2 > 1) {
      badges.add(donateBadge(size, 3));
    } else {
      badges.add(donateBadge(size, 2));
    }
    if (currentUser.geziRank! % 2 > 1) {
      badges.add(natureBadge(size, 3));
    } else {
      badges.add(natureBadge(size, 2));
    }
    if (currentUser.volunteerRank! % 2 > 1) {
      badges.add(volunteeringBadge(size, 3));
    } else {
      badges.add(volunteeringBadge(size, 2));
    }
    badges.add(countBadge(size, 2));
    badges.add(donateBadge(size, 3));
    badges.add(volunteeringBadge(size, 1));
    return SizedBox(
      height: 80,
      width: sizeHelper.width,
      child: ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          itemCount: badges.length,
          itemBuilder: (context, index) {
            return badges[index];
          }),
    );
  }
}
