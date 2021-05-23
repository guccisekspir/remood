import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:remood/pages/subPages/newEventPage.dart';

class TextEditPage extends StatelessWidget {
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final String title;
  final String unChangedValue;

  const TextEditPage(
      {Key? key,
      required this.textEditingController,
      required this.focusNode,
      required this.title,
      required this.unChangedValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        debugPrint("wilpop");
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
              focusNode.unfocus();
            },
          ),
          title: Text(title),
          actions: [
            IconButton(
                icon: Icon(Icons.done),
                onPressed: () {
                  unChangedValue == textEditingController.text
                      ? Navigator.of(context).pop()
                      : Navigator.of(context).pop(textEditingController.text);
                })
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            myInputForm(
                context: context,
                isActive: true,
                textEditingController: textEditingController,
                focusNode: focusNode,
                title: title),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AutoSizeText(
                "profile-edit-$title",
                style: GoogleFonts.roboto(color: Colors.white60),
              ),
            )
          ],
        ),
      ),
    );
  }
}
