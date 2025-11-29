import 'package:equatable/equatable.dart';

class Dream extends Equatable {
  final String id;
  final String title;
  final String text;
  final String? interpretation;
  final bool isReady;
  final DateTime? createdAt;

  const Dream({
    required this.id,
    required this.title,
    required this.text,
    this.interpretation,
    required this.isReady,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    text,
    interpretation,
    isReady,
    createdAt,
  ];
}
