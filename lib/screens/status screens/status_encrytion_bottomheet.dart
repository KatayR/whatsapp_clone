import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constants/constants.dart';

class EncrytionBottomSheet extends StatelessWidget {
  const EncrytionBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      color: Color(0xff757575),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close))
                ],
              ),
              Expanded(
                child: Image.asset('assets/encryption_message.png',
                    fit: BoxFit.cover),
              ),
              MaterialButton(
                onPressed: () {},
                elevation: 0,
                child: Text(
                  'Learn more',
                  style: TextStyle(color: Colors.white),
                ),
                color: kWhatsappGreen,
                minWidth: MediaQuery.of(context).size.width * 0.8,
                shape: ShapeBorder.lerp(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
