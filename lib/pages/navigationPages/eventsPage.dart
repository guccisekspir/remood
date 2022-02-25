import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:line_icons/line_icons.dart';
import 'package:remood/blocs/databaseBloc/bloc/database_bloc.dart';
import 'package:remood/helpers/sizeHelper.dart';
import 'package:remood/locator.dart';
import 'package:remood/models/events.dart';
import 'package:remood/models/users.dart';
import 'package:remood/pages/subPages/newEventPage.dart';
import 'package:remood/widgets/eventSheet.dart';

class EventsPage extends StatefulWidget {
  final Users currentUser;

  const EventsPage({Key? key, required this.currentUser}) : super(key: key);

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> with SingleTickerProviderStateMixin {
  late TabController tabController;

  DatabaseBloc databaseBloc = getIt<DatabaseBloc>();
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  SizeHelper sizeHelper = SizeHelper();

  bool isEventsLoaded = false;
  List<Event> outdoorEvents = [];
  List<Event> gameEvents = [];
  List<Event> motivationEvents = [];

  @override
  void initState() {
    // TODO: implement initState
    databaseBloc.add(GetEvents());
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: BlocListener(
        bloc: databaseBloc,
        listener: (context, state) {
          if (state is EventFetchingState) {
            EasyLoading.show();
          }
          if (state is EventFetchedState) {
            EasyLoading.dismiss();
            setState(() {
              isEventsLoaded = true;
              outdoorEvents = state.outdoorEvents;
              gameEvents = state.gameEvents;
              motivationEvents = state.motivationEvents;
            });
          }
          if (state is EventFetchErrorState) {
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
                  onTap: () async {
                    EventSavedState state = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewEventPage(
                          editedUser: widget.currentUser,
                          databaseBloc: databaseBloc,
                        ),
                      ),
                    );
                    setState(() {
                      EasyLoading.dismiss();
                      isEventsLoaded = true;
                      outdoorEvents = state.outdoorEvents;
                      gameEvents = state.gameEvents;
                      motivationEvents = state.motivationEvents;
                    });
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
                body: SingleChildScrollView(
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
                                  borderSide: const BorderSide(color: Colors.black, width: 2.0)),
                              tabs: const [
                                Tab(
                                  icon: Icon(LineIcons.cowboyHatSide),
                                  text: "Outdoor",
                                ),
                                Tab(
                                  icon: const Icon(LineIcons.gamepad),
                                  text: "Game",
                                ),
                                Tab(
                                  icon: const Icon(LineIcons.peace),
                                  text: "Motivation",
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: sizeHelper.height! * 0.70,
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            EventSheet(
                              eventList: outdoorEvents,
                              currentUser: widget.currentUser,
                            ),
                            EventSheet(eventList: gameEvents, currentUser: widget.currentUser),
                            EventSheet(
                              eventList: motivationEvents,
                              currentUser: widget.currentUser,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Container(
                color: Colors.white,
              ),
      ),
    );
  }

  saveEvent() {
    databaseBloc.add(SaveEvent(
        willSaveEvent: Event(
            name: "Deneme Event",
            eventSections: ["Gönüllülük,", "Takım Çalışması"],
            location: "Yıldız Hatıra Ormanı",
            timeStamp: "21.11.2021",
            organizerName: "Çağrı",
            organizerUid: "asdasdasda",
            winnerTags: ["Nature", "Gonullu"],
            photoUrl: "asdadas",
            department: "Global",
            type: "Outdoor")));
  }
}
