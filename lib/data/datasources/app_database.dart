import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

// [NOTEBOOK] Drift Schema Definition:
// Defines the database table column types and default engine constraints.
class TasksTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 150)();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
}

// [NOTEBOOK] AppDatabase Class:
// Manages the SQLite database connection lifecycle and provides query capabilities.
@DriftDatabase(tables: [TasksTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'standalone_learning_db'));

  @override
  int get schemaVersion => 1;
}