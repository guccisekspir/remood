part of 'database_bloc.dart';

abstract class DatabaseState extends Equatable {
  const DatabaseState();
}

class DatabaseInitial extends DatabaseState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class EventSavingState extends DatabaseState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class EventSavedState extends DatabaseState {
  final List<Event> outdoorEvents;
  final List<Event> gameEvents;
  final List<Event> motivationEvents;

  const EventSavedState({required this.outdoorEvents, required this.gameEvents, required this.motivationEvents});
  @override
  // TODO: implement props
  List<Object?> get props => [outdoorEvents, gameEvents, motivationEvents];
}

class EventSavingErrorState extends DatabaseState {
  final String errorCode;

  const EventSavingErrorState(this.errorCode);

  @override
  // TODO: implement props
  List<Object?> get props => [errorCode];
}

class EventFetchingState extends DatabaseState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EventFetchedState extends DatabaseState {
  final List<Event> outdoorEvents;
  final List<Event> gameEvents;
  final List<Event> motivationEvents;

  const EventFetchedState({required this.outdoorEvents, required this.gameEvents, required this.motivationEvents});

  @override
  // TODO: implement props
  List<Object?> get props => [outdoorEvents, gameEvents, motivationEvents];
}

class EventFetchErrorState extends DatabaseState {
  final String errorCode;

  const EventFetchErrorState(this.errorCode);

  @override
  // TODO: implement props
  List<Object?> get props => [errorCode];
}

class SocialFetchingState extends DatabaseState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SocialFetchedState extends DatabaseState {
  final List<SocialMediaPost> socialPosts;

  const SocialFetchedState({required this.socialPosts});

  @override
  // TODO: implement props
  List<Object?> get props => [socialPosts];
}

class SocialetchErrorState extends DatabaseState {
  final String errorCode;

  const SocialetchErrorState(this.errorCode);

  @override
  // TODO: implement props
  List<Object?> get props => [errorCode];
}

class UserUpdated extends DatabaseState {
  final Users updatedUser;

  const UserUpdated({required this.updatedUser});
  @override
  // TODO: implement props
  List<Object?> get props => [updatedUser];
}

class QuestionsFetchingState extends DatabaseState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class QuestionsFetchedState extends DatabaseState {
  final List<Question> generalQuestions;
  final List<Question> departmentQuestions;

  const QuestionsFetchedState({required this.departmentQuestions, required this.generalQuestions});

  @override
  // TODO: implement props
  List<Object?> get props => [generalQuestions, departmentQuestions];
}

class QuestionsFetchErrorState extends DatabaseState {
  final String errorCode;

  const QuestionsFetchErrorState(this.errorCode);

  @override
  // TODO: implement props
  List<Object?> get props => [errorCode];
}

class QuestionsSavingState extends DatabaseState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class QuestionsSavedState extends DatabaseState {
  final List<Question> generalQuestions;
  final List<Question> departmentQuestions;

  const QuestionsSavedState({required this.departmentQuestions, required this.generalQuestions});
  @override
  // TODO: implement props
  List<Object?> get props => [generalQuestions, departmentQuestions];
}

class QuestionsSavingErrorState extends DatabaseState {
  final String errorCode;

  const QuestionsSavingErrorState(this.errorCode);

  @override
  // TODO: implement props
  List<Object?> get props => [errorCode];
}
