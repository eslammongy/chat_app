import 'package:flutter/cupertino.dart';

abstract class UserLoginStates {}

class UserLoginIntialState extends UserLoginStates {}

class UserLoginLoadingState extends UserLoginStates {}

class UserLoginSuccessState extends UserLoginStates {
  final String userID;
  UserLoginSuccessState({@required this.userID});
}

class UserChangePasswordVisibiltyState extends UserLoginStates {}

class UserLoginErrorState extends UserLoginStates {
  final String errorMessage;
  UserLoginErrorState({this.errorMessage});
}
