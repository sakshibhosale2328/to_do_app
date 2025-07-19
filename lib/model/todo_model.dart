class Todo {
  final int id;
  final String title;
  final String description;
  final bool isDone;

  const Todo({
    required this.id,
    required this.title,
    required this.description,
    this.isDone = false,
  });

  Todo copyWith({
    int? id,
    String? title,
    String? description,
    bool? isDone,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }
}
