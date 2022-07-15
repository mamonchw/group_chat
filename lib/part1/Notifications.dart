import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:group_chat/part1/description.dart';
import 'package:group_chat/part1/sendNoti.dart';
import 'package:uuid/uuid.dart';

class Notifi extends StatefulWidget {
  const Notifi({super.key});

  @override
  State<Notifi> createState() => _NotifiState();
}

class _NotifiState extends State<Notifi> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void createNoti() async {
    String notiId = Uuid().v1();

    await FirebaseFirestore.instance
        .collection('notifications')
        .doc(notiId)
        .set({
      "title": "Notification",
      "des": "this is des",
      "isSeen": "false",
      "time": FieldValue.serverTimestamp(),
      "id": notiId,
    });
  }

  void setStatus(bool status, String uid) async {
    await FirebaseFirestore.instance
        .collection('notifications')
        .doc(uid)
        .update({
      "isSeen": status,
    });
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _notifications = FirebaseFirestore.instance
        .collection('notifications')
        .orderBy('time', descending: true)
        .snapshots();
    return Scaffold(
        appBar: AppBar(
          title: Text('Task Part 1'),
          backgroundColor: Colors.green[200],
        ),
        body: Container(
          alignment: Alignment.center,
          child: StreamBuilder<QuerySnapshot>(
            stream: _notifications,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.blueAccent,
                ));
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      //String uid=data['id'];
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => NotiDes(
                              title: data['title'],
                              des: data['des'],
                            ),
                          ),
                        );
                        print(data['id']);

                        setStatus(true, data['id']);

                        //   ),
                        // );
                      },
                      leading: Icon(Icons.reddit_outlined,
                          color: (data['isSeen'] == "false")
                              ? Color.fromARGB(255, 66, 243, 80)
                              : Colors.blueGrey),
                      title: Text(
                        data['title'],
                        style: TextStyle(
                          color: (data['isSeen'] == "false")
                              ? Color.fromARGB(255, 66, 243, 80)
                              : Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(data['des']),
                      trailing: Icon(Icons.chat, color: Colors.black),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          label: const Text('Send Notification'),
          backgroundColor: Colors.indigoAccent,
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => SendNoti(),
            ),
          ),
        ));
  }
}
