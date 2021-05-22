import 'package:remood/data/databaseApiClient.dart';
import 'package:remood/locator.dart';
import 'package:remood/models/users.dart';

class DatabaseRepository {
  DatabaseApiClient dbApiClient = getIt<DatabaseApiClient>();

  Future<Users> getUser(String userID) async {
    return await dbApiClient.getUser(userID);
  }
}
