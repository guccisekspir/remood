import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BannerWidget extends StatelessWidget {
  final String title;
  final String assetPath;
  final String secondAssetPath;
  final RichText contextStrings;
  const BannerWidget(
      {Key? key,
      required this.title,
      required this.assetPath,
      required this.secondAssetPath,
      required this.contextStrings})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(colors: [Colors.deepPurpleAccent, Colors.deepPurple])),
      margin: const EdgeInsets.all(5.0),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: AutoSizeText(
                title,
                minFontSize: 20,
                style: GoogleFonts.carterOne(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
            ),
          ),
          Row(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  width: 80,
                  height: 88,
                  child: Image.asset(
                    assetPath,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              secondAssetPath,
                            )),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 15, top: 25),
                child: contextStrings,
              )
            ],
          )
        ],
      ),
    );
  }
}
