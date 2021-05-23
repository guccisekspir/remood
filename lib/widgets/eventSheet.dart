import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remood/blocs/databaseBloc/bloc/database_bloc.dart';
import 'package:remood/helpers/sizeHelper.dart';
import 'package:remood/locator.dart';
import 'package:remood/models/events.dart';
import 'package:remood/models/users.dart';
import 'package:remood/widgets/badges.dart';

class EventSheet extends StatefulWidget {
  final List<Event> eventList;
  final Users currentUser;

  const EventSheet(
      {Key? key, required this.eventList, required this.currentUser})
      : super(key: key);

  @override
  _EventSheetState createState() => _EventSheetState();
}

class _EventSheetState extends State<EventSheet>
    with SingleTickerProviderStateMixin {
  SizeHelper sizeHelper = SizeHelper();

  late ConfettiController _controllerBottomCenter;
  DatabaseBloc databaseBloc = getIt<DatabaseBloc>();

  @override
  void initState() {
    // TODO: implement initState
    _controllerBottomCenter =
        ConfettiController(duration: Duration(seconds: 2));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.eventList.length,
        itemBuilder: (context, index) {
          List<Widget?> earnedBadges = [];
          Event currentEvent = widget.eventList[index];
          currentEvent.eventSections!.forEach((element) {
            if (element == "Gönüllülük")
              earnedBadges.add(volunteeringBadge(50, 1));

            if (element == "Farkındalık") earnedBadges.add(donateBadge(50, 1));

            if (element == "Sanat") earnedBadges.add(countBadge(50, 1));

            if (element == "Gezi") earnedBadges.add(natureBadge(50, 1));
            if (element == "Takım Çalışması")
              earnedBadges.add(volunteeringBadge(50, 2));
          });
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 6.0),
                        height: sizeHelper.height! * 0.2,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                          gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Color(0XFF79AEF2),
                                Color(0XFFBBF2ED),
                              ]),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    height: 50,
                    width: 100,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: earnedBadges.length,
                        itemBuilder: (context, index) {
                          return earnedBadges[index]!;
                        }),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(currentEvent.photoUrl!))),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(currentEvent.name!),
                            SizedBox(
                              height: 5,
                            ),
                            AutoSizeText(currentEvent.location!),
                            SizedBox(
                              height: 5,
                            ),
                            AutoSizeText("Time: " + currentEvent.timeStamp!),
                            SizedBox(
                              height: 5,
                            ),
                            AutoSizeText(
                                "Organizer: " + currentEvent.organizerName!),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 5,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [Text("Kazanılacak Rozetler")],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 5,
                  child: MaterialButton(
                    color: Colors.white,
                    onPressed: () {
                      currentEvent.eventSections!.forEach((element) {
                        if (element == "Gönüllülük")
                          widget.currentUser.volunteerRank =
                              widget.currentUser.volunteerRank! + 1;

                        if (element == "Farkındalık")
                          widget.currentUser.farkindalikRank =
                              widget.currentUser.farkindalikRank! + 1;

                        if (element == "Sanat")
                          widget.currentUser.sanatRank =
                              widget.currentUser.sanatRank! + 1;

                        if (element == "Gezi")
                          widget.currentUser.geziRank =
                              widget.currentUser.geziRank! + 1;
                        if (element == "Takım Çalışması")
                          widget.currentUser.takimCalismasiRank =
                              widget.currentUser.takimCalismasiRank! + 1;
                      });
                      widget.currentUser.moodcoin =
                          widget.currentUser.moodcoin! + 400;
                      databaseBloc
                          .add(UpdateUser(willUpdateUser: widget.currentUser));

                      showDialog(
                          context: context,
                          builder: (context) {
                            _controllerBottomCenter.play();
                            return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 200),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: sizeHelper.height! * 0.7,
                                      decoration: BoxDecoration(
                                          color: Colors.deepPurpleAccent,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Tebrikler",
                                              style: GoogleFonts.lilitaOne(
                                                  color: Colors.white,
                                                  fontSize: 35),
                                            ),
                                          ),
                                          Spacer(),
                                          SizedBox(
                                            height: 50,
                                            width: 100,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: earnedBadges.length,
                                                itemBuilder: (context, index) {
                                                  return earnedBadges[index]!;
                                                }),
                                          ),
                                          Spacer(),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Bu etkinlige katılarak yukarıdaki rozetleri ve 400 Mood puanını kazandınız",
                                                style: GoogleFonts.lilitaOne(
                                                    color: Colors.white,
                                                    fontSize: 25),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 100,
                                      child: ConfettiWidget(
                                        confettiController:
                                            _controllerBottomCenter,
                                        blastDirection:
                                            pi, // radial value - RIGHT
                                        emissionFrequency: 0.6,
                                        // set the maximum potential size for the confetti (width, height)
                                        numberOfParticles: 1,
                                        gravity: 0.2,
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 100,
                                      child: ConfettiWidget(
                                        confettiController:
                                            _controllerBottomCenter,
                                        blastDirection:
                                            0, // radial value - RIGHT
                                        emissionFrequency: 0.6,
                                        // set the maximum potential size for the confetti (width, height)
                                        numberOfParticles: 1,
                                        gravity: 0.2,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 200,
                                      child: ConfettiWidget(
                                        confettiController:
                                            _controllerBottomCenter,
                                        blastDirection: -pi / 2,
                                        emissionFrequency: 0.01,
                                        numberOfParticles: 60,
                                        maxBlastForce: 20,
                                        minBlastForce: 10,
                                        gravity: 0.4,
                                      ),
                                    ),
                                  ],
                                ));
                          });
                    },
                    child: Text("Katıl"),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
