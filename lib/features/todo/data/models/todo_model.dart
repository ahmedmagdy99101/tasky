import '../../domain/entities/todo.dart';

class TodoModel extends Todo {
  TodoModel({
    required String id,
    required String title,
    required String description,
    required bool completed,
    required String imageUrl,
  }) : super(
    id: id,
    title: title,
    description: description,
    completed: completed,
    imageUrl: imageUrl,
  );

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      completed: json['completed'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'completed': completed,
      'imageUrl': imageUrl,
    };
  }
}
