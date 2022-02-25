import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:remood/helpers/sizeHelper.dart';
import 'package:remood/models/users.dart';
import 'package:remood/pages/loginPage.dart';
import 'package:remood/pages/navigationPage.dart';

class LandPage extends StatefulWidget {
  const LandPage({Key? key}) : super(key: key);

  @override
  _LandPageState createState() => _LandPageState();
}

class _LandPageState extends State<LandPage> {
  String userID = "";

  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 10)
      ..animationDuration = const Duration(milliseconds: 10)
      ..indicatorType = EasyLoadingIndicatorType.cubeGrid
      ..animationStyle = EasyLoadingAnimationStyle.scale
      ..loadingStyle = EasyLoadingStyle.custom
      ..maskType = EasyLoadingMaskType.custom
      ..indicatorSize = 45.0
      ..radius = 20.0
      ..progressColor = Colors.blueAccent
      ..backgroundColor = Colors.white.withOpacity(0.1)
      ..indicatorColor = Colors.blueAccent
      ..textColor = Colors.blue
      ..maskColor = Colors.black.withOpacity(0.7)
      ..userInteractions = true
      ..dismissOnTap = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeHelper(fetchedContext: context);

    return userID == ""
        ? LoginPage()
        : NavigationPage(
            currentUser: Users(),
          );
  }
}
