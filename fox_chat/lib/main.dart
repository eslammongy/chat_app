import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_chat/bloc/baseBlock/base_cubit.dart';
import 'package:fox_chat/helper/cash_helper.dart';
import 'package:fox_chat/helper/constants.dart';
import 'package:fox_chat/module/home/home_screen.dart';
import 'package:fox_chat/module/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Widget widget;
  userID = CacheHelper.getUserPreferences(key: 'UserID');

  if (userID != null) {
    widget = HomeScreen();
  } else {
    widget = LoginScreen();
  }
  runApp(MyApp(
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget widget;
  MyApp({this.widget});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BaseUserCubit()..getUserDate(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: widget,
      ),
    );
  }
}
