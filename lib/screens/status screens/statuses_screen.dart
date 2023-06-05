// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/constants/constants.dart';
import 'package:whatsapp_clone/data/people.dart';
import 'package:whatsapp_clone/components/status.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:whatsapp_clone/screens/status%20screens/status_encrytion_bottomheet.dart';
import 'package:whatsapp_clone/screens/status%20screens/status_options_screen.dart';
import 'package:whatsapp_clone/screens/status%20screens/status_view.dart';
import 'dart:math' as math;

final downloadURLprovider = StateProvider<String>((ref) => kUserPpURL);

class Statuses extends StatefulWidget {
  const Statuses({Key? key}) : super(key: key);

  @override
  State<Statuses> createState() => _StatusesState();
}

class _StatusesState extends State<Statuses> {
  static var myUser =
      People(profilePic: kUserPpURL, name: 'Me', phoneNumber: 905550001234);
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      StatusBlock(isInOptions: false),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.lock),

        // Creating 'Your status updates are end-to-end encrypted' text clicable
        RichText(
          text: TextSpan(
              text: 'Your status updates are ',
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  text: 'end-to-end encrypted',
                  style: TextStyle(color: Colors.teal),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => EncrytionBottomSheet(),
                        ),
                ),
              ]),
        ),
      ])
    ]);
  }
}

class StatusBlock extends ConsumerWidget {
  StatusBlock({required this.isInOptions});
  bool isInOptions;

  void optionsClickHandle(String value) async {
    switch (value) {
      case 'Forward':
        break;
      case 'Share...':
        break;
      case 'Delete':
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadURL = ref.watch(downloadURLprovider);
    return InkWell(
      onTap: () async {
        // Check if there is no status data already
        if (Status.statusHasData == false) {
          final post =
              await ImagePicker().pickImage(source: ImageSource.camera);
          if (post == null) return;

          // Create a reference to a Firebase Storage location using the name of the picture file
          final path = 'status_files/${post.name}';
          final postTemp = File(post.path);
          final reference = FirebaseStorage.instance.ref().child(path);
          try {
            // Show a dialog with a progress indicator to indicate that the upload is in progress
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

            // Upload the picture to Firebase Storage and retrieve its download URLs
            await reference.putFile(postTemp).then((_) async {
              ref.read(downloadURLprovider.notifier).state =
                  await reference.getDownloadURL();
              Navigator.pop(context);

              // Update the statusHasData property to indicate that there is status data available
              Status.statusHasData = true;
            });
          } catch (e) {
            print(e);
            return;
          }
        } else {
          // Navigate to the StatusView widget if there is already status data available
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return StatusView(downloadURL: downloadURL);
          }));
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(downloadURL) as ImageProvider,
                  radius: 25,
                ),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  'My Status',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  kTapToStatusMessage,
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
              ]),
            ],
          ),

          // If we're not in the options menu, show the "Go To Options" icon.
          if (Status.statusHasData && isInOptions == false)
            Transform.rotate(
              angle: isInOptions ? 0 : 180 * math.pi / 180,
              child: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return StatusOptions();
                  }));
                },
                icon: Icon(Icons.more_horiz),
              ),
            ),

          // If we're in the options menu, show the options button.
          if (isInOptions)
            PopupMenuButton<String>(
                onSelected: optionsClickHandle,
                itemBuilder: (BuildContext context) {
                  return {
                    'Forward',
                    'Share...',
                    'Delete',
                  }.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                }),
        ],
      ),
    );
    ;
  }
}
