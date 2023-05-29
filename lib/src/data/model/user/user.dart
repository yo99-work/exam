import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String? email;
  final String? name;
  final String? photo;

  const User({this.id, this.email, this.name, this.photo});

  static const User empty = User(id: "");

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  factory User.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final email = json['email'];
    final name = json['name'];
    final photo = json['photo'];
    return User(id: id, email: email, name: name, photo: photo);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['photo'] = this.photo;
    return data;
  }

  @override
  List<Object?> get props => [email, id, name, photo];
}

