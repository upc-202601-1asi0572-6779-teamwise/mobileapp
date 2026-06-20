import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String name;
  final String initials;
  final String farm;
  final String location;
  final String plan;
  final double totalHectares;
  final int totalSensors;
  final int totalParcelas;

  const ProfileEntity({
    required this.name,
    required this.initials,
    required this.farm,
    required this.location,
    required this.plan,
    required this.totalHectares,
    required this.totalSensors,
    required this.totalParcelas,
  });

  factory ProfileEntity.fromJson(Map<String, dynamic> json) => ProfileEntity(
        name: json['name'] as String,
        initials: json['initials'] as String,
        farm: json['farm'] as String,
        location: json['location'] as String,
        plan: json['plan'] as String,
        totalHectares: (json['totalHectares'] as num).toDouble(),
        totalSensors: (json['totalSensors'] as num).toInt(),
        totalParcelas: (json['totalParcelas'] as num).toInt(),
      );

  @override
  List<Object?> get props => [name];
}
