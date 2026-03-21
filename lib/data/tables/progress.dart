import 'package:drift/drift.dart';

import 'contents.dart';
import 'users.dart';

class Progress extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get userId => integer().references(Users, #id)();

  IntColumn get contentId => integer().references(Contents, #id)();

  TextColumn get status => text()();

  TextColumn get completedAt => text().nullable()();
}
