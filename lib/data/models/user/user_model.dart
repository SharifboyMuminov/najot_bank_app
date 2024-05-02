class UserModel {
  final String userName;
  final String lastName;
  final String password;
  final String imageUrl;
  final String phoneNumber;
  final String email;
  final String userId;
  final String uuId;

  UserModel(
      {required this.imageUrl,
      required this.email,
      required this.userName,
      required this.lastName,
      required this.password,
      required this.phoneNumber,
      required this.uuId,
      required this.userId});

  UserModel copyWith({
    String? userName,
    String? lastName,
    String? password,
    String? imageUrl,
    String? phoneNumber,
    String? email,
    String? userId,
    String? uuId,
  }) =>
      UserModel(
        userName: userName ?? this.userName,
        lastName: lastName ?? this.lastName,
        password: password ?? this.password,
        imageUrl: imageUrl ?? this.imageUrl,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email,
        userId: userId ?? this.userId,
        uuId: uuId ?? this.uuId,
      );

  Map<String, dynamic> toJson() {
    return {
      'user_name': userName,
      'last_name': lastName,
      'password': password,
      'image_url': imageUrl,
      'phone_number': phoneNumber,
      'email': email,
      'user_id': userId,
      'uu_id': uuId,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      imageUrl: json['image_url'] as String? ?? "",
      email: json['email'] as String? ?? "",
      userName: json['user_name'] as String? ?? "",
      lastName: json['last_name'] as String? ?? "",
      password: json['password'] as String? ?? "",
      phoneNumber: json['phone_number'] as String? ?? "",
      userId: json['user_id'] as String? ?? "",
      uuId: 'uu_id' as String? ?? "",
    );
  }

  static UserModel initial() => UserModel(
        imageUrl: "",
        email: "",
        userName: "",
        lastName: "",
        password: "",
        phoneNumber: '',
        userId: "",
        uuId: '',
      );
}
