class User {
  User(
    this.username,
    this.email,
    this.password,
    this.creationDate,
    this.id,
    this.Status,
  );
  late final String? username;
  late final String? email;
  late final String? password;
  late final String? creationDate;
  late final String? id;
  late final String? Status;


  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    password = json['password'];
    creationDate = creationDate;
    id = json["id"];
    Status = json["isdriver"];
  }
}
