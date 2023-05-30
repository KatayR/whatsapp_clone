import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StatusView extends StatefulWidget {
  @override
  State<StatusView> createState() => _StatusViewState();
}

class _StatusViewState extends State<StatusView> {
  var statusUrls = [];
  Future<List<String>> getStatus() async {
    List<String> statusUrls = [];
    await FirebaseStorage.instance
        .ref('/status_files')
        .listAll()
        .then((result) {
      return Future.forEach(result.items, (ref) {
        return ref.getDownloadURL().then((url) {
          print('url $url');
          statusUrls.add(url);
        });
      });
    });
    print('status urls $statusUrls');
    return statusUrls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getStatus(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<String> statusUrls = snapshot.data as List<String>;
              return Image.network(statusUrls[0]);
            }
          },
        ),
      ),
    );
  }
}
