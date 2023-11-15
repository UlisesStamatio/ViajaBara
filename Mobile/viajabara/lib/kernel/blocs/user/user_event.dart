part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class SaveUserEvent extends UserEvent {
  final String email;
  final String password;

  const SaveUserEvent({required this.email, required this.password});
}
