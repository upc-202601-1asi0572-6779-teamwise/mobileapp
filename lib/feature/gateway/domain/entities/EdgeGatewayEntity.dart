import 'package:equatable/equatable.dart';

class EdgeGatewayEntity extends Equatable {
  final String mac;
  final bool isConnected;
  final String status;

  const EdgeGatewayEntity({
    required this.mac,
    required this.isConnected,
    required this.status,
  });

  factory EdgeGatewayEntity.fromJson(Map<String, dynamic> json) => EdgeGatewayEntity(
        mac: json['mac'] as String,
        isConnected: json['isConnected'] as bool,
        status: json['status'] as String,
      );

  @override
  List<Object?> get props => [mac];
}
