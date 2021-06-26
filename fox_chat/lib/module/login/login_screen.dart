import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fox_chat/bloc/login/login_statas.dart';
import 'package:fox_chat/bloc/login/user_login_cubit.dart';
import 'package:fox_chat/helper/cash_helper.dart';
import 'package:fox_chat/module/home/home_screen.dart';
import 'package:fox_chat/module/register/register_screen.dart';
import 'package:fox_chat/widgets/componant.dart';
import 'package:fox_chat/widgets/text_input_field.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailTextController = TextEditingController();
  var passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserLoginCubit(),
      child: BlocConsumer<UserLoginCubit, UserLoginStates>(
          listener: (context, state) {
        if (state is UserLoginErrorState) {
          showToast(message: state.errorMessage, toastColor: ToastColor.ERROR);
        }
        if (state is UserLoginSuccessState) {
          CacheHelper.saveUserPreferance(key: 'UserID', value: state.userID)
              .then((value) => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false));
        }
      }, builder: (context, state) {
        return Scaffold(
          backgroundColor: HexColor('E7ECEF'),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Center(
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                          fontSize: 50,
                          fontFamily: "Pacifico",
                          fontWeight: FontWeight.w600,
                          color: Colors.amber),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Login now to browse our hot offers ",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "RobotoCondensed",
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: textInputField(
                        controller: emailTextController,
                        type: TextInputType.emailAddress,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return "please enter email address";
                          }
                        },
                        label: "Email Address",
                        prefix: Icons.email_rounded),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: textInputField(
                        controller: passwordTextController,
                        suffix: UserLoginCubit.get(context).suffix,
                        isPassword:
                            UserLoginCubit.get(context).isPasswordShowing,
                        suffixPressed: () {
                          UserLoginCubit.get(context)
                              .changePasswordVisibility();
                        },
                        type: TextInputType.visiblePassword,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return "please enter your password";
                          }
                        },
                        onSubmit: (value) {
                          // if (formGlobalKey.currentState.validate()) {
                          //   UserRegisterCubit.get(context).userLogin(
                          //       email: emailTextController.text,
                          //       password: passwordTextController.text);
                          // }
                        },
                        label: "password",
                        prefix: Icons.lock),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(15),
                    child: ConditionalBuilder(
                      condition: state is! UserLoginLoadingState,
                      builder: (context) => MaterialButton(
                          padding: EdgeInsets.all(12),
                          color: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              UserLoginCubit.get(context).userLogin(
                                  email: emailTextController.text,
                                  password: passwordTextController.text);
                            }
                          },
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don\'t have an account ?",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black45),
                        textAlign: TextAlign.center,
                      ),
                      TextButton(
                        onPressed: () {
                          navigateTo(context, RegisterScreen());
                          Fluttertoast.showToast(
                              msg: "state.loginModel.message",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 3,
                              backgroundColor: Colors.black54,
                              fontSize: 20,
                              textColor: Colors.white);
                        },
                        child: Text(
                          "Sign Up ",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
