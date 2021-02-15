class UserModel {
  String uid;
  String fullName;
  String email;
  String role;
  String photoUrl;

  UserModel({this.uid, this.fullName, this.email, this.role, this.photoUrl});
  UserModel.fromMap(Map<String, dynamic> data) {
    uid = data['uid'];
    fullName = data['fullName'];
    email = data['email'];
    role = data['role'];
    photoUrl = data['photoUrl'];
  }
}
