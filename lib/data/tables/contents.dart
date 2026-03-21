import 'package:drift/drift.dart';

class Contents extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  TextColumn get description => text().nullable()();

  TextColumn get type => text()();

  TextColumn get resourcePath => text().nullable()();

  TextColumn get category => text().nullable()();

  TextColumn get createdAt => text().nullable()();
}
