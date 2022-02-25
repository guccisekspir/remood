import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:line_icons/line_icons.dart';
import 'package:remood/blocs/databaseBloc/bloc/database_bloc.dart';
import 'package:remood/helpers/sizeHelper.dart';
import 'package:remood/models/question.dart';
import 'package:remood/models/users.dart';
import 'package:remood/widgets/questionsSheet.dart';

import '../../locator.dart';

class CollabPage extends StatefulWidget {
  final Users currentUser;

  const CollabPage({Key? key, required this.currentUser}) : super(key: key);
  @override
  _CollabPageState createState() => _CollabPageState();
}

class _CollabPageState extends State<CollabPage> with SingleTickerProviderStateMixin {
  late TabController tabController;

  DatabaseBloc databaseBloc = getIt<DatabaseBloc>();
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  SizeHelper sizeHelper = SizeHelper();

  bool isEventsLoaded = false;

  List<Question> generalQuestions = [];
  List<Question> departmentQuestions = [];

  @override
  void initState() {
    // TODO: implement initState
    databaseBloc.add(GetQuestion());
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: BlocListener(
        bloc: databaseBloc,
        listener: (context, state) {
          if (state is QuestionsFetchingState) {
            EasyLoading.show();
          } else if (state is QuestionsFetchedState) {
            EasyLoading.dismiss();
            setState(() {
              generalQuestions = state.generalQuestions;
              departmentQuestions = state.departmentQuestions;
              isEventsLoaded = true;
            });
          } else if (state is QuestionsFetchErrorState) {
            debugPrint("Error");
            EasyLoading.dismiss();
            scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
              content: Text(state.errorCode),
              backgroundColor: Colors.red,
            ));
          }
        },
        child: isEventsLoaded
            ? Scaffold(
                floatingActionButton: GestureDetector(
                  onTap: () {
                    databaseBloc.add(
                      SaveQuestion(
                        willSaveQuestions: Question(
                            type: "Department",
                            likeCount: 21,
                            commentCount: 2,
                            body: "Ekde belirttiğim Jira #3214 milestone'una yardımcı olacak birileri var mı?",
                            title: "Yardım Çığlığı :D",
                            fromWhoName: "Sevda",
                            fromWhoPhoto:
                                "https://firebasestorage.googleapis.com/v0/b/remood-11d0c.appspot.com/o/Ekran%20Resmi%202021-05-22%2020.52.30.png?alt=media&token=7ef24439-176f-477c-94f9-848e27bff2f0"),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: const Color(0XFF79BAF2),
                    child: Icon(
                      LineIcons.plus,
                      color: Colors.black.withOpacity(0.6),
                      size: 40,
                    ),
                  ),
                ),
                body: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: Material(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0XFF79BAF2),
                            child: Container(
                              height: sizeHelper.height! * 0.09,
                              child: TabBar(
                                unselectedLabelColor: Colors.black,
                                controller: tabController,
                                labelColor: Colors.white,
                                indicator: const UnderlineTabIndicator(
                                    insets: EdgeInsets.symmetric(horizontal: 30),
                                    borderSide: BorderSide(color: Colors.black, width: 2.0)),
                                tabs: const [
                                  Tab(
                                    icon: Icon(LineIcons.question),
                                    text: "General",
                                  ),
                                  Tab(
                                    icon: Icon(LineIcons.businessTime),
                                    text: "Department",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sizeHelper.height! * 0.70,
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              QuestionsSheet(currentQuestions: generalQuestions),
                              QuestionsSheet(currentQuestions: departmentQuestions),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Container(
                color: Colors.white,
              ),
      ),
    );
  }
}
