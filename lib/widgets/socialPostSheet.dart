import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:remood/blocs/databaseBloc/bloc/database_bloc.dart';
import 'package:remood/helpers/sizeHelper.dart';
import 'package:remood/locator.dart';
import 'package:remood/models/socialMediaPosts.dart';
import 'package:remood/models/users.dart';

class SocialPostSheet extends StatefulWidget {
  final SocialMediaPost currentPost;
  final Users currentUser;

  const SocialPostSheet({Key? key, required this.currentPost, required this.currentUser}) : super(key: key);

  @override
  _SocialPostSheetState createState() => _SocialPostSheetState();
}

class _SocialPostSheetState extends State<SocialPostSheet> {
  SizeHelper sizeHelper = SizeHelper();
  late SocialMediaPost currentPost;
  late ConfettiController _controllerBottomCenter;
  @override
  void initState() {
    // TODO: implement initState
    _controllerBottomCenter = ConfettiController(duration: const Duration(seconds: 2));
    currentPost = widget.currentPost;
    super.initState();
  }

  DatabaseBloc databaseBloc = getIt<DatabaseBloc>();

  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(children: [
          Container(
            margin: const EdgeInsets.only(bottom: 6.0),
            height: sizeHelper.height! * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Positioned(
            bottom: 14,
            left: 10,
            child: SizedBox(
              height: sizeHelper.height! * 0.18,
              width: sizeHelper.width! * 0.8,
              child: Image.network(
                currentPost.photoUrl!,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            right: 10,
            child: Column(
              children: [
                IconButton(
                    icon: Icon(
                      LineIcons.heartAlt,
                      color: isLiked ? Colors.redAccent : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;
                        if (isLiked) {
                          _controllerBottomCenter.play();
                          widget.currentUser.moodcoin = widget.currentUser.moodcoin! + 400;
                        } else {
                          widget.currentUser.moodcoin = widget.currentUser.moodcoin! - 400;
                        }
                      });

                      databaseBloc.add(UpdateUser(willUpdateUser: widget.currentUser));
                      if (isLiked) {
                        Future.delayed(const Duration(seconds: 2)).then((value) => showDialog(
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 200),
                                child: Container(
                                  height: sizeHelper.height! * 0.7,
                                  decoration: BoxDecoration(
                                      color: Colors.deepPurpleAccent, borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Tebrikler",
                                          style: GoogleFonts.lilitaOne(color: Colors.white, fontSize: 35),
                                        ),
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: Image.asset("assets/icons/coin.png"),
                                      ),
                                      const Spacer(),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Sosyal medya postunu begenerek 400 MoodPoint kazandınız",
                                            style: GoogleFonts.lilitaOne(color: Colors.white, fontSize: 25),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                              );
                            }));
                      }
                    }),
                Text(currentPost.likeCount.toString()),
                const SizedBox(
                  height: 10,
                ),
                const Icon(LineIcons.comment),
                Text(currentPost.commentCount.toString()),
                const SizedBox(
                  height: 10,
                ),
                Text("400", textAlign: TextAlign.center, style: GoogleFonts.roboto(color: Colors.black)),
                Container(
                  width: 25,
                  height: 25,
                  decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/icons/coin.png"))),
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 10,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, image: DecorationImage(image: NetworkImage(currentPost.ownerPhoto!))),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: sizeHelper.width! * 0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(currentPost.fromWho!),
                          AutoSizeText(
                            currentPost.body!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ),
          Positioned(
            right: 0,
            top: 100,
            child: ConfettiWidget(
              confettiController: _controllerBottomCenter,
              blastDirection: pi, // radial value - RIGHT
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
              confettiController: _controllerBottomCenter,
              blastDirection: 0, // radial value - RIGHT
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
              confettiController: _controllerBottomCenter,
              blastDirection: -pi / 2,
              emissionFrequency: 0.01,
              numberOfParticles: 60,
              maxBlastForce: 20,
              minBlastForce: 10,
              gravity: 0.4,
            ),
          ),
        ]),
      ),
    );
  }
}
