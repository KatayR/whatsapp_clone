class People {
  String name;
  int phoneNumber;
  var profilePic;
  People(var profilePic, {required this.name, required this.phoneNumber}) {
    var user = People(null, name: 'Me', phoneNumber: 905550001234);
  }
}
