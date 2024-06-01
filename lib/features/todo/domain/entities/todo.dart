import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool completed;
  final String imageUrl;

  const Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [id, title, description, completed, imageUrl];
}
