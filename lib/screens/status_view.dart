import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/components/status.dart';

class StatusView extends StatefulWidget {
  StatusView({this.downloadURL});
  final downloadURL;
  @override
  State<StatusView> createState() => _StatusViewState();
}

class _StatusViewState extends State<StatusView> {
  var status = Status();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(widget.downloadURL),
      ),
    );
  }
}
