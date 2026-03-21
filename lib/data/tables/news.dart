import 'package:drift/drift.dart';

class News extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  TextColumn get body => text()();

  TextColumn get imagePath => text().nullable()();

  TextColumn get publishedAt => text().nullable()();
}
