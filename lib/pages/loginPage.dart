import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:remood/blocs/authBloc/bloc/auth_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: Colors.lightBlue,
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
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    color: Colors.redAccent,
                    onPressed: () {
                      authBloc.add(SignInWithGoogleEvent());
                    },
                    child: Text("Google SignIn"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
