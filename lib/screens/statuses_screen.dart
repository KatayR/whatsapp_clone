// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously
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
  String downloadURL =
      "https://firebasestorage.googleapis.com/v0/b/wapp-b6195.appspot.com/o/myPp.png?alt=media&token=d07f918f-fea8-4c8a-827a-2da6926f5c44";

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
          try {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Dialog(
                  child: SizedBox(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          width: 35,
                        ),
                        Text("Uploading..."),
                      ],
                    ),
                  ),
                );
              },
            );
            await ref.putFile(postTemp).then((_) async {
              downloadURL = await ref.getDownloadURL();
              Navigator.pop(context);
              setState(() {});
            });
          } catch (e) {
            print(e);
            return;
          }
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
              backgroundImage: status!.statusHasData
                  ? NetworkImage(downloadURL) as ImageProvider
                  : AssetImage(widget.myUser.profilePic),
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
