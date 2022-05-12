import 'dart:async';

import 'user_event.dart';
import 'user_state.dart';

class UserBloc {
  final UserState _userState = UserState();

  final StreamController<UserEvent> _input = StreamController();
  final StreamController<String> _output = StreamController();

  StreamSink<UserEvent> get sendEvent =>
      _input.sink; // Enviar eventos desde la UI

  Stream<String> get userStream =>
      _output.stream; // Escuchar cambios desde la UI

  UserBloc() {
    _input.stream.listen(_onEvent); // Escuchar eventos
  }

  // Manejador de eventos
  void _onEvent(UserEvent event) {
    if (event is OnChangeEvent) {
      _userState.setUsername(event.value);
    }

    _output.add(_userState.username);
  }

  void dispose() {
    _input.close();
    _output.close();
  }
}
