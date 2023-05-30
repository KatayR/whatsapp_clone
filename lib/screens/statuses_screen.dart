// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constants/constants.dart';
import 'package:whatsapp_clone/data/people.dart';
import 'package:whatsapp_clone/home.dart';
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
      profilePic: 'assets/profilePicture/myPp.png',
      name: 'Me',
      phoneNumber: 905550001234);
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      myStatusBlock(myUser: myUser),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.lock),
        Text('Your status updates are end-to-end encrypted')
      ])
    ]);
  }
}

class myStatusBlock extends StatefulWidget {
  myStatusBlock({
    super.key,
    required this.myUser,
  });
  final People myUser;

  @override
  State<myStatusBlock> createState() => _myStatusBlockState();
}

class _myStatusBlockState extends State<myStatusBlock> {
  @override
  void initState() {
    super.initState();
    checkStatusData();
  }

  Future<bool> checkStatusData() async {
    final result =
        await FirebaseStorage.instance.ref('/status_files').listAll();
    statusHasData = result.items.isNotEmpty;
    setState(() {});
    return result.items.isNotEmpty;
  }

  var statusHasData = false;

  Future<ListResult>? futureFiles;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (!statusHasData) {
          final post =
              await ImagePicker().pickImage(source: ImageSource.camera);
          if (post == null) return;
          final path = 'status_files/${post.name}';
          final postTemp = File(post.path);
          final ref = FirebaseStorage.instance.ref().child(path);
          await ref.putFile(postTemp);
          futureFiles = FirebaseStorage.instance.ref('/status_files').listAll();
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
            child: Stack(alignment: Alignment.bottomRight, children: [
              CircleAvatar(
                backgroundImage: AssetImage(widget.myUser.profilePic),
                radius: 20,
              ),
              CircleAvatar(
                radius: 10,
                backgroundImage: AssetImage('assets/icons/add.png'),
              )
            ]),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              !statusHasData ? 'My Status' : "data",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 7),
            Text(
              'Tap to add status update',
              style: TextStyle(color: Colors.black54),
            ),
          ])
        ],
      ),
    );
  }
}
