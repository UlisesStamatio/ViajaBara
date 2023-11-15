part of 'user_bloc.dart';

class UserState extends Equatable {
  final String email;
  final String password;

  const UserState({required this.email, required this.password});

  UserState copyWith({String? email, String? password}) {
    UserState user = UserState(
        email: email ?? this.email, password: password ?? this.password);
    print("UserState - $user");
    return user;
  }

  @override
  List<Object> get props => [email, password];
}
