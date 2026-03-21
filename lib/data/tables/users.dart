import 'package:drift/drift.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get username => text().unique()();

  TextColumn get password => text()();

  TextColumn get name => text()();

  TextColumn get createdAt => text().nullable()();
}
