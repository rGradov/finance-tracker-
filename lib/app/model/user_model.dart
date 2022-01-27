import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
 const UserModel(this.pinCode,this.password,this.email);
 final String pinCode;
 final String email;
 final String password;
  UserModel copyWith({
    String? pinCode,
    String? password,
    String? email,

  }) {
    return UserModel(pinCode ?? this.pinCode,password??this.password,email?? this.email);
  }

  @override
  List<Object?> get props => [pinCode,password,email];
}
