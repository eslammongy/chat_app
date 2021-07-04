import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_chat/bloc/baseBlock/base_cubit.dart';
import 'package:fox_chat/bloc/baseBlock/base_status.dart';
import 'package:fox_chat/model/message_model.dart';
import 'package:fox_chat/model/user_model.dart';
import 'package:fox_chat/style/icon_broken.dart';
import 'package:fox_chat/widgets/text_input_field.dart';
import 'package:hexcolor/hexcolor.dart';

class ChatWithFriend extends StatelessWidget {
  UserModel userModel;
  var messageController = TextEditingController();
  ChatWithFriend({this.userModel});
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      BaseUserCubit.get(context).getMessages(receiverId: userModel.uId);
      return BlocConsumer<BaseUserCubit, BaseUserSatatus>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: HexColor("2A3B90"),
            appBar: AppBar(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage("${userModel.image}"),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: Row(
                    children: [
                      Text(
                        "${userModel.name}",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            height: 1.3,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  )),
                ],
              ),
              backgroundColor: HexColor("2A3B90"),
            ),
            body: ConditionalBuilder(
              condition: BaseUserCubit.get(context).messages.length > 0,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var message =
                                BaseUserCubit.get(context).messages[index];
                            if (BaseUserCubit.get(context).userModel.uId ==
                                message.senderId)
                              return buildSendMessageLayout(message);

                            return buildReceiverMessageLayout(message);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                height: 10,
                              ),
                          itemCount:
                              BaseUserCubit.get(context).messages.length),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(25)),
                            child: TextFormField(
                              controller: messageController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "write your message .."),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.deepOrange[600],
                              borderRadius: BorderRadius.circular(50)),
                          child: MaterialButton(
                            minWidth: 1.0,
                            onPressed: () {
                              var now = DateTime.now();
                              BaseUserCubit.get(context).sendMessage(
                                  receiverId: userModel.uId,
                                  messageText: messageController.text,
                                  dateTime: now.toString());
                            },
                            child: Icon(
                              IconBroken.Send,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      );
    });
  }

  Widget buildSendMessageLayout(MessageModel messageModel) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10),
                  topStart: Radius.circular(10),
                  topEnd: Radius.circular(10)),
              color: Colors.white),
          child: Text("${messageModel.messageText}",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                  color: HexColor("282828"))),
        ),
      );

  Widget buildReceiverMessageLayout(MessageModel messageModel) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(10),
                  topStart: Radius.circular(10),
                  topEnd: Radius.circular(10)),
              color: Colors.amber[900]),
          child: Text("${messageModel.messageText}",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                  color: Colors.white)),
        ),
      );
}
