import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("2A3B90"),
      body: Center(
        child: Text("Chat"),
      ),
    );
  }
}
