import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fox_chat/bloc/baseBlock/base_cubit.dart';
import 'package:fox_chat/helper/cash_helper.dart';
import 'package:fox_chat/helper/constants.dart';
import 'package:fox_chat/module/home/home_screen.dart';
import 'package:fox_chat/module/login/login_screen.dart';
import 'package:fox_chat/widgets/componant.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('on background message');
  showToast(message: 'on background message', toastColor: ToastColor.SUCCESS);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var userToken = await FirebaseMessaging.instance.getToken();
  print(userToken);
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(message: "onMessage", toastColor: ToastColor.SUCCESS);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('message when app is open');
    print(event.data.toString());
    showToast(
        message: "message when app is open", toastColor: ToastColor.SUCCESS);
  });

  FirebaseMessaging.onBackgroundMessage(
      (message) => firebaseMessagingBackgroundHandler(message));
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
      create: (context) => BaseUserCubit()
        ..getUserDate()
        ..getPosts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: widget,
      ),
    );
  }
}
