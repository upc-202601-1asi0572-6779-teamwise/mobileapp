import 'package:equatable/equatable.dart';

class IotDeviceEntity extends Equatable {
  final String deviceMac;

  const IotDeviceEntity({required this.deviceMac});

  factory IotDeviceEntity.fromJson(Map<String, dynamic> json) => IotDeviceEntity(
        deviceMac: json['deviceMac'] as String,
      );

  @override
  List<Object?> get props => [deviceMac];
}
