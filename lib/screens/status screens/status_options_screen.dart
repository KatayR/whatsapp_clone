import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constants/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/screens/status%20screens/statuses_screen.dart';

class StatusOptions extends ConsumerWidget {
  const StatusOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadURL = ref.watch(downloadURLprovider);
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
