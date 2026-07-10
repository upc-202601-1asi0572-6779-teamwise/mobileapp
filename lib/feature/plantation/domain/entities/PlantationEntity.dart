import 'package:equatable/equatable.dart';

class PlantationEntity extends Equatable {
  final int id;
  final String name;
  final String address;
  final String? coordinates;
  final double hectares;
  final String status;
  final int estimatedSensors;
  final String installationMessage;

  const PlantationEntity({
    required this.id,
    required this.name,
    required this.address,
    required this.coordinates,
    required this.hectares,
    required this.status,
    required this.estimatedSensors,
    required this.installationMessage,
  });

  factory PlantationEntity.fromJson(Map<String, dynamic> json) => PlantationEntity(
        id: json['id'] as int,
        name: json['name'] as String,
        address: json['address'] as String,
        coordinates: json['coordinates'] as String?,
        hectares: (json['hectares'] as num).toDouble(),
        status: json['status'] as String,
        estimatedSensors: json['estimatedSensors'] as int,
        installationMessage: json['installationMessage'] as String? ?? '',
      );

  @override
  List<Object?> get props => [id, name, address, coordinates, hectares, status, estimatedSensors];
}
