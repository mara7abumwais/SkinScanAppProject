class User {
  String fname;
  String lname;
  String city;
  String email;
  int age;
  String id;
  User({
    required this.fname,
    required this.lname,
    required this.city,
    required this.age,
    required this.email,
    required this.id,
  });
}

class UserSingleton {
  static final UserSingleton _instance = UserSingleton._internal();

  factory UserSingleton() {
    return _instance;
  }

  UserSingleton._internal();

  late User user;

// Add other user-related properties or methods as needed
}