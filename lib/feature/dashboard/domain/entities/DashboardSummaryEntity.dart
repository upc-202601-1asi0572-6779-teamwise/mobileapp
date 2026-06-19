import 'package:equatable/equatable.dart';

class DashboardSummaryEntity extends Equatable {
  final String farmerName;
  final String farmName;
  final String location;
  final double humidity;
  final double temperature;
  final double phSoil;
  final bool isOnline;
  final List<PlotSummaryEntity> recentPlots;
  final List<AlertSummaryEntity> recentAlerts;

  const DashboardSummaryEntity({
    required this.farmerName,
    required this.farmName,
    required this.location,
    required this.humidity,
    required this.temperature,
    required this.phSoil,
    required this.isOnline,
    required this.recentPlots,
    required this.recentAlerts,
  });

  factory DashboardSummaryEntity.fromJson(Map<String, dynamic> json) =>
      DashboardSummaryEntity(
        farmerName: json['farmerName'] as String,
        farmName: json['farmName'] as String,
        location: json['location'] as String,
        humidity: (json['humidity'] as num).toDouble(),
        temperature: (json['temperature'] as num).toDouble(),
        phSoil: (json['phSoil'] as num).toDouble(),
        isOnline: json['isOnline'] as bool,
        recentPlots: (json['recentPlots'] as List)
            .map((e) => PlotSummaryEntity.fromJson(e as Map<String, dynamic>))
            .toList(),
        recentAlerts: (json['recentAlerts'] as List)
            .map((e) => AlertSummaryEntity.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  @override
  List<Object?> get props => [farmerName, humidity, isOnline];
}

class PlotSummaryEntity extends Equatable {
  final int id;
  final String name;
  final double hectares;
  final int nodes;
  final String status;

  const PlotSummaryEntity({
    required this.id,
    required this.name,
    required this.hectares,
    required this.nodes,
    required this.status,
  });

  factory PlotSummaryEntity.fromJson(Map<String, dynamic> json) =>
      PlotSummaryEntity(
        id: (json['id'] as num).toInt(),
        name: json['name'] as String,
        hectares: (json['hectares'] as num).toDouble(),
        nodes: (json['nodes'] as num).toInt(),
        status: json['status'] as String,
      );

  @override
  List<Object?> get props => [id];
}

class AlertSummaryEntity extends Equatable {
  final String level;
  final String title;
  final String? block;
  final String timeAgo;

  const AlertSummaryEntity({
    required this.level,
    required this.title,
    this.block,
    required this.timeAgo,
  });

  factory AlertSummaryEntity.fromJson(Map<String, dynamic> json) =>
      AlertSummaryEntity(
        level: json['level'] as String,
        title: json['title'] as String,
        block: json['block'] as String?,
        timeAgo: json['timeAgo'] as String,
      );

  @override
  List<Object?> get props => [level, title];
}
