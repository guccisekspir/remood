import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remood/helpers/sizeHelper.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  SizeHelper sizeHelper = SizeHelper();
  ScrollController gridController = ScrollController();

  late double cardHeight;
  late double cardWidth;
  @override
  void initState() {
    // TODO: implement initState
    cardHeight = sizeHelper.height! * 0.3;
    cardWidth = sizeHelper.width! * 0.4;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              height: sizeHelper.height,
              width: sizeHelper.width,
              child: GridView.builder(
                physics: ClampingScrollPhysics(),
                controller: gridController,
                itemCount: 5,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: sizeHelper.width! * 0.5,
                    childAspectRatio: 1 / 1.2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 0),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: cardHeight,
                      width: cardWidth,
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: cardHeight * 0.6,
                                width: cardWidth,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Stack(
                                  children: [
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          height: cardHeight * 0.3,
                                          width: cardWidth * 0.6,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: AutoSizeText(
                                              " \n        Quiz",
                                              maxLines: 2,
                                              minFontSize: 9,
                                              style: GoogleFonts.lilitaOne(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        )),
                                    Positioned(
                                        bottom: 5,
                                        left: 10,
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxHeight: cardHeight * 0.3,
                                              maxWidth: cardWidth * 0.5),
                                          child: AutoSizeText("asdadsadsada"),
                                        )),
                                    Positioned(
                                        bottom: 5,
                                        right: 5,
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxHeight: cardHeight * 0.3,
                                              maxWidth: cardWidth * 0.3),
                                          child: AutoSizeText("asdadsada"),
                                        ))
                                  ],
                                ),
                              )),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                                height: cardHeight * 0.55,
                                width: cardWidth * 0.5,
                                color: Colors.amber),
                          ),
                        ],
                      ),
                    ),
                  );
                  ;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
