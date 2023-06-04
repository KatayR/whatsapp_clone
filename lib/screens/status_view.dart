import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/components/status.dart';
import 'package:whatsapp_clone/constants/constants.dart';

class StatusView extends StatefulWidget {
  StatusView({this.downloadURL});
  final downloadURL;
  @override
  State<StatusView> createState() => _StatusViewState();
}

class _StatusViewState extends State<StatusView> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    _controller.forward();
    Timer(Duration(seconds: 5), () {
      Navigator.pop(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  var status = Status();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Center(
          child: Image.network(widget.downloadURL),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 35.0, left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  LinearProgressIndicator(
                    color: Colors.white,
                    backgroundColor: Colors.grey[400],
                    value: _controller.value,
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, size: 35),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Container(
                        width: 55.0,
                        height: 55.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(kUserPpURL),
                            fit: BoxFit.cover,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50.0)),
                          border: Border.all(
                            color: Colors.white,
                            width: 3.0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            '   My status',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          Text('Just now',
                              style: TextStyle(color: Colors.white))
                        ],
                      )
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child:
                    Icon(Icons.remove_red_eye, color: Colors.white, size: 25),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
