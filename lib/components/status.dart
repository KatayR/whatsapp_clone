import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../data/people.dart';
import '../screens/status screens/statuses_screen.dart';

class Status {
  static bool statusHasData = false;
  String? firebasePath;
  var statusFile;
  var firebaseReference;
  var downloadURL;

  Future postStatus() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);
    if (file == null) return;

    this.firebasePath = 'status_files/${file.name}';
    this.firebaseReference =
        FirebaseStorage.instance.ref().child(firebasePath!);
    File statusFile = File(file.path);
    await firebaseReference.putFile(statusFile).then((_) async {
      this.downloadURL = await firebaseReference.getDownloadURL();
      // Update the statusHasData property to indicate that there is status data available
      statusHasData = true;
    });
    print('uploaded');
  }
}

// class Status {
//   var sender;
//   var statusData;
//   static var statusHasData = false;
//   Status({this.sender, this.statusData});

//   void postStatus(sender) async {
//     final post = await ImagePicker().pickImage(source: ImageSource.camera);
//     if (post == null) return;

//     try {
//       final postTemp = File(post.path);
//       this.statusData = postTemp;
//     } catch (e) {
//       print('Error creating file from path: $e');
//     }
//   }

//   var statusUrls = [];
//   Future<List<String>> getUrls() async {
//     List<String> statusUrls = [];
//     final result =
//         await FirebaseStorage.instance.ref('/status_files').listAll();
//     for (final ref in result.items) {
//       final url = await ref.getDownloadURL();
//       print('url $url');
//       statusUrls.add(url);
//     }
//     print('status urls $statusUrls');
//     return statusUrls;
//   }

//   Future<bool> checkIfEmpty() async {
//     final result =
//         await FirebaseStorage.instance.ref('/status_files').listAll();
//     statusHasData = result.items.isNotEmpty;
//     return result.items.isNotEmpty;
//   }
// }
