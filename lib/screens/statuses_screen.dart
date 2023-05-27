import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constants/constants.dart';
import 'package:whatsapp_clone/data/people.dart';
import 'package:whatsapp_clone/home.dart';
import 'package:whatsapp_clone/components/status.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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

class myStatusBlock extends StatelessWidget {
  const myStatusBlock({
    super.key,
    required this.myUser,
  });

  final People myUser;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final post = await ImagePicker().pickImage(source: ImageSource.camera);
        if (post == null) return;
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Stack(alignment: Alignment.bottomRight, children: [
              CircleAvatar(
                backgroundImage: AssetImage(myUser.profilePic),
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
              'My Status',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 7),
            Text(
              'Tap to add status update',
              style: TextStyle(color: Colors.black54),
            )
          ])
        ],
      ),
    );
  }
}
