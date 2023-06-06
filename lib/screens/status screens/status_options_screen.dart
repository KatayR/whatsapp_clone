import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/constants/constants.dart';
import 'package:whatsapp_clone/screens/status%20screens/statuses_screen.dart';

import '../../Cubit/DownloadUrlCubit.dart';

class StatusOptions extends StatelessWidget {
  const StatusOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final downloadURL = context.watch<DownloadUrlCubit>().state;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhatsappGreen,
        leading: BackButton(),
        title: Text('My Status'),
      ),
      body: Column(children: [StatusBlock(isInOptions: true)]),
    );
  }
}
