part of 'database_bloc.dart';

abstract class DatabaseEvent extends Equatable {
  const DatabaseEvent();
}

class SaveEvent extends DatabaseEvent {
  final Event willSaveEvent;

  const SaveEvent({required this.willSaveEvent});

  @override
  // TODO: implement props
  List<Object?> get props => [willSaveEvent];
}

class GetEvents extends DatabaseEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetSocialPosts extends DatabaseEvent {
  final int timeStamp;

  const GetSocialPosts(this.timeStamp);
  @override
  // TODO: implement props
  List<Object?> get props => [timeStamp];
}

class UpdateUser extends DatabaseEvent {
  final Users willUpdateUser;

  const UpdateUser({required this.willUpdateUser});
  @override
  // TODO: implement props
  List<Object?> get props => [willUpdateUser];
}

class SaveQuestion extends DatabaseEvent {
  final Question willSaveQuestions;

  const SaveQuestion({required this.willSaveQuestions});

  @override
  // TODO: implement props
  List<Object?> get props => [willSaveQuestions];
}

class GetQuestion extends DatabaseEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
