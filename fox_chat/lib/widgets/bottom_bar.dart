import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fox_chat/bloc/baseBlock/base_cubit.dart';
import 'package:fox_chat/style/icon_broken.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'componant.dart';

Widget buildBottomBarContainer(BaseUserCubit myCubit) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            spreadRadius: -10,
            blurRadius: 60,
            color: Colors.black.withOpacity(0.8),
            offset: Offset(0, 15),
          )
        ]),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: GNav(
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 600),
        tabs: [
          GButton(
            gap: 10,
            icon: IconBroken.Home,
            iconColor: Colors.black87,
            iconActiveColor: Color(0xffE55800),
            text: "Home",
            textColor: Color(0xffE55800),
            backgroundColor: Colors.deepOrange.withOpacity(0.2),
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          ),
          GButton(
              gap: 10,
              icon: IconBroken.Chat,
              iconColor: Colors.black87,
              iconActiveColor: Color(0xffE55800),
              text: "Chat",
              textColor: Color(0xffE55800),
              backgroundColor: Colors.deepOrange.withOpacity(0.2),
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15)),
          GButton(
              gap: 10,
              icon: IconBroken.User,
              iconColor: Colors.black87,
              iconActiveColor: Color(0xffE55800),
              text: "Friends",
              textColor: Color(0xffE55800),
              backgroundColor: Colors.deepOrange.withOpacity(0.2),
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15)),
          GButton(
              gap: 10,
              icon: IconBroken.Setting,
              iconColor: Colors.black87,
              iconActiveColor: Color(0xffE55800),
              text: "Setting",
              textColor: Color(0xffE55800),
              backgroundColor: Colors.deepOrange.withOpacity(0.2),
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15)),
        ],
        selectedIndex: myCubit.currentIndex,
        onTabChange: (index) {
          myCubit.changeBottomNavScreen(index);
        },
      ),
    ),
  );
}

sendEmailVerfication(BuildContext context) {
  return ConditionalBuilder(
    condition: BaseUserCubit.get(context).userModel != null,
    builder: (context) {
      var userModel = BaseUserCubit.get(context).userModel;
      return Column(
        children: [
          if (!FirebaseAuth.instance.currentUser.emailVerified)
            Container(
              color: Colors.amber,
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.info_outline),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Please Verify Your Email",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  customButton(() {
                    FirebaseAuth.instance.currentUser
                        .sendEmailVerification()
                        .then((value) => showToast(
                            message: "Check Your Inbox ",
                            toastColor: ToastColor.SUCCESS))
                        .catchError((onError) {});
                  }, "Send", 100)
                ],
              ),
            )
        ],
      );
    },
    fallback: (context) => Center(
      child: CircularProgressIndicator(),
    ),
  );
}
