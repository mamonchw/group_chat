import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:group_chat/part1/Notifications.dart';
import 'package:uuid/uuid.dart';

class SendNoti extends StatefulWidget {
  const SendNoti({super.key});

  @override
  State<SendNoti> createState() => _SendNotiState();
}

class _SendNotiState extends State<SendNoti> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _des = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void createNoti(String title, String des) async {
    String notiId = Uuid().v1();

    await FirebaseFirestore.instance
        .collection('notifications')
        .doc(notiId)
        .set({
      "title": title,
      "des": des,
      "isSeen": "false",
      "time": FieldValue.serverTimestamp(),
      "id": notiId,
    });
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Notifications'),
        backgroundColor: Colors.indigoAccent,
      ),
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: LinearProgressIndicator(),
              ),
            )
          : Column(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              Container(
                width: size.width,
                alignment: Alignment.center,
                child: field(size, "Enter Title", _title, false),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Container(
                  width: size.width,
                  alignment: Alignment.center,
                  child: field(size, "Write description", _des, false),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 25,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_title.text.isNotEmpty && _des.text.isNotEmpty) {
                      setState(() {
                        isLoading = true;
                      });
                      createNoti(_title.text, _des.text);
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => Notifi()));
                    }
                  },
                  child: Text("Send Notification"))
            ]),
    );
  }

  Widget field(
      Size size, String hintText, TextEditingController cont, bool obscure) {
    return Container(
      height: size.height / 14,
      width: size.width / 1.1,
      child: TextField(
        obscureText: obscure,
        controller: cont,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
