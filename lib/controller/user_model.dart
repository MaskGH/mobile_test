import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.approvalCode,
    this.bloodType,
    this.companyId,
    this.dateOfBirth,
    this.department,
    this.email,
    this.gender,
    this.name,
    this.password,
    this.phoneCountryId,
    this.phoneNumber,
  });

  String? approvalCode;
  String? bloodType;
  String? companyId;
  DateTime? dateOfBirth;
  String? department;
  String? email;
  String? gender;
  String? name;
  String? password;
  String? phoneCountryId;
  String? phoneNumber;

  factory User.fromJson(Map<String, dynamic> json) => User(
        approvalCode: json["approvalCode"],
        bloodType: json["bloodType"],
        companyId: json["companyId"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        department: json["department"],
        email: json["email"],
        gender: json["gender"],
        name: json["name"],
        password: json["password"],
        phoneCountryId: json["phoneCountryId"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "approvalCode": approvalCode,
        "bloodType": bloodType,
        "companyId": companyId,
        "dateOfBirth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "department": department,
        "email": email,
        "gender": gender,
        "name": name,
        "password": password,
        "phoneCountryId": phoneCountryId,
        "phoneNumber": phoneNumber,
      };
}

List<Company> companyFromJson(String str) =>
    List<Company>.from(json.decode(str).map((x) => Company.fromJson(x)));

String companyToJson(List<Company> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Company {
  Company({
    this.publicId,
    this.name,
    this.address1,
    this.address2,
    this.city,
    this.province,
    this.postcode,
    this.addressCountry,
    this.phoneCountry,
    this.areaCode,
    this.number,
    this.ext,
  });

  String? publicId;
  String? name;
  String? address1;
  String? address2;
  String? city;
  String? province;
  String? postcode;
  String? addressCountry;
  String? phoneCountry;
  String? areaCode;
  String? number;
  dynamic? ext;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        publicId: json["publicId"],
        name: json["name"],
        address1: json["address1"],
        address2: json["address2"],
        city: json["city"],
        province: json["province"],
        postcode: json["postcode"],
        addressCountry: json["addressCountry"],
        phoneCountry: json["phoneCountry"],
        areaCode: json["areaCode"],
        number: json["number"],
        ext: json["ext"],
      );

  Map<String, dynamic> toJson() => {
        "publicId": publicId,
        "name": name,
        "address1": address1,
        "address2": address2,
        "city": city,
        "province": province,
        "postcode": postcode,
        "addressCountry": addressCountry,
        "phoneCountry": phoneCountry,
        "areaCode": areaCode,
        "number": number,
        "ext": ext,
      };
}
