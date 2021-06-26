import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_chat/bloc/login/login_statas.dart';

class UserLoginCubit extends Cubit<UserLoginStates> {
  UserLoginCubit() : super(UserLoginIntialState());
  static UserLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({@required String email, @required String password}) {
    emit(UserLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user.email);
      emit(UserLoginSuccessState(userID: value.user.uid));
    }).catchError((onError) {
      emit(UserLoginErrorState());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShowing = true;
  void changePasswordVisibility() {
    isPasswordShowing = !isPasswordShowing;
    suffix = isPasswordShowing
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;

    emit(UserChangePasswordVisibiltyState());
  }
}
