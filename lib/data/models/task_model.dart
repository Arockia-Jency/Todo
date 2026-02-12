class TaskModel {
  final String id;
  final String task;
  final bool isDone;

  TaskModel({required this.id, required this.task, this.isDone = false});

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    id: json['id'] ?? '',
    task: json['task'] ?? '',
    isDone: json['is_done'] ?? false,
  );
}