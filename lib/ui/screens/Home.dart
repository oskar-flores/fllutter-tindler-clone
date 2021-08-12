import 'package:chili/bloc/authentication/authentication_bloc.dart';
import 'package:chili/repositories/userRepository.dart';
import 'package:chili/ui/screens/splash.dart';
import 'package:chili/ui/widgets/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final UserRepository _userRepository = UserRepository();
  late AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = AuthenticationBloc(_userRepository);
    _authenticationBloc.add(AppStarted());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authenticationBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder(
            bloc: _authenticationBloc,
            builder: (BuildContext context, AuthenticationState state) {
              if (state is Uninitialized) {
                return Tabs();
              } else
                return Tabs();
            }),
      ),
    );
  }
}
