import 'dart:convert';

class Appointment {
  final String id;
  final String userId;
  final String doctorId;
  final DateTime dateTime;
  final String userName;
  final String doctorName;
  String? status;
  final String time;

  Appointment({
    required this.id,
    required this.userId,
    required this.doctorId,
    required this.dateTime,
    required this.doctorName,
    required this.userName,
    this.status,
    required this.time
  });

  factory Appointment.fromMap(Map<String, dynamic> json) {
    return Appointment(
      id:json['_id']?? '',
      userId: json['userId'] ?? '',
      doctorId: json['doctorId'] ?? '',
      dateTime: DateTime.parse(json['dateTime']),
      doctorName: json['doctorName']?? '',
      userName : json['userName']?? '',
      status: json['status']?? '',
      time: json['time']??''
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'userId': userId,
      'doctorId': doctorId,
      'dateTime': dateTime.toIso8601String(),
      'doctorName' : doctorName,
      'userName': userName,
      'status': status,
      'time':time
    };
  }

  String toJson() => json.encode(toMap());

  factory Appointment.fromJson(String source) => Appointment.fromMap(json.decode(source));



}