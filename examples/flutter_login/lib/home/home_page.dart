import 'package:flutter_web/material.dart';

import 'package:flutter_web_bloc/flutter_bloc.dart';

import 'package:flutter_web_login/authentication/authentication.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Center(
            child: RaisedButton(
          child: Text('logout'),
          onPressed: () {
            authenticationBloc.dispatch(LoggedOut());
          },
        )),
      ),
    );
  }
}
