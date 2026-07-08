import 'package:equatable/equatable.dart';

class ParcelaEntity extends Equatable {
  final int id;
  final String name;
  final double hectares;
  final int nodes;
  final String status;
  final String lastReading;
  final double healthPct;

  const ParcelaEntity({
    required this.id,
    required this.name,
    required this.hectares,
    required this.nodes,
    required this.status,
    required this.lastReading,
    required this.healthPct,
  });

  factory ParcelaEntity.fromJson(Map<String, dynamic> json) => ParcelaEntity(
    id: (json['id'] as num).toInt(),
    name: json['name'] as String,
    hectares: (json['hectares'] as num).toDouble(),
    nodes: (json['nodes'] as num).toInt(),
    status: json['status'] as String,
    lastReading: json['lastReading'] as String,
    healthPct: (json['healthPct'] as num).toDouble(),
  );

  @override
  List<Object?> get props => [id];
}
