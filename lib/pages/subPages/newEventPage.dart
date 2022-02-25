import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:remood/blocs/databaseBloc/bloc/database_bloc.dart';
import 'package:remood/helpers/sizeHelper.dart';
import 'package:remood/models/events.dart';
import 'package:remood/models/users.dart';
import 'package:remood/pages/subPages/textEditPage.dart';

import '../../locator.dart';

class NewEventPage extends StatefulWidget {
  final Users editedUser;
  final DatabaseBloc databaseBloc;

  const NewEventPage({Key? key, required this.editedUser, required this.databaseBloc}) : super(key: key);
  @override
  _NewEventPageState createState() => _NewEventPageState();
}

class _NewEventPageState extends State<NewEventPage> {
  TextStyle myTextStyle = GoogleFonts.roboto(color: Colors.white);
  SizeHelper sizeHelper = SizeHelper();
  late Users editedUser;

  Event? editingEvent = Event();

  //Form Variables//
  final GlobalKey<FormBuilderState> formBuilderKey = GlobalKey<FormBuilderState>();

  TextEditingController nameEditingController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  FocusNode locationFocusNode = FocusNode();
  FocusNode timeFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  FocusNode bioFocusNode = FocusNode();
  //Form Variables//

  Map<String, dynamic>? updatedValues;
  List<String> updatedGenreList = [];

  double? profilePhotoRadius;
  void initSizes() {
    profilePhotoRadius = sizeHelper.height! * 0.1;
  }

  void initControllers() {}

  @override
  void initState() {
    editedUser = widget.editedUser;
    initControllers();
    // TODO: implement initState
    initSizes();
    super.initState();
  }

  Event willSaveEvent = Event();
  DatabaseBloc databaseBloc = getIt<DatabaseBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Event Creator"),
        actions: [
          IconButton(
              icon: const Icon(Icons.done),
              onPressed: () {
                if (formBuilderKey.currentState!.validate()) {
                  debugPrint(willSaveEvent.location);
                  debugPrint(willSaveEvent.name);
                  debugPrint(willSaveEvent.department);
                  willSaveEvent.organizerName = widget.editedUser.name;
                  willSaveEvent.photoUrl = "https://i.scdn.co/image/ab67616d00001e028d57767a3be13ebbedeff86e";
                  willSaveEvent.joinersID = [widget.editedUser.uid!];
                  willSaveEvent.joinersPhoto = [widget.editedUser.photoUrl!];
                  databaseBloc.add(SaveEvent(willSaveEvent: willSaveEvent));
                }
              })
        ],
      ),
      body: BlocListener(
        bloc: databaseBloc,
        listener: (context, state) {
          if (state is EventSavingState) {
            EasyLoading.show();
          } else if (state is EventSavedState) {
            Navigator.of(context).pop(state);
          } else if (state is EventSavingErrorState) {
            debugPrint("Hata");
          }
        },
        child: Container(
          height: sizeHelper.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
              Color(0XFF79AEF2),
              Color(0XFFBBF2ED),
            ]),
          ),
          child: SingleChildScrollView(
            child: FormBuilder(
              key: formBuilderKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Text("Event Type",
                        style: GoogleFonts.roboto(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Center(
                      child: FormBuilderFilterChip(
                          backgroundColor: Colors.amber,
                          disabledColor: Colors.grey,
                          selectedColor: Colors.pinkAccent,
                          spacing: 10,
                          name: "type",
                          maxChips: 1,
                          onChanged: (List<String>? choices) {
                            if (choices != null) {
                              if (choices.isNotEmpty) willSaveEvent.type = choices[0];
                            }
                          },
                          options: const [
                            FormBuilderFieldOption(value: 'Outdoor', child: const Text('Outdoor')),
                            FormBuilderFieldOption(value: 'Game', child: const Text('Game')),
                            FormBuilderFieldOption(value: 'Motivation', child: const Text('Motivation')),
                          ]),
                    ),
                  ),
                  Center(
                    child: Text("Event Department",
                        style: GoogleFonts.roboto(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Center(
                      child: FormBuilderFilterChip(
                          backgroundColor: Colors.amber,
                          disabledColor: Colors.grey,
                          selectedColor: Colors.pinkAccent,
                          spacing: 10,
                          name: "department",
                          maxChips: 1,
                          onChanged: (List<String>? choices) {
                            if (choices != null) {
                              if (choices.isNotEmpty) willSaveEvent.department = choices[0];
                            }
                          },
                          options: const [
                            FormBuilderFieldOption(value: 'Global', child: Text('Global')),
                            FormBuilderFieldOption(value: 'IT', child: Text('IT')),
                            FormBuilderFieldOption(value: 'Marketing', child: Text('Marketing')),
                            FormBuilderFieldOption(value: 'HR', child: Text('HR')),
                            FormBuilderFieldOption(value: 'Sales', child: Text('Sales')),
                          ]),
                    ),
                  ),
                  Center(
                    child: Text("Event Sections",
                        style: GoogleFonts.roboto(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Center(
                      child: FormBuilderFilterChip(
                          backgroundColor: Colors.amber,
                          disabledColor: Colors.grey,
                          selectedColor: Colors.pinkAccent,
                          spacing: 10,
                          name: "sections",
                          maxChips: 3,
                          onChanged: (List<String>? choices) {
                            if (choices != null) {
                              if (choices.isNotEmpty) {
                                willSaveEvent.eventSections = [];
                              }
                              for (var element in choices) {
                                willSaveEvent.eventSections!.add(element);
                              }
                            }
                          },
                          options: const [
                            FormBuilderFieldOption(value: 'Gönüllülük', child: Text('Gönüllülük')),
                            FormBuilderFieldOption(value: 'Farkındalık', child: Text('Farkındalık')),
                            FormBuilderFieldOption(value: 'Sanat', child: Text('Sanat')),
                            FormBuilderFieldOption(value: 'Gezi', child: Text('Gezi')),
                            FormBuilderFieldOption(value: 'Takım Çalışması', child: Text('Takım Çalışması')),
                          ]),
                    ),
                  ),
                  myInputForm(
                      willSaveEvent: willSaveEvent,
                      isActive: false,
                      context: context,
                      textEditingController: nameEditingController,
                      focusNode: nameFocusNode,
                      title: "name"),
                  myInputForm(
                      willSaveEvent: willSaveEvent,
                      isActive: false,
                      context: context,
                      textEditingController: locationController,
                      focusNode: locationFocusNode,
                      title: "location"),
                  myInputForm(
                      willSaveEvent: willSaveEvent,
                      isActive: false,
                      context: context,
                      textEditingController: timeController,
                      focusNode: timeFocusNode,
                      title: "time(GG-AA-YYYY)"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget myInputForm({
  Event? willSaveEvent,
  required BuildContext context,
  required isActive,
  required TextEditingController textEditingController,
  required FocusNode focusNode,
  required String title,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: FormBuilderTextField(
      name: title,
      onTap: () async {
        if (!isActive) {
          String? result = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TextEditPage(
                  unChangedValue: textEditingController.text,
                  textEditingController: textEditingController,
                  focusNode: focusNode,
                  title: title)));
          if (result != null) {
            if (title == "name") {
              willSaveEvent?.name = result;
            }
            if (title == "time(GG-AA-YYYY)") {
              willSaveEvent?.timeStamp = result;
            }
            if (title == "location") {
              willSaveEvent?.location = result;
            }
          }
        }
      },
      autovalidateMode: AutovalidateMode.always,
      readOnly: !isActive,
      focusNode: focusNode,
      controller: textEditingController,
      maxLines: title == "Biography" ? 2 : 1,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.white)),
          labelText: title,
          labelStyle: const TextStyle(color: Colors.white)),
    ),
  );
}
