import 'package:equatable/equatable.dart';

class SensorEntity extends Equatable {
  final String id;
  final String block;
  final String lastPing;
  final int batteryLevel;
  final String status;

  const SensorEntity({
    required this.id,
    required this.block,
    required this.lastPing,
    required this.batteryLevel,
    required this.status,
  });

  factory SensorEntity.fromJson(Map<String, dynamic> json) => SensorEntity(
        id: json['sensorId'] as String,
        block: json['block'] as String,
        lastPing: json['lastPing'] as String,
        batteryLevel: (json['batteryLevel'] as num).toInt(),
        status: json['status'] as String,
      );

  @override
  List<Object?> get props => [id];
}
