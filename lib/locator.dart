import 'package:get_it/get_it.dart';
import 'package:remood/blocs/authBloc/bloc/auth_bloc.dart';
import 'package:remood/data/databaseApiClient.dart';

import 'blocs/databaseBloc/bloc/database_bloc.dart';
import 'data/authApiClient.dart';
import 'data/authRepository.dart';
import 'data/databaseRepository.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());
  getIt.registerLazySingleton<AuthApiClient>(() => AuthApiClient());
  getIt.registerLazySingleton<DatabaseRepository>(() => DatabaseRepository());
  getIt.registerLazySingleton<DatabaseApiClient>(() => DatabaseApiClient());
  getIt.registerLazySingleton<AuthBloc>(() => AuthBloc());
  getIt.registerLazySingleton<DatabaseBloc>(() => DatabaseBloc());
}
