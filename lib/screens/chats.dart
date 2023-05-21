import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constants/constants.dart';
import 'package:whatsapp_clone/home.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(children: [
        Row(children: [
          SizedBox(width: 13),
          Icon(
            Icons.archive_outlined,
            color: kWhatsappGreen,
          ),
          SizedBox(width: 20),
          Text(
            'Archived',
            style: kTitlesStyle,
          )
        ]),
        ChatBlock(
            name: 'King of England',
            icon: kMarkReadIconGrey,
            message: 'But she doesn\'t need it anymore!'),
        ChatBlock(
            name: 'Kennedy',
            icon: kSentIconGrey,
            message: 'Why u dont text me anymore'),
        ChatBlock(
            name: 'Pele', icon: kMarkReadIconGrey, message: 'Got your crown'),
      ]),
    );
  }
}

class ChatBlock extends StatelessWidget {
  ChatBlock({
    super.key,
    required this.icon,
    required this.message,
    required this.name,
  });

  late String message;
  late Icon icon;
  late String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: kTitlesStyle,
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  icon,
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    message,
                    style: TextStyle(color: Colors.black87),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
