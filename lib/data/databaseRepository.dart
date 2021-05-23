import 'package:remood/data/databaseApiClient.dart';
import 'package:remood/locator.dart';
import 'package:remood/models/events.dart';
import 'package:remood/models/question.dart';
import 'package:remood/models/socialMediaPosts.dart';
import 'package:remood/models/users.dart';

class DatabaseRepository {
  DatabaseApiClient dbApiClient = getIt<DatabaseApiClient>();

  Future<Users> getUser(String userID) async {
    return await dbApiClient.getUser(userID);
  }

  Future<List<Event>> saveEvent(Event willSaveEvent) async {
    return await dbApiClient.saveEvent(willSaveEvent);
  }

  Future<List<Event>> getEvent() async {
    return await dbApiClient.getEvent();
  }

  Future<List<SocialMediaPost>> getSocialPost() async {
    return await dbApiClient.getSocialPost();
  }

  Future<bool> updateUser(Users willUpdateUser) async {
    return await dbApiClient.updateUser(willUpdateUser);
  }

  Future<List<Question>> saveQuestion(Question willSaveQuestion) async {
    return await dbApiClient.saveQuestion(willSaveQuestion);
  }

  Future<List<Question>> getQuestion() async {
    return await dbApiClient.getQuestion();
  }
}
