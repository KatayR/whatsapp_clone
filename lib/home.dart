import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/provider.dart';
import 'package:whatsapp_clone/screens/chats.dart';
import 'package:whatsapp_clone/screens/community.dart';
import 'package:whatsapp_clone/constants/constants.dart';
import 'package:whatsapp_clone/screens/statuses.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double tabWidth = width / 5;
    var pIndex = Provider.of<PageIndexProvider>(context).pIndex;
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
                Provider.of<PageIndexProvider>(context, listen: false)
                    .indexUpdater(index);
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
          floatingActionButton: pIndex == 0
              ? null
              : FloatingActionButton(
                  backgroundColor: kWhatsappGreen,
                  child: Icon(
                    (pIndex == 1)
                        ? Icons.message
                        : (pIndex == 2)
                            ? Icons.camera_enhance_outlined
                            : Icons.call,
                    color: Colors.white,
                  ), // Analyze Button
                  elevation: 0.1,
                  onPressed: () {}),
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
