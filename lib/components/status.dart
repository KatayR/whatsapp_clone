import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../data/people.dart';

class Status {
  var sender;
  var statusData;
  bool statusHasData = false;
  Status({this.sender, this.statusData});

  void postStatus(sender) async {
    final post = await ImagePicker().pickImage(source: ImageSource.camera);
    if (post == null) return;

    final postTemp = File(post.path);
    this.statusData = postTemp;
  }

  var statusUrls = [];
  Future<List<String>> getUrls() async {
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

  Future<bool> checkIfEmpty() async {
    final result =
        await FirebaseStorage.instance.ref('/status_files').listAll();
    statusHasData = result.items.isNotEmpty;
    return result.items.isNotEmpty;
  }
}
