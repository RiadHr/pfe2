import 'dart:convert';

class Notifications {
  final String id;
  final String userId;
  final String doctorId;
  final DateTime dateTime;
  final String userName;
  final String doctorName;
  final String time;

  Notifications({
    required this.id,
    required this.userId,
    required this.doctorId,
    required this.dateTime,
    required this.doctorName,
    required this.userName,
    required this.time
  });

  factory Notifications.fromMap(Map<String, dynamic> json) {
    return Notifications(
        id:json['_id']?? '',
        userId: json['userId'] ?? '',
        doctorId: json['doctorId'] ?? '',
        dateTime: DateTime.parse(json['dateTime']),
        doctorName: json['doctorName']?? '',
        userName : json['userName']?? '',
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
      'time':time
    };
  }

  String toJson() => json.encode(toMap());

  factory Notifications.fromJson(String source) => Notifications.fromMap(json.decode(source));



}