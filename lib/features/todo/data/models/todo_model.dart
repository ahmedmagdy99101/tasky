import '../../domain/entities/todo.dart';

class TodoModel extends Todo {
  const TodoModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.priority,
    required super.status,
    required super.user,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['_id'],
      title: json['title'],
      description: json['desc'],
      imageUrl: json['image'],
      priority: json['priority'],
      status: json['status'],
      user: json['user'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    //  v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'image': imageUrl,
      'title': title,
      'desc': description,
      'priority': priority,
      'status': status,
      'user': user,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
