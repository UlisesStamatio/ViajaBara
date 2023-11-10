part of 'login_form_cubit.dart';

enum FormStatus { invalid, valid, validating, posting }

class LoginFormState extends Equatable {
  final FormStatus formStatus;
  final String username;
  final String password;

  const LoginFormState(
      {this.formStatus = FormStatus.invalid,
      this.username = '',
      this.password = ''});

  LoginFormState copyWith({
    FormStatus? formStatus,
    String? username,
    String? password,
  }) =>
      LoginFormState(
        formStatus: formStatus ?? this.formStatus,
        username: username ?? this.username,
        password: password ?? this.password,
      );

  @override
  List<Object> get props => [formStatus, username, password];
}
