import 'dart:convert';

import 'package:pfe2/models/rating.dart';



class Pharmacien {
  final String id;
  final String idMatricule;
  final String name;
  final String email;
  final String password;
  final String wilaya;
  final String daira;
  final String telephone;
  final String token;
  final int anciente;
  final List<Rating>? rating;

  Pharmacien({
    required this.id,
    required this.idMatricule,
    required this.name,
    required this.email,
    required this.password,
    required this.wilaya,
    required this.daira,
    required this.telephone,
    required this.token,
    required this.anciente,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idMatricule':idMatricule,
      'name': name,
      'email': email,
      'password': password,
      'wilaya':wilaya,
      'daira':daira,
      'telephone':telephone,
      'token': token,
      'anciente':anciente,
    };
  }

  factory Pharmacien.fromMap(Map<String, dynamic> map) {
    return Pharmacien(
      id: map['_id'] ?? '',
      idMatricule: map['idMatricule']??'',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      wilaya: map['wilaya']?? '',
      daira:map['daira']??'',
      telephone: map['telephone']?? '',
      token: map['token'] ?? '',
      anciente: map['anciente']??0,
      rating: map['ratings'] != null
          ? List<Rating>.from(
        map['ratings']?.map(
              (x) => Rating.fromMap(x),
        ),
      ) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pharmacien.fromJson(String source) => Pharmacien.fromMap(json.decode(source));

  Pharmacien copyWith({
    String? id,
    String? idMatricule,
    String? name,
    String? email,
    String? password,
    String? wilaya,
    String? daira,
    String? telephone,
    String? token,
  }) {
    return Pharmacien(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      wilaya: wilaya ?? this.wilaya,
      daira: daira ?? this.daira,
      idMatricule: idMatricule ?? this.idMatricule,
      telephone: telephone ?? this.telephone,
      token: token ?? this.token,
      anciente: anciente ?? 0,
    );
  }
}