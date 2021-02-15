class Client {
  String id;
  String name;

  Client.fromMap(Map<String, dynamic> data) {
    id = data['client_id'];
    name = data['client_name'];
  }
}
