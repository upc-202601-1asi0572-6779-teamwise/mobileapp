import 'package:equatable/equatable.dart';

enum ReportType { weekly, monthly, byBlock }

class ReportEntity extends Equatable {
  final int id;
  final String name;
  final String type;
  final String subtitle;
  final String createdAgo;

  const ReportEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.subtitle,
    required this.createdAgo,
  });

  factory ReportEntity.fromJson(Map<String, dynamic> json) => ReportEntity(
    id: (json['id'] as num).toInt(),
    name: json['name'] as String,
    type: json['type'] as String,
    subtitle: json['subtitle'] as String,
    createdAgo: json['createdAgo'] as String,
  );

  @override
  List<Object?> get props => [id];
}
