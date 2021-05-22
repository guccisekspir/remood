import 'package:remood/data/authApiClient.dart';
import 'package:remood/locator.dart';
import 'package:remood/models/users.dart';

class AuthRepository {
  AuthApiClient _authApiClient = getIt<AuthApiClient>();

  Future<Users?> loginWithGoogle() async {
    return await _authApiClient.loginWithGoogle();
  }
}
