import 'package:equatable/equatable.dart';

class ParcelaDetailEntity extends Equatable {
  final int id;
  final String name;
  final double hectares;
  final int nodes;
  final String location;
  final String status;
  final double humidity;
  final double temperature;
  final double phSoil;
  final double solarLux;
  final List<double> humidityHistory;
  final String lastSync;

  const ParcelaDetailEntity({
    required this.id,
    required this.name,
    required this.hectares,
    required this.nodes,
    required this.location,
    required this.status,
    required this.humidity,
    required this.temperature,
    required this.phSoil,
    required this.solarLux,
    required this.humidityHistory,
    required this.lastSync,
  });

  factory ParcelaDetailEntity.fromJson(Map<String, dynamic> json) =>
      ParcelaDetailEntity(
        id: (json['id'] as num).toInt(),
        name: json['name'] as String,
        hectares: (json['hectares'] as num).toDouble(),
        nodes: (json['nodes'] as num).toInt(),
        location: json['location'] as String,
        status: json['status'] as String,
        humidity: (json['humidity'] as num).toDouble(),
        temperature: (json['temperature'] as num).toDouble(),
        phSoil: (json['phSoil'] as num).toDouble(),
        solarLux: (json['solarLux'] as num).toDouble(),
        humidityHistory: (json['humidityHistory'] as List)
            .map((e) => (e as num).toDouble())
            .toList(),
        lastSync: json['lastSync'] as String,
      );

  @override
  List<Object?> get props => [id];
}
