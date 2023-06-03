// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/screens/chats_screen.dart';
import 'package:whatsapp_clone/screens/community_screen.dart';
import 'package:whatsapp_clone/constants/constants.dart';
import 'package:whatsapp_clone/screens/statuses_screen.dart';
import 'components/status.dart';

final indexProvider = StateProvider<int>((ref) => 1);

class Home extends ConsumerWidget {
  const Home({super.key});
  void clickHandle(String value) {
    switch (value) {
      case 'New group':
        break;
      case 'New broadcast':
        break;
      case 'Linked devices':
        break;
      case 'Starred messages':
        break;
      case 'Settings':
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    double tabWidth = width / 5;
    var pIndex = ref.watch(indexProvider);
    var currentPage = pIndex == 0
        ? 'community'
        : pIndex == 1
            ? 'chats'
            : pIndex == 2
                ? 'status'
                : 'calls';
    return DefaultTabController(
        initialIndex: 1,
        length: 4,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Mhatsapp'),
                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(Icons.camera_enhance_outlined),
                    ),
                    Icon(Icons.search),
                    PopupMenuButton<String>(
                        onSelected: clickHandle,
                        itemBuilder: (BuildContext context) {
                          return {
                            'New group',
                            'New broadcast',
                            'Linked devices',
                            'Starred messages',
                            'Settings'
                          }.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        }),
                  ])
                ]),
            backgroundColor: kWhatsappGreen,
            bottom: TabBar(
              indicatorColor: Colors.white,
              onTap: (int index) {
                ref.read(indexProvider.notifier).state = index;
              },
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
              tabs: <Widget>[
                Container(
                  width: 30,
                  height: 50,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.people,
                  ),
                ),
                myTabs(tabWidth: tabWidth, label: 'Chats'),
                myTabs(tabWidth: tabWidth, label: 'Status'),
                myTabs(tabWidth: tabWidth, label: 'Calls'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Community(),
              Chats(),
              Statuses(),
              Icon(Icons.directions_car, size: 350),
            ],
          ),
          floatingActionButton: currentPage == 'community'
              ? null
              : FloatingActionButton(
                  backgroundColor: kWhatsappGreen, // Analyze Button
                  onPressed: () {
                    (currentPage == 'community')
                        ? null
                        : (currentPage == 'chats')
                            ? print('message')
                            : (currentPage == 'status')
                                ? Status(sender: 'me').postStatus('me')
                                : print('call someone');
                  },
                  elevation: 0.1,
                  child: Icon(
                    (currentPage == 'chats')
                        ? Icons.message
                        : (currentPage == 'status')
                            ? Icons.camera_enhance_outlined
                            : Icons.call,
                    color: Colors.white,
                  ),
                ),
        ));
  }
}

class myTabs extends StatelessWidget {
  const myTabs({
    super.key,
    required this.tabWidth,
    required this.label,
  });

  final double tabWidth;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: tabWidth,
        height: 50,
        alignment: Alignment.center,
        child: Text(label));
  }
}
