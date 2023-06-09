// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/Cubit/TapToAddCubit.dart';
import 'package:whatsapp_clone/constants/constants.dart';
import 'package:whatsapp_clone/data/people.dart';
import 'package:whatsapp_clone/components/status.dart';
import 'package:whatsapp_clone/screens/status%20screens/status_encrytion_bottomheet.dart';
import 'package:whatsapp_clone/screens/status%20screens/status_options_screen.dart';
import 'package:whatsapp_clone/screens/status%20screens/status_view.dart';
import 'dart:math' as math;
import 'package:share_plus/share_plus.dart';

import '../../Cubit/DownloadUrlCubit.dart';

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

class StatusBlock extends StatelessWidget {
  StatusBlock({required this.isInOptions});
  bool isInOptions;

  @override
  Widget build(BuildContext context) {
    final downloadURL = context.watch<DownloadUrlCubit>().state;
    return InkWell(
      onTap: () async {
        Status status = Status();
        // Check if there is no status data already
        if (Status.statusHasData == false) {
          // Get the image from the gallery and post it to the database
          try {
            Future.delayed(const Duration(milliseconds: 1000), () {
              context.read<TapToCubit>().update('\u23F2 sending');
            });
            await status.createAndPostStatus();
          } catch (e) {
            print('Error in postStatus: $e');
            return;
          }
          // Update the downloadURL state to the downloadURL of the image
          context.read<DownloadUrlCubit>().update(Status.downloadURL);
          context.read<TapToCubit>().update('Just now');
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
                  context.watch<TapToCubit>().state,
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
            PopupMenuButton<String>(onSelected: (String value) async {
              switch (value) {
                case 'Forward':
                  break;
                case 'Share...':
                  Share.shareFiles([Status.statusFile.path]);
                  break;
                case 'Delete':
                  // Delete the status from the database
                  Status status = Status();
                  await status.deleteStatus();
                  context.read<DownloadUrlCubit>().update(kUserPpURL);
                  context.read<TapToCubit>().update('Tap to add status');
                  Navigator.pop(context);
                  break;
              }
            }, itemBuilder: (BuildContext context) {
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
