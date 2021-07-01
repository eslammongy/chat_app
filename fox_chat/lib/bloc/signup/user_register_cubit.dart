import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_chat/bloc/signup/register_statas.dart';
import 'package:fox_chat/model/user_model.dart';

class UserRegisterCubit extends Cubit<UserRegisterStates> {
  UserRegisterCubit() : super(UserRegisterIntialState());
  static UserRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(
      {@required String name,
      @required String phone,
      @required String email,
      @required String password}) {
    emit(UserRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      //  print(value.user.email);
      createNewUser(
          uId: value.user.uid,
          name: name,
          phone: phone,
          email: email,
          password: password);
      //emit(UserRegisterSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(UserRegisterErrorState(errorMessage: onError.toString()));
    });
  }

  void createNewUser(
      {@required String name,
      @required String phone,
      @required String email,
      @required String password,
      @required String uId}) {
    UserModel userModel = UserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        bio: "Write anything about you..",
        image:
            "https://img2.pngio.com/man-user-avatar-profile-people-icon-person-icon-flat-png-512_512.png",
        password: password,
        isEmailVerified: false);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(CreateUserErrorState(errorMessage: onError.toString()));
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
