import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:remood/locator.dart';
import 'package:remood/pages/landPage.dart';

void main() {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return MaterialApp(
                home: Scaffold(
                    //TODO error verince yeniden bağlandır
                    body: Container(
              child: Text("Nba" + snapshot.error.toString()),
            )));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'reMood',
                theme: ThemeData(
                  hintColor: Colors.white,
                  hoverColor: Colors.white,
                  primarySwatch: Colors.pink,
                  accentColor: Colors.black,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                builder: EasyLoading.init(),
                home: LandPage());
          }

          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                  backgroundColor: Colors.black,
                  body: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        color: Colors.blue,
                      ),
                    ),
                  )));
        });
  }
}
