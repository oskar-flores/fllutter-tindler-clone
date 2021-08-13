import 'package:chili/bloc/authentication/authentication_bloc.dart';
import 'package:chili/bloc/signup/sign_up_bloc.dart';
import 'package:chili/repositories/userRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpFrom extends StatefulWidget {
  final UserRepository _userRepository;

  SignUpFrom({required UserRepository userRepository})
      : this._userRepository = userRepository;

  @override
  _SignUpFromState createState() => _SignUpFromState();
}

class _SignUpFromState extends State<SignUpFrom> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late SignUpBloc _signUpBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isSignUpButtonEnabled(SignUpState state) {
    return isPopulated && !state.isSubbmiting;
  }

  @override
  void initState() {
    _signUpBloc = SignUpBloc(userRepository: _userRepository);

    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocListener(
      bloc: _signUpBloc,
      listener: (BuildContext context, SignUpState state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context)
            ..showSnackBar(SnackBar(
                content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("SignUp failed"), Icon(Icons.error)])));
        }
        if (state.isSubbmiting) {
          print("isSubmiting");
          ScaffoldMessenger.of(context)
            ..showSnackBar(SnackBar(
                content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  Text("SigningUp "),
                  CircularProgressIndicator()
                ])));
        }

        if (state.isSuccess) {
          print("Success");
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          Navigator.of(context).pop();
        }
      },
    );
  }

  void _onEmailChanged() {
    _signUpBloc.add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _signUpBloc.add(PasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _signUpBloc.add(SignUpWithCredentialsPressed(
        email: _emailController.text, password: _passwordController.text));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
