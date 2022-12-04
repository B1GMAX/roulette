class UserModel {
  final String name;
  final int value;
  final int winRate;

  UserModel({required this.name, required this.value, required this.winRate});

  Map<String, dynamic> toJson() =>
      {'name': name, "value": value, 'winRate': winRate};

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
      name: json['name'], value: json['value'], winRate: json['winRate']);

  UserModel copyWith({String? name, int? value, int? winRate}) {
    return UserModel(
        name: name ?? this.name,
        value: value ?? this.value,
        winRate: winRate ?? this.winRate);
  }
}
