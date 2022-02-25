import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remood/data/databaseRepository.dart';
import 'package:remood/models/events.dart';
import 'package:remood/models/question.dart';
import 'package:remood/models/socialMediaPosts.dart';
import 'package:remood/models/users.dart';

import '../../../locator.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  DatabaseBloc() : super(DatabaseInitial());

  DatabaseRepository dbRepository = getIt<DatabaseRepository>();
  @override
  Stream<DatabaseState> mapEventToState(
    DatabaseEvent event,
  ) async* {
    if (event is SaveEvent) {
      yield EventSavingState();
      try {
        List<Event> outdoorEvents = [];
        List<Event> gameEvents = [];
        List<Event> motivationEvents = [];
        List<Event> currentEvents = await dbRepository.saveEvent(event.willSaveEvent);

        for (var element in currentEvents) {
          if (element.type == "Outdoor") {
            outdoorEvents.add(element);
          }
          if (element.type == "Game") {
            gameEvents.add(element);
          }
          if (element.type == "Motivation") {
            motivationEvents.add(element);
          }
        }

        yield EventSavedState(outdoorEvents: outdoorEvents, gameEvents: gameEvents, motivationEvents: motivationEvents);
      } catch (e) {
        yield EventSavingErrorState(e.toString());
      }
    } else if (event is GetEvents) {
      yield EventFetchingState();
      try {
        List<Event> outdoorEvents = [];
        List<Event> gameEvents = [];
        List<Event> motivationEvents = [];
        List<Event> currentEvents = await dbRepository.getEvent();

        for (var element in currentEvents) {
          if (element.type == "Outdoor") {
            outdoorEvents.add(element);
          }
          if (element.type == "Game") {
            gameEvents.add(element);
          }
          if (element.type == "Motivation") {
            motivationEvents.add(element);
          }
        }

        yield EventFetchedState(
            outdoorEvents: outdoorEvents, gameEvents: gameEvents, motivationEvents: motivationEvents);
      } catch (e) {
        yield EventFetchErrorState(e.toString());
      }
    } else if (event is GetSocialPosts) {
      yield SocialFetchingState();
      try {
        List<SocialMediaPost> postList = await dbRepository.getSocialPost();
        yield SocialFetchedState(socialPosts: postList);
      } catch (e) {
        yield SocialetchErrorState(e.toString());
      }
    } else if (event is UpdateUser) {
      Users willUpdateUser = event.willUpdateUser;
      await dbRepository.updateUser(willUpdateUser);
      yield UserUpdated(updatedUser: willUpdateUser);
    } else if (event is GetQuestion) {
      yield QuestionsFetchingState();
      try {
        List<Question> generalQuestions = [];
        List<Question> departmentQuestions = [];

        List<Question> currentEvents = await dbRepository.getQuestion();

        for (var element in currentEvents) {
          if (element.type == "General") {
            generalQuestions.add(element);
          }
          if (element.type == "Department") {
            departmentQuestions.add(element);
          }
        }

        yield QuestionsFetchedState(generalQuestions: generalQuestions, departmentQuestions: departmentQuestions);
      } catch (e) {
        yield QuestionsFetchErrorState(e.toString());
      }
    } else if (event is SaveQuestion) {
      yield QuestionsSavingState();
      try {
        List<Question> generalQuestions = [];
        List<Question> departmentQuestions = [];

        List<Question> currentEvents = await dbRepository.saveQuestion(event.willSaveQuestions);

        for (var element in currentEvents) {
          if (element.type == "General") {
            generalQuestions.add(element);
          }
          if (element.type == "Department") {
            departmentQuestions.add(element);
          }
        }

        yield QuestionsSavedState(generalQuestions: generalQuestions, departmentQuestions: departmentQuestions);
      } catch (e) {
        yield QuestionsSavingErrorState(e.toString());
      }
    }
  }
}
