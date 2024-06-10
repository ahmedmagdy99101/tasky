import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String imageUrl;
  final String title;
  final String description;
  final String priority;
  final String status;
  final String user;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Todo({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object> get props => [
    id,
    title,
    description,
    priority,
    imageUrl,
    status,
    createdAt,
    updatedAt
  ];
}
