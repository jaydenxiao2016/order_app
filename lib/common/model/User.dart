///用户bean
class User {
  String userName;

  String password;

  String sex;

  User(
    this.userName,
    this.password,
    this.sex,
  );

  User.empty();
}
