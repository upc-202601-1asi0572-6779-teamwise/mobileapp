import 'package:equatable/equatable.dart';

class SensorReadingEntity extends Equatable {
  final String iotDeviceMacAddress;
  final String sensorType;
  final double value;
  final String unit;
  final DateTime measuredAt;

  const SensorReadingEntity({
    required this.iotDeviceMacAddress,
    required this.sensorType,
    required this.value,
    required this.unit,
    required this.measuredAt,
  });

  factory SensorReadingEntity.fromJson(Map<String, dynamic> json) => SensorReadingEntity(
        iotDeviceMacAddress: json['iotDeviceMacAddress'] as String,
        sensorType: json['sensorType'] as String,
        value: (json['value'] as num).toDouble(),
        unit: json['unit'] as String,
        measuredAt: DateTime.parse(json['measuredAt'] as String),
      );

  @override
  List<Object?> get props => [iotDeviceMacAddress, sensorType, measuredAt];
}
