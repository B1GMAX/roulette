class UserModel {
  final String name;
  final int value;

  UserModel({required this.name, required this.value});

  Map<String, dynamic> toJson() => {'name': name, "value": value};

  static UserModel fromJson(Map<String, dynamic> json) =>
      UserModel(name: json['name'], value: json['value']);

  UserModel copyWith({String? name, int? value}) {
    return UserModel(name: name ?? this.name, value: value ?? this.value);
  }
}
