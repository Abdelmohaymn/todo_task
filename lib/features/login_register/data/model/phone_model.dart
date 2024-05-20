class PhoneModel {
  PhoneModel({
    required this.name,
    required this.dialCode,
    required this.code,
    required this.flag,
  });

  PhoneModel.fromJson(dynamic json) {
    name = json['name'];
    dialCode = json['dial_code'];
    code = json['code'];
    flag = json['flag'];
  }
  late String name;
  late String dialCode;
  late String code;
  late String flag;


}