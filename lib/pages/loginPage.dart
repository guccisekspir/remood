import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:remood/blocs/authBloc/bloc/auth_bloc.dart';
import 'package:remood/helpers/sizeHelper.dart';
import 'package:remood/locator.dart';
import 'package:remood/pages/navigationPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthBloc authBloc = getIt<AuthBloc>();
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  SizeHelper sizeHelper = SizeHelper();
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Container(
        width: sizeHelper.width,
        height: sizeHelper.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/login-min.png",
                ),
                fit: BoxFit.fill)),
        child: Scaffold(
          body: BlocListener(
            bloc: authBloc,
            listener: (context, state) {
              if (state is AuthLoadingState) {
                EasyLoading.show();
                debugPrint("Loading");
              }
              if (state is AuthCompletedState) {
                EasyLoading.dismiss();
                debugPrint("conpleted" + state.authedUser.uid!);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NavigationPage(
                          currentUser: state.authedUser,
                        )));
              }
              if (state is AuthErrorState) {
                EasyLoading.dismiss();
                scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
                  content: Text(state.errorCode),
                  backgroundColor: Colors.red,
                ));
                debugPrint("Error" + state.errorCode);
              }
            },
            child: Container(
              width: sizeHelper.width,
              height: sizeHelper.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/login-min.png"))),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        authBloc.add(SignInWithGoogleEvent());
                      },
                      child: Container(
                        height: sizeHelper.height! * 0.06,
                        width: sizeHelper.width! * 0.7,
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                            child: Row(
                          children: [
                            Icon(
                              LineIcons.googleLogo,
                              color: Colors.white,
                              size: 50,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Google SignIn",
                                style: GoogleFonts.lilitaOne(
                                    color: Colors.white, fontSize: 25)),
                            Spacer()
                          ],
                        )),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
