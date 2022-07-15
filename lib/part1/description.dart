import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class NotiDes extends StatelessWidget {
  final String title;
  final String des;
  const NotiDes({required this.title, required this.des, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height / 30,
          ),
          Center(
              child: Flexible(
                  child: Text(
            des,
            style: TextStyle(fontSize: 16),
          ))),
          SizedBox(
            height: size.height / 5,
          ),
          Center(
              child: Flexible(
            child: Text("Notification is coming from Firebase Cloud Firestore"),
          ))
        ],
      ),
    );
  }
}
