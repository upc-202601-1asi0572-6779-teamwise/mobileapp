import 'package:equatable/equatable.dart';

String _normalizeLevel(String backendLevel) {
  final lower = backendLevel.toLowerCase();
  if (lower.startsWith('crit')) return 'crit';
  if (lower.startsWith('warn')) return 'warn';
  return 'info';
}

String _timeAgo(DateTime timestamp) {
  final diff = DateTime.now().toUtc().difference(timestamp.toUtc());
  if (diff.inMinutes < 1) return 'justo ahora';
  if (diff.inMinutes < 60) return 'hace ${diff.inMinutes} min';
  if (diff.inHours < 24) return 'hace ${diff.inHours} h';
  return 'hace ${diff.inDays} d';
}

class AlertEntity extends Equatable {
  final String id;
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

  factory AlertEntity.fromJson(Map<String, dynamic> json) {
    final timestamp = DateTime.parse(json['timestamp'] as String);
    return AlertEntity(
      id: json['id'] as String,
      level: _normalizeLevel(json['level'] as String),
      title: json['message'] as String,
      block: json['sensorType'] as String?,
      timeAgo: _timeAgo(timestamp),
    );
  }

  @override
  List<Object?> get props => [id];
}
