import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fox_chat/bloc/signup/register_statas.dart';
import 'package:fox_chat/bloc/signup/user_register_cubit.dart';
import 'package:fox_chat/module/home/home_screen.dart';
import 'package:fox_chat/module/login/login_screen.dart';
import 'package:fox_chat/widgets/componant.dart';
import 'package:fox_chat/widgets/text_input_field.dart';
import 'package:hexcolor/hexcolor.dart';

class RegisterScreen extends StatelessWidget {
  var formGlobalKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailTextController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => UserRegisterCubit(),
        child: BlocConsumer<UserRegisterCubit, UserRegisterStates>(
            listener: (context, state) {
          if (state is CreateUserSuccessState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false);
          }
        }, builder: (context, state) {
          return Scaffold(
            backgroundColor: HexColor('E7ECEF'),
            body: SingleChildScrollView(
              child: Form(
                key: formGlobalKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Center(
                      child: Text(
                        "Sign In",
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
                        "create a new account to browse our hot offers ",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "RobotoCondensed",
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: textInputField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "please enter your name";
                            }
                          },
                          label: "Your Name",
                          prefix: Icons.person),
                    ),
                    SizedBox(
                      height: 10,
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
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: textInputField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "please enter phine number";
                            }
                          },
                          label: "Phone Number",
                          prefix: Icons.phone),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: textInputField(
                          controller: passwordTextController,
                          suffix: UserRegisterCubit.get(context).suffix,
                          isPassword:
                              UserRegisterCubit.get(context).isPasswordShowing,
                          suffixPressed: () {
                            UserRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          type: TextInputType.visiblePassword,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "please enter your password";
                            }
                          },
                          onSubmit: (value) {
                            if (formGlobalKey.currentState.validate()) {
                              UserRegisterCubit.get(context).userRegister(
                                  email: emailTextController.text,
                                  password: passwordTextController.text,
                                  phone: phoneController.text,
                                  name: nameController.text);
                            }
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
                        condition: state is! UserRegisterLoadingState,
                        builder: (context) => MaterialButton(
                            padding: EdgeInsets.all(12),
                            color: Colors.deepPurple,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () {
                              if (formGlobalKey.currentState.validate()) {
                                UserRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailTextController.text,
                                    password: passwordTextController.text);
                              }
                            },
                            child: Text(
                              "Register",
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
                          "Already have an account ?",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.black45),
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                          onPressed: () {
                            navigateTo(context, LoginScreen());
                            Fluttertoast.showToast(
                                msg: "state.RegisterModel.message",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 3,
                                backgroundColor: Colors.black54,
                                fontSize: 20,
                                textColor: Colors.white);
                          },
                          child: Text(
                            "Register ",
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
        }));
  }
}
