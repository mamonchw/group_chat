import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class NotiDes extends StatefulWidget {
  final String title;
  final String des;
  const NotiDes({required this.title, required this.des, Key? key})
      : super(key: key);

  //SecondScreen({Key key, @required this.text}) : super(key: key);

  @override
  State<NotiDes> createState() => _NotiDesState();
}

class _NotiDesState extends State<NotiDes> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height / 30,
          ),
          Center(
              child: Text(
            widget.des,
            style: TextStyle(fontSize: 16),
          )),
          SizedBox(
            height: size.height / 5,
          ),
          Center(
              child:
                  Text("Notification is coming from Firebase Cloud Firestore"))
        ],
      ),
    );
  }
}
