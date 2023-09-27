class UserDetails {
  String username = '';
  String password = '';
  int age = 0;

  UserDetails(
      {required this.username, required this.password, required this.age});

  UserDetails.fromJson(dynamic json) {
    username = json['username'] ?? '';
    password = json['password'] ?? '';
    age = json['age'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['password'] = password;
    map['age'] = age;
    return map;
  }

  UserDetails copyWith(
          {required String username,
          required String password,
          required int age}) =>
      UserDetails(username: username, password: password, age: age);
}

//sub collection
class Address {
  String HouseName = '';
  String Street = '';

  Address({
    required this.HouseName,
    required this.Street,
  });

  Address.fromJson(dynamic json) {
    HouseName = json['HouseName'] ?? '';
    Street = json['Street'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['HouseName'] = HouseName;
    map['Street'] = Street;

    return map;
  }

  Address copyWith({
    required String HouseName,
    required String Street,
  }) =>
      Address(HouseName: HouseName, Street: Street);
}
