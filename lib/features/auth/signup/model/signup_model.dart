class SignupModel {
  final String phone;
  final String password;
  final String displayName;
  final int experienceYears;
  final String address;
  final String level;

  SignupModel({
    required this.phone,
    required this.password,
    required this.displayName,
    required this.experienceYears,
    required this.address,
    required this.level,
  });

  SignupModel copyWith({
    String? phone,
    String? password,
    String? displayName,
    int? experienceYears,
    String? address,
    String? level,
  }) {
    return SignupModel(
      phone: phone ?? this.phone,
      password: password ?? this.password,
      displayName: displayName ?? this.displayName,
      experienceYears: experienceYears ?? this.experienceYears,
      address: address ?? this.address,
      level: level ?? this.level,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phone': phone,
      'password': password,
      'displayName': displayName,
      'experienceYears': experienceYears,
      'address': address,
      'level': level,
    };
  }
}
