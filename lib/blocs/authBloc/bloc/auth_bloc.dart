import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:remood/data/authRepository.dart';
import 'package:remood/models/users.dart';

import '../../../locator.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  AuthRepository _authRepository = getIt<AuthRepository>();

  Users? authedUser;

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is SignInWithGoogleEvent) {
      yield AuthLoadingState();
      try {
        authedUser = await _authRepository.loginWithGoogle();
        if (authedUser != null) {
          if (authedUser!.uid != null) {
            yield AuthCompletedState(authedUser: authedUser!);
          }
        }
      } catch (e) {
        debugPrint("Auth error" + e.toString());
        yield AuthErrorState(errorCode: e.toString());
      }
    }
  }
}
