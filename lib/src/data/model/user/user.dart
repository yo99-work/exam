import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String? email;
  final String? name;
  final String? photo;


  const User({this.id, this.email, this.name, this.photo});

  static const empty = User(id: "");

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  // User.fromJson(Map<String, dynamic> json, this.id, this.email, this.name, this.photo) {
  //   id = json['id'];
  //   email = json['email'];
  //   name = json['name'];
  //   photo = json['photo'];
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data['id'] = id;
  //   data['email'] = email;
  //   data['name'] = name;
  //   data['photo'] = photo;
  //   return data;
  // }

  @override
  List<Object?> get props => [email, id, name, photo];
}

