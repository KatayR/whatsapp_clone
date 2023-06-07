import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../data/people.dart';
import '../screens/status screens/statuses_screen.dart';

class Status {
  static bool statusHasData = false;
  String? firebasePath;
  var statusFile;
  static var firebaseReference;
  static var downloadURL;

  Future createAndPostStatus() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);
    if (file == null) return;

    firebasePath = 'status_files/${file.name}';
    firebaseReference = FirebaseStorage.instance.ref().child(firebasePath!);
    File statusFile = File(file.path);

    await firebaseReference.putFile(statusFile).then((_) async {
      downloadURL = await firebaseReference.getDownloadURL();
      // Update the statusHasData property to indicate that there is status data available
      statusHasData = true;
    });
    print('uploaded');
  }

  Future deleteStatus() async {
    await firebaseReference.delete();
    statusHasData = false;
  }
}
