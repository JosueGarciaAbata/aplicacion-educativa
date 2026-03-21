import 'package:drift/drift.dart';

import 'contents.dart';

class ContentActivityDetails extends Table {
  IntColumn get contentId => integer().references(Contents, #id)();

  TextColumn get subjectLabel => text()();

  TextColumn get activityLabel => text()();

  TextColumn get ctaLabel => text()();

  TextColumn get difficulty => text()();

  IntColumn get questionCount => integer()();

  IntColumn get estimatedMinutes => integer()();

  TextColumn get learningGoals => text()();

  @override
  Set<Column<Object>> get primaryKey => {contentId};
}
