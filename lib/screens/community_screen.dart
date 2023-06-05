import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constants/constants.dart';

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
            child: Image.asset('assets/community/communities.png'),
          ),
          SizedBox(height: 10),
          const Center(
            child: Text(
              'Introducing communities',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Easily organize your related groups and send announcements. Now, your communities, like neighborhoods or schools, can have their own space.',
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.black45, fontSize: 19, height: 1.35),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: MaterialButton(
                color: kWhatsappGreenDark,
                elevation: 0,
                height: 38,
                shape: RoundedRectangleBorder(
                  // Change your radius here
                  borderRadius: BorderRadius.circular(16),
                ),
                onPressed: () {
                  print('pressed community button');
                },
                child: const Text(
                  'Start your community',
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
