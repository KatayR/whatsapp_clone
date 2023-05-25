import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Status {
  var sender;
  var statusData;
  Status({this.sender});

  void postStatus(sender) async {
    final post = await ImagePicker().pickImage(source: ImageSource.camera);
    if (post == null) return;

    final postTemp = File(post.path);
    this.statusData = postTemp;
  }
}
