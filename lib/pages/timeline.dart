import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reteteblanao/pages/search.dart';
import '../widgets/header.dart';
import '../widgets/progress.dart';

final usersRef = Firestore.instance.collection('users');

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<dynamic> users = [];
  @override
  void initState() {
    getUsers();
    //createUser();
    // getUserById();
    //updateUser();
    deleteUser();
    super.initState();
  }

  createUser() {
    usersRef
        .document('dsadsadsa')
        .setData({"username": "ana", "postsCount": 0, "isAdmin": false});
  }

  updateUser() async {
    final doc = await usersRef.document('dsadsadsa').get();

    if (doc.exists) {
      doc.reference.updateData(
          {"username": "anisoara", "postsCount": 15, "isAdmin": false});
    }
  }

  deleteUser() async {
    try {
      final doc = await usersRef.document('dsadsadsa').get();
      if (doc.exists) {
        doc.reference.delete();
      }
    } catch (err) {
      print(err);
    }
  }

  Future getUsers() async {
    final QuerySnapshot snapshot = await usersRef
        .where("postsCount", isLessThanOrEqualTo: 10)
        .orderBy('postsCount', descending: true)
        .getDocuments();
    setState(() {
      users = snapshot.documents;
    });
    // snapshot.documents.forEach((DocumentSnapshot doc) {
    //   print(doc.data);
    // });
  }

  Future getUserById() async {
    final String id = '34QDg0Itf6xBaepSQmPX';
    final DocumentSnapshot user = await usersRef.document(id).get();
    print(user.data);
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          }
          final List<Text> children = snapshot.data.documents
              .map((doc) => Text(doc['username']))
              .toList();
          return Container(
            child: ListView(
              children: children,
            ),
          );
        },
      ),
    );
  }
}
