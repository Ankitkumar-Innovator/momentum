import '../entities/task_entity.dart';

// [NOTEBOOK] Abstract Repository Contract:
// Defines WHAT data operations the business logic requires, hiding implementation details.
abstract class TaskRepository {
  Stream<List<TaskEntity>> watchAllTasks();
  Future<void> addTask(String title);
  Future<void> toggleTask(TaskEntity task);
  Future<void> deleteTask(int id);
}