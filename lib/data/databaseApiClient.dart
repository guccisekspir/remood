import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:remood/models/events.dart';
import 'package:remood/models/question.dart';
import 'package:remood/models/socialMediaPosts.dart';
import 'package:remood/models/users.dart';

class DatabaseApiClient {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Users> getUser(String userID) async {
    DocumentSnapshot userData = await firestore.doc("users/$userID").get();

    Users fetchedUser = Users.fromMap(userData.data() as Map<String, dynamic>);
    debugPrint(fetchedUser.name);

    return fetchedUser;
  }

  Future<bool> saveUser(Users willSaveUser) async {
    try {
      firestore.doc("users/${willSaveUser.uid}").set(willSaveUser.toMap());
      return true;
    } catch (e) {
      debugPrint("hata" + e.toString());
      return false;
    }
  }

  Future<List<Event>> saveEvent(Event willSaveEvent) async {
    List<Event> events = [];

    try {
      firestore.collection("events").doc().set(willSaveEvent.toMap());
      events = await getEvent();
    } catch (e) {
      debugPrint("hata" + e.toString());
    }

    return events;
  }

  Future<List<Event>> getEvent() async {
    List<Event> events = [];

    QuerySnapshot eventData = await firestore.collection("events").get();

    for (var element in eventData.docs) {
      Event newEvent = Event.fromMap(element.data.call() as Map<String, dynamic>);
      events.add(newEvent);
      debugPrint("Current event " + newEvent.name!);
    }

    return events;
  }

  Future<List<SocialMediaPost>> getSocialPost() async {
    List<SocialMediaPost> socialPosts = [];

    QuerySnapshot postData = await firestore.collection("socialPosts").get();

    for (var element in postData.docs) {
      socialPosts.add(
        SocialMediaPost.fromMap(element.data.call() as Map<String, dynamic>),
      );
    }
    return socialPosts;
  }

  Future<bool> updateUser(Users willUpdateUser) async {
    firestore.collection("users").doc(willUpdateUser.uid).update(willUpdateUser.toMap());
    return true;
  }

  Future<List<Question>> saveQuestion(Question willSaveQuestion) async {
    List<Question> questions = [];

    try {
      firestore.collection("questions").doc().set(willSaveQuestion.toMap());
      questions = await getQuestion();
    } catch (e) {
      debugPrint("hata" + e.toString());
    }

    return questions;
  }

  Future<List<Question>> getQuestion() async {
    List<Question> questions = [];

    QuerySnapshot eventData = await firestore.collection("questions").get();

    for (var element in eventData.docs) {
      Question newQuestions = Question.fromMap(element.data.call() as Map<String, dynamic>);
      questions.add(newQuestions);
      debugPrint("Current event " + newQuestions.title!);
    }

    return questions;
  }
}
