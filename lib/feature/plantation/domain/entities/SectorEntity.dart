import 'package:equatable/equatable.dart';

class SectorEntity extends Equatable {
  final int id;
  final String name;
  final String iotDeviceMacAddress;
  final String status;

  const SectorEntity({
    required this.id,
    required this.name,
    required this.iotDeviceMacAddress,
    required this.status,
  });

  factory SectorEntity.fromJson(Map<String, dynamic> json) => SectorEntity(
        id: json['id'] as int,
        name: json['name'] as String,
        iotDeviceMacAddress: json['iotDeviceMacAddress'] as String,
        status: json['status'] as String,
      );

  @override
  List<Object?> get props => [id, name, iotDeviceMacAddress, status];
}

class PlantationDetailEntity extends Equatable {
  final int id;
  final String name;
  final String address;
  final double hectares;
  final String status;
  final List<SectorEntity> sectors;

  const PlantationDetailEntity({
    required this.id,
    required this.name,
    required this.address,
    required this.hectares,
    required this.status,
    required this.sectors,
  });

  factory PlantationDetailEntity.fromJson(Map<String, dynamic> json) => PlantationDetailEntity(
        id: json['id'] as int,
        name: json['name'] as String,
        address: json['address'] as String,
        hectares: (json['hectares'] as num).toDouble(),
        status: json['status'] as String,
        sectors: (json['sectors'] as List)
            .map((e) => SectorEntity.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  @override
  List<Object?> get props => [id, name, address, hectares, status, sectors];
}
