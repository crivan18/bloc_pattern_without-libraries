import 'package:bloc_pattern_sin_librerias/blocs/user/user_state.dart';
import 'package:flutter/material.dart';

import '../blocs/user/user_bloc.dart';
import '../blocs/user/user_event.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late TextEditingController _textEditingController;
  final UserBloc _userBloc = UserBloc();

  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController(text: UserState().username);
    _userBloc.sendEvent.add(GetUsernameEvent());
  }

  @override
  void dispose() {
    _userBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<String>(
            stream: _userBloc.userStream,
            builder: (context, snapshot) {
              return Text('User - ${snapshot.data}');
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
          autofocus: false,
          controller: _textEditingController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            helperText: 'Guest by default',
            labelText: 'User Name',
          ),
          onChanged: (value) {
            _userBloc.sendEvent.add(OnChangeEvent(value));
          },
        ),
      ),
    );
  }
}
