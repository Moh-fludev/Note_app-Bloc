import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Task extends Equatable {
  final String title;
  final String description;
  bool isDone = false;
  bool isFavorite = false;
  bool isDeleted = false;

  Task({
    required this.title,
    required this.description,
    required this.isDone,
    required this.isFavorite,
    required this.isDeleted,
  }) {
    isDone = isDone;
    isFavorite = isFavorite;
    isDeleted = isDeleted;
  }

  factory Task.fromjson(Map<String, dynamic> json) {
    return Task(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      isDone: json['isDone'] ?? '',
      isFavorite: json['isFavorite'] ?? '',
      isDeleted: json['isDeleted'] ?? '',
    );
  }

  Task copyWith({
    String? titleCopied,
    String? descriptionCopied,
    bool? isdoneCopied,
    bool? isFavoriteCopied,
    bool? isDeletedCopied,
  }) {
    return Task(
      title: titleCopied ?? title,
      description: descriptionCopied ?? description,
      isDone: isdoneCopied ?? isDone,
      isFavorite: isFavoriteCopied ?? isFavorite,
      isDeleted: isDeletedCopied ?? isDeleted,
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'title': title,
      'description': description,
      'isDone': isDone,
      'isDeleted': isDeleted,
      'isFavorite': isFavorite
    };
  }

  @override
  List<Object?> get props =>
      [title, description, isDone, isDeleted, isFavorite];
}
