class User {
  String user_id;
  String user_name;
  String user_lastName;
  String user_password;

  User(
    this.user_id,
    this.user_name,
    this.user_lastName,
    this.user_password,
  );

  Map<String, String> toJson() => {
        "user_id": user_id,
        "user_name": user_name,
        "user_last_name": user_lastName,
        "user_password": user_password,
      };
}
