import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_chat/bloc/baseBlock/base_status.dart';
import 'package:fox_chat/helper/constants.dart';
import 'package:fox_chat/model/user_model.dart';
import 'package:fox_chat/module/chat/chat.dart';
import 'package:fox_chat/module/news_feed/news_feed.dart';
import 'package:fox_chat/module/setting/settings.dart';
import 'package:fox_chat/module/users/users.dart';

class BaseUserCubit extends Cubit<BaseUserSatatus> {
  BaseUserCubit() : super(BaseUserInitialStatus());

  static BaseUserCubit get(context) => BlocProvider.of(context);

  UserModel userModel;
  void getUserDate() {
    emit(BaseGetUserLoadingStatus());

    FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .get()
        .then((value) {
      print(value.data());
      userModel = UserModel.fromJson(value.data());
      emit(BaseGetUserSuccessStatus());
    }).catchError((error) {
      print(error.toString());
      emit(BaseGetUserErrorsStatus(error: error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screenList = [
    NewsFeedScreen(),
    ChatScreen(),
    UserScreen(),
    SettingScreen()
  ];

  List<String> screenTitle = ["Home", "Chat", "Friends", "Setting"];

  void changeBottomNavScreen(int pageIndex) {
    // if (pageIndex == 2) {
    //   emit(BaseAddNewPostStatus());
    // } else {
    currentIndex = pageIndex;
    emit(BaseChangeBottomBarPageStatus());
    //}
  }
}
