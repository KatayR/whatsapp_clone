import 'package:flutter/material.dart';

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
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Mhatsapp'),
                Row(
                  children: [
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
                      },
                    ),
                  ],
                )
              ],
            ),
            backgroundColor: Color(0xff128C7E),
            bottom: TabBar(
              indicatorColor: Colors.white,
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
                Container(
                    width: tabWidth,
                    height: 50,
                    alignment: Alignment.center,
                    child: Text("Chats")),
                Container(
                    width: tabWidth,
                    height: 50,
                    alignment: Alignment.center,
                    child: Text("Status")),
                Container(
                    width: tabWidth,
                    height: 50,
                    alignment: Alignment.center,
                    child: Text("Calls"))
              ],
            ),
          ),
        ));
  }
}
