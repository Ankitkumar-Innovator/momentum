import '../../../domain/entities/task_entity.dart';
import '../../../domain/repositories/task_repository.dart';
import '../datasources/app_database.dart';

// [NOTEBOOK] Repository Implementation:
// Bridges Drift database operations with the Domain Layer interface.
class TaskRepositoryImpl implements TaskRepository {
  final AppDatabase _db;

  TaskRepositoryImpl(this._db);

  @override
  Stream<List<TaskEntity>> watchAllTasks() {
    // 1. Listen to table changes reactively using watch()
    return _db.select(_db.tasksTable).watch().map((rows) {
      // 2. Map database row objects (TasksTableData) into Domain Entities (TaskEntity)
      return rows
          .map((row) => TaskEntity(
                id: row.id,
                title: row.title,
                isCompleted: row.isCompleted,
              ))
          .toList();
    });
  }

  @override
  Future<void> addTask(String title) async {
    // Inserts a new record using auto-incrementing ID defaults
    await _db.into(_db.tasksTable).insert(
          TasksTableCompanion.insert(title: title),
        );
  }

  @override
  Future<void> toggleTask(TaskEntity task) async {
    // Replaces row matching primary key with toggled completion boolean
    await _db.update(_db.tasksTable).replace(
          TasksTableData(
            id: task.id,
            title: task.title,
            isCompleted: !task.isCompleted,
          ),
        );
  }

  @override
  Future<void> deleteTask(int id) async {
    // Deletes row matching target ID integer
    await (_db.delete(_db.tasksTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}