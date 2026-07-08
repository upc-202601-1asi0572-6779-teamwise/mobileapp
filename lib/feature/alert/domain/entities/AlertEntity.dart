import 'package:equatable/equatable.dart';

class AlertEntity extends Equatable {
  final int id;
  final String level;
  final String title;
  final String? block;
  final String timeAgo;

  const AlertEntity({
    required this.id,
    required this.level,
    required this.title,
    this.block,
    required this.timeAgo,
  });

  factory AlertEntity.fromJson(Map<String, dynamic> json) => AlertEntity(
    id: (json['id'] as num).toInt(),
    level: json['level'] as String,
    title: json['title'] as String,
    block: json['block'] as String?,
    timeAgo: json['timeAgo'] as String,
  );

  @override
  List<Object?> get props => [id];
}
