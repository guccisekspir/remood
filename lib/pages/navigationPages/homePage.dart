import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remood/blocs/databaseBloc/bloc/database_bloc.dart';
import 'package:remood/helpers/sizeHelper.dart';
import 'package:remood/locator.dart';
import 'package:remood/models/socialMediaPosts.dart';
import 'package:remood/models/users.dart';
import 'package:remood/widgets/bannerWidget.dart';
import 'package:remood/widgets/socialPostSheet.dart';

class HomePage extends StatefulWidget {
  final Users currentUser;

  const HomePage({Key? key, required this.currentUser}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-12520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-a12520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  ];
  int _current = 0;
  SizeHelper sizeHelper = SizeHelper();

  DatabaseBloc databaseBloc = getIt<DatabaseBloc>();

  bool isDataFetched = false;
  List<SocialMediaPost> postList = [];

  @override
  void initState() {
    // TODO: implement initState
    databaseBloc.add(GetSocialPosts(DateTime.now().millisecondsSinceEpoch));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: databaseBloc,
      listener: (contex, state) {
        if (state is SocialFetchingState) {
          EasyLoading.show();
        } else if (state is SocialFetchedState) {
          EasyLoading.dismiss();
          setState(() {
            isDataFetched = true;
            postList = state.socialPosts;
          });
        } else if (state is SocialetchErrorState) {
          EasyLoading.dismiss();
        }
      },
      child: Scaffold(
        body: isDataFetched
            ? Container(
                height: sizeHelper.height,
                decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.cyan, Colors.blue])),
                child: Column(
                  children: [
                    CarouselSlider(
                      items: imageSliders,
                      options: CarouselOptions(
                          autoPlay: false,
                          enlargeCenterPage: true,
                          aspectRatio: 3.2,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                    ),
                    buildIndicator(),
                    Text("Social Media Feed", style: GoogleFonts.lilitaOne(color: Colors.white, fontSize: 20)),
                    SizedBox(
                      height: sizeHelper.height! * 0.57,
                      child: ListView.builder(
                          itemCount: postList.length,
                          itemBuilder: (context, index) {
                            SocialMediaPost currentPost = postList[index];
                            return SocialPostSheet(
                              currentUser: widget.currentUser,
                              currentPost: currentPost,
                            );
                          }),
                    )
                  ],
                ),
              )
            : Container(
                color: Colors.white,
              ),
      ),
    );
  }

  Widget buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: imgList.map((url) {
        int index = imgList.indexOf(url);
        return Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: _current == index ? Colors.deepPurpleAccent : Colors.deepOrangeAccent),
        );
      }).toList(),
    );
  }
}

final List<Widget> imageSliders = [
  BannerWidget(
      title: "Rozet Avcısı!!!",
      assetPath: "assets/icons/neonClap.png",
      secondAssetPath: "assets/stocks/stock2.png",
      contextStrings: RichText(
        text: TextSpan(text: "Cagri\n", style: GoogleFonts.righteous(color: Colors.black), children: [
          TextSpan(text: "21", style: GoogleFonts.righteous(fontSize: 20, color: Colors.white)),
          TextSpan(text: " rozet kazandı", style: GoogleFonts.righteous(fontSize: 12)),
        ]),
      )),
  BannerWidget(
      title: "Coin Master!",
      assetPath: "assets/icons/hotNeon.png",
      secondAssetPath: "assets/stocks/stock1.png",
      contextStrings: RichText(
        text: TextSpan(text: "Akın\n", style: GoogleFonts.righteous(color: Colors.black), children: [
          TextSpan(text: "6432", style: GoogleFonts.righteous(fontSize: 19, color: Colors.white)),
          TextSpan(text: " moody points", style: GoogleFonts.righteous(fontSize: 12)),
        ]),
      )),
  BannerWidget(
      title: "Best Organizer!",
      assetPath: "assets/icons/userNeon.png",
      secondAssetPath: "assets/stocks/stock3.png",
      contextStrings: RichText(
        text: TextSpan(text: "Eda\n", style: GoogleFonts.righteous(color: Colors.black), children: [
          TextSpan(text: "22", style: GoogleFonts.righteous(fontSize: 19, color: Colors.white)),
          TextSpan(text: " etkinlik düzenlendi", style: GoogleFonts.righteous(fontSize: 12)),
        ]),
      )),
];
