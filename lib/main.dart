import 'package:chili/bloc/BlocDelegate.dart';
import 'package:chili/ui/screens/Home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(Home());
}
