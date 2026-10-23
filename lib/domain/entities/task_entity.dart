// [NOTEBOOK] Domain Entity: Pure Dart representation of our core data model.
// This layer contains zero external dependencies (no Drift, no Flutter UI imports).
class TaskEntity {
  final int id;
  final String title;
  final bool isCompleted;

  TaskEntity({
    required this.id,
    required this.title,
    required this.isCompleted,
  });
}