import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_form_state.dart';

class LoginFormCubit extends Cubit<LoginFormState> {
  LoginFormCubit() : super(LoginFormState());

  void onSubmit() {
    print('Submit $state');
  }

  void usernameChanged(String value) {
    emit(state.copyWith(username: value));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value));
  }
}
