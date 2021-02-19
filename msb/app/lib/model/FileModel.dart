class Doc {
  String id;
  Future<String> url;
  String date;
  String title;
  String dir;
  Doc({this.id, this.url, this.date, this.title, this.dir});

  Doc.fromMap(Map<String, dynamic> snapshot) {
    id = snapshot['id'];
    url = snapshot["url"];
    date = snapshot["date"];
    title = snapshot["name"];
    dir = snapshot["dir"];
  }
}
