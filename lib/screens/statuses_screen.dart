// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/constants/constants.dart';
import 'package:whatsapp_clone/data/people.dart';
import 'package:whatsapp_clone/components/status.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:whatsapp_clone/screens/status_view.dart';

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
      StatusBlock(),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.lock),
        Text('Your status updates are end-to-end encrypted')
      ])
    ]);
  }
}

class StatusBlock extends ConsumerWidget {
  const StatusBlock({super.key});

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
          final referance = FirebaseStorage.instance.ref().child(path);
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
            await referance.putFile(postTemp).then((_) async {
              ref.read(downloadURLprovider.notifier).state =
                  await referance.getDownloadURL();
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
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(downloadURL) as ImageProvider,
              radius: 20,
            ),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'My Status',
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
    ;
  }
}
