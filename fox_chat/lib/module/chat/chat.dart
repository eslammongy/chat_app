import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_chat/bloc/baseBlock/base_cubit.dart';
import 'package:fox_chat/bloc/baseBlock/base_status.dart';
import 'package:fox_chat/model/user_model.dart';
import 'package:fox_chat/module/users/chat_with_friend.dart';
import 'package:fox_chat/widgets/componant.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BaseUserCubit, BaseUserSatatus>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: BaseUserCubit.get(context).allUsers.length > 0,
            builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildChatLayout(
                    BaseUserCubit.get(context).allUsers[index], context),
                separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        color: Colors.grey[600],
                        thickness: 1,
                      ),
                    ),
                itemCount: BaseUserCubit.get(context).allUsers.length),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Widget buildChatLayout(UserModel userModel, BuildContext context) => InkWell(
        onTap: () {
          navigateTo(
              context,
              ChatWithFriend(
                userModel: userModel,
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: userModel.image == null
                    ? NetworkImage(
                        "https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper-thumbnail.png")
                    : NetworkImage("${userModel.image}"),
              ),
              SizedBox(
                width: 35,
              ),
              Expanded(
                  child: Row(
                children: [
                  Text(
                    "${userModel.name}",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.check_circle,
                    color: Colors.blue[300],
                    size: 18.0,
                  ),
                ],
              )),
              IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
            ],
          ),
        ),
      );
}
