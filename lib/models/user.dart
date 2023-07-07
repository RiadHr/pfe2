import 'dart:convert';
import 'dart:ffi';

import 'package:pfe2/models/notification.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String idn;
  final String wilaya;
  final String daira;
  final String telephone;
  final String token;
  final String type;
  final List<String>? isBlacklisted;
  final List<Notifications>? notifications;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.idn,
    required this.wilaya,
    required this.daira,
    required this.telephone,
    required this.token,
    required this.type,
    this.isBlacklisted,
    this.notifications
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'idn':idn,
      'wilaya':wilaya,
      'daira':daira,
      'telephone':telephone,
      'token': token,
      'type': type,
      'isBlacklisted':isBlacklisted,
      'notifications':notifications
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      idn: map['idn']??'',
      wilaya: map['wilaya']??'',
      daira:map['daira']??'',
      telephone: map['telephone']?? '',
      token: map['token'] ?? '',
      type: map['type'] ?? '',
      isBlacklisted:map['isBlacklisted'] != null
          ? List<String>.from(
        map['isBlacklisted']?.map(
              (x) => x,
        ),
      ) : null,
      notifications: map['appointment'] != null
          ? List<Notifications>.from(
        map['appointment']?.map(
              (x) => Notifications.fromMap(x),
        ),
      ) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? idn,
    String? wilaya,
    String? daira,
    String? telephone,
    String? token,
    String? type,
    List<String>? isBlacklisted,
    List<Notifications>? notifications,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      idn: idn ?? this.idn,
      wilaya: wilaya ?? this.wilaya,
      daira: daira ?? this.daira,
      telephone: telephone ?? this.telephone,
      token: token ?? this.token,
      type: type ?? this.type,
      isBlacklisted: isBlacklisted ?? this.isBlacklisted,
      notifications: notifications ?? this.notifications
    );
  }
}