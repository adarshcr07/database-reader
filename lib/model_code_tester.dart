class Doctor {
  Doctor({
    required this.id,
    required this.name,
    required this.profilePic,
    required this.bio,
    required this.yearOfExperience,
    required this.languageKnown,
    required this.serviceName,
    required this.serviceId,
    required this.orderId,
    this.subServiceName = "",
    this.subServiceId = "",
    this.isDirector = false,
    this.departmentId = "",
    this.nationality = "",
  });

  Doctor.fromJson(dynamic json) {
    id = json['id'] ?? '';
    departmentId = json['departmentId'] ?? '';
    name = json['name'] ?? '';
    profilePic = json['profilePic'] ?? '';
    bio = json['bio'] ?? '';
    serviceName = json['serviceName'] ?? '';
    serviceId = json['serviceId'] ?? '';
    subServiceName = json['subServiceName'] ?? '';
    subServiceId = json['subServiceId'] ?? '';
    yearOfExperience = json['yearOfExperience'] ?? '';
    languageKnown = json['languageKnown'] ?? '';
    nationality = json['nationality'] ?? '';
    isDirector = json['isDirector'] ?? '';
    orderId = json['order'] ?? 0;
  }

  String id = "";
  String departmentId = "";
  String name = "";
  String profilePic = "";
  String bio = "";
  String serviceName = "";
  String serviceId = "";
  String subServiceName = "";
  String subServiceId = "";
  String yearOfExperience = "0";
  String languageKnown = "";
  bool isDirector = false;
  String nationality = "";
  int orderId = 0;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['profilePic'] = profilePic;
    map['bio'] = bio;
    map['serviceName'] = serviceName;
    map['serviceId'] = serviceId;
    map['subServiceName'] = subServiceName;
    map['subServiceId'] = subServiceId;
    map['yearOfExperience'] = yearOfExperience;
    map['languageKnown'] = languageKnown;
    map['order'] = orderId;
    return map;
  }

  Doctor copyWith(
          {required String id,
          required String name,
          required String profilePic,
          required String bio,
          required String serviceName,
          required String serviceId,
          required String yearOfExperience,
          required String languageKnown,
          required int order,
          String subServiceName = "",
          String subServiceId = ""}) =>
      Doctor(
          id: id,
          name: name,
          profilePic: profilePic,
          bio: bio,
          serviceName: serviceName,
          serviceId: serviceId,
          subServiceName: subServiceName,
          subServiceId: subServiceId,
          yearOfExperience: yearOfExperience,
          languageKnown: languageKnown,
          orderId: orderId);
}
