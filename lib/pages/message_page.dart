import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  static const String routeName = "message";
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments ?? "No_data";

    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text("$args")),
    );
  }
}
