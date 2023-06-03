import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../data/people.dart';

class Status {
  var sender;
  var statusData;
  static var statusHasData = false;
  Status({this.sender, this.statusData});

  void postStatus(sender) async {
    final post = await ImagePicker().pickImage(source: ImageSource.camera);
    if (post == null) return;

    try {
      final postTemp = File(post.path);
      this.statusData = postTemp;
    } catch (e) {
      print('Error creating file from path: $e');
    }
  }

  var statusUrls = [];
  Future<List<String>> getUrls() async {
    List<String> statusUrls = [];
    final result =
        await FirebaseStorage.instance.ref('/status_files').listAll();
    for (final ref in result.items) {
      final url = await ref.getDownloadURL();
      print('url $url');
      statusUrls.add(url);
    }
    print('status urls $statusUrls');
    return statusUrls;
  }

  Future<bool> checkIfEmpty() async {
    final result =
        await FirebaseStorage.instance.ref('/status_files').listAll();
    statusHasData = result.items.isNotEmpty;
    return result.items.isNotEmpty;
  }
}
