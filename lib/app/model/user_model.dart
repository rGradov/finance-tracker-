class UserModel {
  final String pinCode;

  UserModel(this.pinCode);

  UserModel copyWith({
    String? pinCode,
  }) {
    return UserModel(pinCode ?? this.pinCode);
  }
}
