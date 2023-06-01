// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constants/constants.dart';
import 'package:whatsapp_clone/data/people.dart';

import 'package:whatsapp_clone/components/status.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:whatsapp_clone/screens/status_view.dart';

class Statuses extends StatefulWidget {
  const Statuses({Key? key}) : super(key: key);

  @override
  State<Statuses> createState() => _StatusesState();
}

class _StatusesState extends State<Statuses> {
  static var myUser = People(
      profilePic: kMyProfilePictureLocation,
      name: 'Me',
      phoneNumber: 905550001234);
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      MyStatusBlock(myUser: myUser),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.lock),
        Text('Your status updates are end-to-end encrypted')
      ])
    ]);
  }
}

class MyStatusBlock extends StatefulWidget {
  MyStatusBlock({
    super.key,
    required this.myUser,
  });
  final People myUser;

  @override
  State<MyStatusBlock> createState() => _MyStatusBlockState();
}

class _MyStatusBlockState extends State<MyStatusBlock> {
  @override
  void initState() {
    super.initState();
    status = Status();
    status!.checkIfEmpty();
    setState(() {});
  }

  Status? status;

  var statusHasData = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (!status!.statusHasData) {
          final post =
              await ImagePicker().pickImage(source: ImageSource.camera);
          if (post == null) return;
          final path = 'status_files/${post.name}';
          final postTemp = File(post.path);
          final ref = FirebaseStorage.instance.ref().child(path);
          await ref.putFile(postTemp);
          statusHasData = true;
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return StatusView();
          }));
        }
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(widget.myUser.profilePic),
              radius: 20,
            ),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              !status!.statusHasData ? 'My Status' : "data",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 7),
            Text(
              kTapToStatusMessage,
              style: TextStyle(color: Colors.black54),
            ),
          ])
        ],
      ),
    );
  }
}
