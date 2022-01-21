import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
 const UserModel(this.pinCode);
 final String pinCode;
  UserModel copyWith({
    String? pinCode,
  }) {
    return UserModel(pinCode ?? this.pinCode);
  }

  @override
  List<Object?> get props => [pinCode];
}
