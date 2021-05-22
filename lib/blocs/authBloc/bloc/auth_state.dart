part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class AuthCompletedState extends AuthState {
  final Users authedUser;

  AuthCompletedState({required this.authedUser});
  @override
  // TODO: implement props
  List<Object?> get props => [authedUser];
}

class AuthLoadingState extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class AuthErrorState extends AuthState {
  final String errorCode;

  AuthErrorState({required this.errorCode});

  @override
  // TODO: implement props
  List<Object?> get props => [errorCode];
}
