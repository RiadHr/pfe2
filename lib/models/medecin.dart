import 'dart:convert';

import 'package:pfe2/models/rating.dart';

import 'appointment.dart';
import 'notification.dart';


class Medecin {
  final String id;
  final String? idMatricule;
  final String name;
  final String email;
  final String password;
  final String specialite;
  final String wilaya;
  final String daira;
  final String telephone;
  final String token;
  final int anciente;
  final List<Rating>? rating;
  final List<Appointment>? appointment;
  final List<String>? blackListedUsers;
  final bool? isBlocked;
  final List<Notifications>? notifications;

  Medecin({
    required this.id,
    required this.idMatricule,
    required this.name,
    required this.email,
    required this.password,
    required this.specialite,
    required this.wilaya,
    required this.daira,
    required this.telephone,
    required this.token,
    required this.anciente,
    this.rating,
    this.appointment,
    this.blackListedUsers,
    this.isBlocked,
    this.notifications
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idMatricule':idMatricule,
      'name': name,
      'email': email,
      'password': password,
      'specialite':specialite,
      'wilaya':wilaya,
      'daira':daira,
      'telephone':telephone,
      'token': token,
      'rating': rating,
      'appointment':appointment,
      'anciente':anciente,
      'blackListedUsers':blackListedUsers,
      'isBlocked':isBlocked,
      'notifications':notifications
    };
  }

  factory Medecin.fromMap(Map<String, dynamic> map) {
    return Medecin(
      id: map['_id'] ?? '',
      idMatricule: map['idMatricule'],
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      specialite: map['specialite']??'',
      wilaya: map['wilaya']??'',
      daira: map['daira']??'',
      telephone: map['telephone']?? '',
      token: map['token'] ?? '',
      anciente:map['anciente']?? 0,
      isBlocked: map['isBlocked']?? false,
      blackListedUsers:map['blackListedUsers'] ?? null,
      rating: map['ratings'] != null
          ? List<Rating>.from(
        map['ratings']?.map(
              (x) => Rating.fromMap(x),
        ),
      ) : null,
      appointment: map['appointment'] != null
          ? List<Appointment>.from(
        map['appointment']?.map(
              (x) => Appointment.fromMap(x),
        ),
      ) : null,
      notifications: map['notifications'] != null
          ? List<Notifications>.from(
        map['notifications']?.map(
              (x) => Notifications.fromMap(x),
        ),
      ) : null,

    );
  }

  String toJson() => json.encode(toMap());

  factory Medecin.fromJson(String source) => Medecin.fromMap(json.decode(source));

  Medecin copyWith({
    String? id,
    String? idMatricule,
    String? name,
    String? email,
    String? password,
    String? specialite,
    String? wilaya,
    String? daira,
    String? telephone,
    String? token,
    int? anciente,
    final List<Rating>? rating,
    final List<Appointment>? appointment,
    bool? isBlocked,
    List<Notifications>? notifications


  }) {
    return Medecin(
      id: id ?? this.id,
      idMatricule: idMatricule ?? this.idMatricule,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      specialite: specialite ?? this.specialite,
      wilaya: wilaya ?? this.wilaya,
      daira: daira ?? this.daira,
      telephone: telephone ?? this.telephone,
      token: token ?? this.token,
      anciente: anciente ?? this.anciente,
      rating: rating ?? this.rating,
      appointment: appointment ?? this.appointment,
      isBlocked: isBlocked ?? this.isBlocked,
      notifications: notifications ?? this.notifications
    );
  }
}