import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState(email: "", password: "")) {
    on<SaveUserEvent>(_onSaveUserEvent);
  }

  void _onSaveUserEvent(SaveUserEvent event, Emitter<UserState> emit) {
    emit(state.copyWith(email: event.email, password: event.password));
  }
}
