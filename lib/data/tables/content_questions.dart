import 'package:drift/drift.dart';

import 'contents.dart';

class ContentQuestions extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get contentId => integer().references(Contents, #id)();

  IntColumn get sortOrder => integer()();

  TextColumn get typeLabel => text()();

  TextColumn get prompt => text()();

  TextColumn get optionsText => text()();

  IntColumn get correctIndex => integer()();
}
