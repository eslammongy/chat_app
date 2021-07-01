import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_chat/bloc/baseBlock/base_cubit.dart';
import 'package:fox_chat/bloc/baseBlock/base_status.dart';
import 'package:fox_chat/module/add_new_post.dart';
import 'package:fox_chat/style/icon_broken.dart';
import 'package:fox_chat/widgets/bottom_bar.dart';
import 'package:fox_chat/widgets/componant.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BaseUserCubit, BaseUserSatatus>(
      listener: (context, state) {
        // if (state is BaseAddNewPostStatus) {
        //   navigateTo(context, AddNewPostScreen());
        // }
      },
      builder: (context, state) {
        var baseCubit = BaseUserCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, AddNewPostScreen());
                  },
                  icon: Icon(IconBroken.Plus)),
              IconButton(onPressed: () {}, icon: Icon(IconBroken.Notification)),
              IconButton(onPressed: () {}, icon: Icon(IconBroken.Search))
            ],
            title: Text(
              baseCubit.screenTitle[baseCubit.currentIndex],
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            backgroundColor: HexColor("2A3B90"),
          ),
          backgroundColor: HexColor("2A3B90"),
          body: baseCubit.screenList[baseCubit.currentIndex],
          bottomNavigationBar: buildBottomBarContainer(baseCubit),
        );
      },
    );
  }
}
