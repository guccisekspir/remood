import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:remood/helpers/sizeHelper.dart';
import 'package:remood/models/question.dart';

class QuestionsSheet extends StatefulWidget {
  final List<Question> currentQuestions;

  const QuestionsSheet({Key? key, required this.currentQuestions})
      : super(key: key);
  @override
  _QuestionsSheetState createState() => _QuestionsSheetState();
}

class _QuestionsSheetState extends State<QuestionsSheet> {
  SizeHelper sizeHelper = SizeHelper();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.currentQuestions.length,
        itemBuilder: (context, index) {
          Question currentQuestion = widget.currentQuestions[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: sizeHelper.height! * 0.15,
              decoration: BoxDecoration(
                  color: Colors.cyan, borderRadius: BorderRadius.circular(15)),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      currentQuestion.fromWhoPhoto!))),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(currentQuestion.title!,
                                style: GoogleFonts.roboto(color: Colors.black)),
                            Text(currentQuestion.fromWhoName! + " sordu...",
                                style:
                                    GoogleFonts.roboto(color: Colors.black54)),
                          ],
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45),
                      child: Text(
                        currentQuestion.body!,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Spacer(),
                        Icon(LineIcons.heartAlt),
                        Text(currentQuestion.likeCount.toString()),
                        Icon(LineIcons.commentAlt),
                        Text(currentQuestion.commentCount.toString()),
                        Spacer(),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("600"),
                        Container(
                          width: 30,
                          height: 30,
                          child: Image.asset("assets/icons/coin.png"),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
