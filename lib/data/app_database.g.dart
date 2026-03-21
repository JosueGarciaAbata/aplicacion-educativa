// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    username,
    password,
    name,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      password: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      ),
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String username;
  final String password;
  final String name;
  final String? createdAt;
  const User({
    required this.id,
    required this.username,
    required this.password,
    required this.name,
    this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      password: Value(password),
      name: Value(name),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<String?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<String?>(createdAt),
    };
  }

  User copyWith({
    int? id,
    String? username,
    String? password,
    String? name,
    Value<String?> createdAt = const Value.absent(),
  }) => User(
    id: id ?? this.id,
    username: username ?? this.username,
    password: password ?? this.password,
    name: name ?? this.name,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      password: data.password.present ? data.password.value : this.password,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username, password, name, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.password == this.password &&
          other.name == this.name &&
          other.createdAt == this.createdAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> password;
  final Value<String> name;
  final Value<String?> createdAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String password,
    required String name,
    this.createdAt = const Value.absent(),
  }) : username = Value(username),
       password = Value(password),
       name = Value(name);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? password,
    Expression<String>? name,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? username,
    Value<String>? password,
    Value<String>? name,
    Value<String?>? createdAt,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ContentsTable extends Contents with TableInfo<$ContentsTable, Content> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resourcePathMeta = const VerificationMeta(
    'resourcePath',
  );
  @override
  late final GeneratedColumn<String> resourcePath = GeneratedColumn<String>(
    'resource_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    type,
    resourcePath,
    category,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contents';
  @override
  VerificationContext validateIntegrity(
    Insertable<Content> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('resource_path')) {
      context.handle(
        _resourcePathMeta,
        resourcePath.isAcceptableOrUnknown(
          data['resource_path']!,
          _resourcePathMeta,
        ),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Content map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Content(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      resourcePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}resource_path'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      ),
    );
  }

  @override
  $ContentsTable createAlias(String alias) {
    return $ContentsTable(attachedDatabase, alias);
  }
}

class Content extends DataClass implements Insertable<Content> {
  final int id;
  final String title;
  final String? description;
  final String type;
  final String? resourcePath;
  final String? category;
  final String? createdAt;
  const Content({
    required this.id,
    required this.title,
    this.description,
    required this.type,
    this.resourcePath,
    this.category,
    this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || resourcePath != null) {
      map['resource_path'] = Variable<String>(resourcePath);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    return map;
  }

  ContentsCompanion toCompanion(bool nullToAbsent) {
    return ContentsCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      type: Value(type),
      resourcePath: resourcePath == null && nullToAbsent
          ? const Value.absent()
          : Value(resourcePath),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory Content.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Content(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      type: serializer.fromJson<String>(json['type']),
      resourcePath: serializer.fromJson<String?>(json['resourcePath']),
      category: serializer.fromJson<String?>(json['category']),
      createdAt: serializer.fromJson<String?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'type': serializer.toJson<String>(type),
      'resourcePath': serializer.toJson<String?>(resourcePath),
      'category': serializer.toJson<String?>(category),
      'createdAt': serializer.toJson<String?>(createdAt),
    };
  }

  Content copyWith({
    int? id,
    String? title,
    Value<String?> description = const Value.absent(),
    String? type,
    Value<String?> resourcePath = const Value.absent(),
    Value<String?> category = const Value.absent(),
    Value<String?> createdAt = const Value.absent(),
  }) => Content(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    type: type ?? this.type,
    resourcePath: resourcePath.present ? resourcePath.value : this.resourcePath,
    category: category.present ? category.value : this.category,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
  );
  Content copyWithCompanion(ContentsCompanion data) {
    return Content(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      type: data.type.present ? data.type.value : this.type,
      resourcePath: data.resourcePath.present
          ? data.resourcePath.value
          : this.resourcePath,
      category: data.category.present ? data.category.value : this.category,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Content(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('resourcePath: $resourcePath, ')
          ..write('category: $category, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    type,
    resourcePath,
    category,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Content &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.type == this.type &&
          other.resourcePath == this.resourcePath &&
          other.category == this.category &&
          other.createdAt == this.createdAt);
}

class ContentsCompanion extends UpdateCompanion<Content> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<String> type;
  final Value<String?> resourcePath;
  final Value<String?> category;
  final Value<String?> createdAt;
  const ContentsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.type = const Value.absent(),
    this.resourcePath = const Value.absent(),
    this.category = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ContentsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    required String type,
    this.resourcePath = const Value.absent(),
    this.category = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : title = Value(title),
       type = Value(type);
  static Insertable<Content> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? type,
    Expression<String>? resourcePath,
    Expression<String>? category,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (type != null) 'type': type,
      if (resourcePath != null) 'resource_path': resourcePath,
      if (category != null) 'category': category,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ContentsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String?>? description,
    Value<String>? type,
    Value<String?>? resourcePath,
    Value<String?>? category,
    Value<String?>? createdAt,
  }) {
    return ContentsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      resourcePath: resourcePath ?? this.resourcePath,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (resourcePath.present) {
      map['resource_path'] = Variable<String>(resourcePath.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContentsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('resourcePath: $resourcePath, ')
          ..write('category: $category, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $NewsTable extends News with TableInfo<$NewsTable, New> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NewsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _publishedAtMeta = const VerificationMeta(
    'publishedAt',
  );
  @override
  late final GeneratedColumn<String> publishedAt = GeneratedColumn<String>(
    'published_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    body,
    imagePath,
    publishedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'news';
  @override
  VerificationContext validateIntegrity(
    Insertable<New> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    }
    if (data.containsKey('published_at')) {
      context.handle(
        _publishedAtMeta,
        publishedAt.isAcceptableOrUnknown(
          data['published_at']!,
          _publishedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  New map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return New(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      ),
      publishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}published_at'],
      ),
    );
  }

  @override
  $NewsTable createAlias(String alias) {
    return $NewsTable(attachedDatabase, alias);
  }
}

class New extends DataClass implements Insertable<New> {
  final int id;
  final String title;
  final String body;
  final String? imagePath;
  final String? publishedAt;
  const New({
    required this.id,
    required this.title,
    required this.body,
    this.imagePath,
    this.publishedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    if (!nullToAbsent || publishedAt != null) {
      map['published_at'] = Variable<String>(publishedAt);
    }
    return map;
  }

  NewsCompanion toCompanion(bool nullToAbsent) {
    return NewsCompanion(
      id: Value(id),
      title: Value(title),
      body: Value(body),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      publishedAt: publishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(publishedAt),
    );
  }

  factory New.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return New(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      publishedAt: serializer.fromJson<String?>(json['publishedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'imagePath': serializer.toJson<String?>(imagePath),
      'publishedAt': serializer.toJson<String?>(publishedAt),
    };
  }

  New copyWith({
    int? id,
    String? title,
    String? body,
    Value<String?> imagePath = const Value.absent(),
    Value<String?> publishedAt = const Value.absent(),
  }) => New(
    id: id ?? this.id,
    title: title ?? this.title,
    body: body ?? this.body,
    imagePath: imagePath.present ? imagePath.value : this.imagePath,
    publishedAt: publishedAt.present ? publishedAt.value : this.publishedAt,
  );
  New copyWithCompanion(NewsCompanion data) {
    return New(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      publishedAt: data.publishedAt.present
          ? data.publishedAt.value
          : this.publishedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('New(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('imagePath: $imagePath, ')
          ..write('publishedAt: $publishedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, body, imagePath, publishedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is New &&
          other.id == this.id &&
          other.title == this.title &&
          other.body == this.body &&
          other.imagePath == this.imagePath &&
          other.publishedAt == this.publishedAt);
}

class NewsCompanion extends UpdateCompanion<New> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> body;
  final Value<String?> imagePath;
  final Value<String?> publishedAt;
  const NewsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.publishedAt = const Value.absent(),
  });
  NewsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String body,
    this.imagePath = const Value.absent(),
    this.publishedAt = const Value.absent(),
  }) : title = Value(title),
       body = Value(body);
  static Insertable<New> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? body,
    Expression<String>? imagePath,
    Expression<String>? publishedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (imagePath != null) 'image_path': imagePath,
      if (publishedAt != null) 'published_at': publishedAt,
    });
  }

  NewsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? body,
    Value<String?>? imagePath,
    Value<String?>? publishedAt,
  }) {
    return NewsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      imagePath: imagePath ?? this.imagePath,
      publishedAt: publishedAt ?? this.publishedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<String>(publishedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NewsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('imagePath: $imagePath, ')
          ..write('publishedAt: $publishedAt')
          ..write(')'))
        .toString();
  }
}

class $ProgressTable extends Progress
    with TableInfo<$ProgressTable, ProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _contentIdMeta = const VerificationMeta(
    'contentId',
  );
  @override
  late final GeneratedColumn<int> contentId = GeneratedColumn<int>(
    'content_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES contents (id)',
    ),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<String> completedAt = GeneratedColumn<String>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    contentId,
    status,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProgressData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('content_id')) {
      context.handle(
        _contentIdMeta,
        contentId.isAcceptableOrUnknown(data['content_id']!, _contentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_contentIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProgressData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      contentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}content_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $ProgressTable createAlias(String alias) {
    return $ProgressTable(attachedDatabase, alias);
  }
}

class ProgressData extends DataClass implements Insertable<ProgressData> {
  final int id;
  final int userId;
  final int contentId;
  final String status;
  final String? completedAt;
  const ProgressData({
    required this.id,
    required this.userId,
    required this.contentId,
    required this.status,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['content_id'] = Variable<int>(contentId);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<String>(completedAt);
    }
    return map;
  }

  ProgressCompanion toCompanion(bool nullToAbsent) {
    return ProgressCompanion(
      id: Value(id),
      userId: Value(userId),
      contentId: Value(contentId),
      status: Value(status),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory ProgressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProgressData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      contentId: serializer.fromJson<int>(json['contentId']),
      status: serializer.fromJson<String>(json['status']),
      completedAt: serializer.fromJson<String?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'contentId': serializer.toJson<int>(contentId),
      'status': serializer.toJson<String>(status),
      'completedAt': serializer.toJson<String?>(completedAt),
    };
  }

  ProgressData copyWith({
    int? id,
    int? userId,
    int? contentId,
    String? status,
    Value<String?> completedAt = const Value.absent(),
  }) => ProgressData(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    contentId: contentId ?? this.contentId,
    status: status ?? this.status,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  ProgressData copyWithCompanion(ProgressCompanion data) {
    return ProgressData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      contentId: data.contentId.present ? data.contentId.value : this.contentId,
      status: data.status.present ? data.status.value : this.status,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProgressData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('contentId: $contentId, ')
          ..write('status: $status, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, contentId, status, completedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProgressData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.contentId == this.contentId &&
          other.status == this.status &&
          other.completedAt == this.completedAt);
}

class ProgressCompanion extends UpdateCompanion<ProgressData> {
  final Value<int> id;
  final Value<int> userId;
  final Value<int> contentId;
  final Value<String> status;
  final Value<String?> completedAt;
  const ProgressCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.contentId = const Value.absent(),
    this.status = const Value.absent(),
    this.completedAt = const Value.absent(),
  });
  ProgressCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required int contentId,
    required String status,
    this.completedAt = const Value.absent(),
  }) : userId = Value(userId),
       contentId = Value(contentId),
       status = Value(status);
  static Insertable<ProgressData> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<int>? contentId,
    Expression<String>? status,
    Expression<String>? completedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (contentId != null) 'content_id': contentId,
      if (status != null) 'status': status,
      if (completedAt != null) 'completed_at': completedAt,
    });
  }

  ProgressCompanion copyWith({
    Value<int>? id,
    Value<int>? userId,
    Value<int>? contentId,
    Value<String>? status,
    Value<String?>? completedAt,
  }) {
    return ProgressCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      contentId: contentId ?? this.contentId,
      status: status ?? this.status,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (contentId.present) {
      map['content_id'] = Variable<int>(contentId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<String>(completedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProgressCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('contentId: $contentId, ')
          ..write('status: $status, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }
}

class $ContentActivityDetailsTable extends ContentActivityDetails
    with TableInfo<$ContentActivityDetailsTable, ContentActivityDetail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContentActivityDetailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _contentIdMeta = const VerificationMeta(
    'contentId',
  );
  @override
  late final GeneratedColumn<int> contentId = GeneratedColumn<int>(
    'content_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES contents (id)',
    ),
  );
  static const VerificationMeta _subjectLabelMeta = const VerificationMeta(
    'subjectLabel',
  );
  @override
  late final GeneratedColumn<String> subjectLabel = GeneratedColumn<String>(
    'subject_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activityLabelMeta = const VerificationMeta(
    'activityLabel',
  );
  @override
  late final GeneratedColumn<String> activityLabel = GeneratedColumn<String>(
    'activity_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ctaLabelMeta = const VerificationMeta(
    'ctaLabel',
  );
  @override
  late final GeneratedColumn<String> ctaLabel = GeneratedColumn<String>(
    'cta_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _questionCountMeta = const VerificationMeta(
    'questionCount',
  );
  @override
  late final GeneratedColumn<int> questionCount = GeneratedColumn<int>(
    'question_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estimatedMinutesMeta = const VerificationMeta(
    'estimatedMinutes',
  );
  @override
  late final GeneratedColumn<int> estimatedMinutes = GeneratedColumn<int>(
    'estimated_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _learningGoalsMeta = const VerificationMeta(
    'learningGoals',
  );
  @override
  late final GeneratedColumn<String> learningGoals = GeneratedColumn<String>(
    'learning_goals',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    contentId,
    subjectLabel,
    activityLabel,
    ctaLabel,
    difficulty,
    questionCount,
    estimatedMinutes,
    learningGoals,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'content_activity_details';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContentActivityDetail> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('content_id')) {
      context.handle(
        _contentIdMeta,
        contentId.isAcceptableOrUnknown(data['content_id']!, _contentIdMeta),
      );
    }
    if (data.containsKey('subject_label')) {
      context.handle(
        _subjectLabelMeta,
        subjectLabel.isAcceptableOrUnknown(
          data['subject_label']!,
          _subjectLabelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subjectLabelMeta);
    }
    if (data.containsKey('activity_label')) {
      context.handle(
        _activityLabelMeta,
        activityLabel.isAcceptableOrUnknown(
          data['activity_label']!,
          _activityLabelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_activityLabelMeta);
    }
    if (data.containsKey('cta_label')) {
      context.handle(
        _ctaLabelMeta,
        ctaLabel.isAcceptableOrUnknown(data['cta_label']!, _ctaLabelMeta),
      );
    } else if (isInserting) {
      context.missing(_ctaLabelMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('question_count')) {
      context.handle(
        _questionCountMeta,
        questionCount.isAcceptableOrUnknown(
          data['question_count']!,
          _questionCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_questionCountMeta);
    }
    if (data.containsKey('estimated_minutes')) {
      context.handle(
        _estimatedMinutesMeta,
        estimatedMinutes.isAcceptableOrUnknown(
          data['estimated_minutes']!,
          _estimatedMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_estimatedMinutesMeta);
    }
    if (data.containsKey('learning_goals')) {
      context.handle(
        _learningGoalsMeta,
        learningGoals.isAcceptableOrUnknown(
          data['learning_goals']!,
          _learningGoalsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_learningGoalsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {contentId};
  @override
  ContentActivityDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContentActivityDetail(
      contentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}content_id'],
      )!,
      subjectLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject_label'],
      )!,
      activityLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_label'],
      )!,
      ctaLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cta_label'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      )!,
      questionCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}question_count'],
      )!,
      estimatedMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_minutes'],
      )!,
      learningGoals: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}learning_goals'],
      )!,
    );
  }

  @override
  $ContentActivityDetailsTable createAlias(String alias) {
    return $ContentActivityDetailsTable(attachedDatabase, alias);
  }
}

class ContentActivityDetail extends DataClass
    implements Insertable<ContentActivityDetail> {
  final int contentId;
  final String subjectLabel;
  final String activityLabel;
  final String ctaLabel;
  final String difficulty;
  final int questionCount;
  final int estimatedMinutes;
  final String learningGoals;
  const ContentActivityDetail({
    required this.contentId,
    required this.subjectLabel,
    required this.activityLabel,
    required this.ctaLabel,
    required this.difficulty,
    required this.questionCount,
    required this.estimatedMinutes,
    required this.learningGoals,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['content_id'] = Variable<int>(contentId);
    map['subject_label'] = Variable<String>(subjectLabel);
    map['activity_label'] = Variable<String>(activityLabel);
    map['cta_label'] = Variable<String>(ctaLabel);
    map['difficulty'] = Variable<String>(difficulty);
    map['question_count'] = Variable<int>(questionCount);
    map['estimated_minutes'] = Variable<int>(estimatedMinutes);
    map['learning_goals'] = Variable<String>(learningGoals);
    return map;
  }

  ContentActivityDetailsCompanion toCompanion(bool nullToAbsent) {
    return ContentActivityDetailsCompanion(
      contentId: Value(contentId),
      subjectLabel: Value(subjectLabel),
      activityLabel: Value(activityLabel),
      ctaLabel: Value(ctaLabel),
      difficulty: Value(difficulty),
      questionCount: Value(questionCount),
      estimatedMinutes: Value(estimatedMinutes),
      learningGoals: Value(learningGoals),
    );
  }

  factory ContentActivityDetail.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContentActivityDetail(
      contentId: serializer.fromJson<int>(json['contentId']),
      subjectLabel: serializer.fromJson<String>(json['subjectLabel']),
      activityLabel: serializer.fromJson<String>(json['activityLabel']),
      ctaLabel: serializer.fromJson<String>(json['ctaLabel']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      questionCount: serializer.fromJson<int>(json['questionCount']),
      estimatedMinutes: serializer.fromJson<int>(json['estimatedMinutes']),
      learningGoals: serializer.fromJson<String>(json['learningGoals']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'contentId': serializer.toJson<int>(contentId),
      'subjectLabel': serializer.toJson<String>(subjectLabel),
      'activityLabel': serializer.toJson<String>(activityLabel),
      'ctaLabel': serializer.toJson<String>(ctaLabel),
      'difficulty': serializer.toJson<String>(difficulty),
      'questionCount': serializer.toJson<int>(questionCount),
      'estimatedMinutes': serializer.toJson<int>(estimatedMinutes),
      'learningGoals': serializer.toJson<String>(learningGoals),
    };
  }

  ContentActivityDetail copyWith({
    int? contentId,
    String? subjectLabel,
    String? activityLabel,
    String? ctaLabel,
    String? difficulty,
    int? questionCount,
    int? estimatedMinutes,
    String? learningGoals,
  }) => ContentActivityDetail(
    contentId: contentId ?? this.contentId,
    subjectLabel: subjectLabel ?? this.subjectLabel,
    activityLabel: activityLabel ?? this.activityLabel,
    ctaLabel: ctaLabel ?? this.ctaLabel,
    difficulty: difficulty ?? this.difficulty,
    questionCount: questionCount ?? this.questionCount,
    estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
    learningGoals: learningGoals ?? this.learningGoals,
  );
  ContentActivityDetail copyWithCompanion(
    ContentActivityDetailsCompanion data,
  ) {
    return ContentActivityDetail(
      contentId: data.contentId.present ? data.contentId.value : this.contentId,
      subjectLabel: data.subjectLabel.present
          ? data.subjectLabel.value
          : this.subjectLabel,
      activityLabel: data.activityLabel.present
          ? data.activityLabel.value
          : this.activityLabel,
      ctaLabel: data.ctaLabel.present ? data.ctaLabel.value : this.ctaLabel,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      questionCount: data.questionCount.present
          ? data.questionCount.value
          : this.questionCount,
      estimatedMinutes: data.estimatedMinutes.present
          ? data.estimatedMinutes.value
          : this.estimatedMinutes,
      learningGoals: data.learningGoals.present
          ? data.learningGoals.value
          : this.learningGoals,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContentActivityDetail(')
          ..write('contentId: $contentId, ')
          ..write('subjectLabel: $subjectLabel, ')
          ..write('activityLabel: $activityLabel, ')
          ..write('ctaLabel: $ctaLabel, ')
          ..write('difficulty: $difficulty, ')
          ..write('questionCount: $questionCount, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('learningGoals: $learningGoals')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    contentId,
    subjectLabel,
    activityLabel,
    ctaLabel,
    difficulty,
    questionCount,
    estimatedMinutes,
    learningGoals,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContentActivityDetail &&
          other.contentId == this.contentId &&
          other.subjectLabel == this.subjectLabel &&
          other.activityLabel == this.activityLabel &&
          other.ctaLabel == this.ctaLabel &&
          other.difficulty == this.difficulty &&
          other.questionCount == this.questionCount &&
          other.estimatedMinutes == this.estimatedMinutes &&
          other.learningGoals == this.learningGoals);
}

class ContentActivityDetailsCompanion
    extends UpdateCompanion<ContentActivityDetail> {
  final Value<int> contentId;
  final Value<String> subjectLabel;
  final Value<String> activityLabel;
  final Value<String> ctaLabel;
  final Value<String> difficulty;
  final Value<int> questionCount;
  final Value<int> estimatedMinutes;
  final Value<String> learningGoals;
  const ContentActivityDetailsCompanion({
    this.contentId = const Value.absent(),
    this.subjectLabel = const Value.absent(),
    this.activityLabel = const Value.absent(),
    this.ctaLabel = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.questionCount = const Value.absent(),
    this.estimatedMinutes = const Value.absent(),
    this.learningGoals = const Value.absent(),
  });
  ContentActivityDetailsCompanion.insert({
    this.contentId = const Value.absent(),
    required String subjectLabel,
    required String activityLabel,
    required String ctaLabel,
    required String difficulty,
    required int questionCount,
    required int estimatedMinutes,
    required String learningGoals,
  }) : subjectLabel = Value(subjectLabel),
       activityLabel = Value(activityLabel),
       ctaLabel = Value(ctaLabel),
       difficulty = Value(difficulty),
       questionCount = Value(questionCount),
       estimatedMinutes = Value(estimatedMinutes),
       learningGoals = Value(learningGoals);
  static Insertable<ContentActivityDetail> custom({
    Expression<int>? contentId,
    Expression<String>? subjectLabel,
    Expression<String>? activityLabel,
    Expression<String>? ctaLabel,
    Expression<String>? difficulty,
    Expression<int>? questionCount,
    Expression<int>? estimatedMinutes,
    Expression<String>? learningGoals,
  }) {
    return RawValuesInsertable({
      if (contentId != null) 'content_id': contentId,
      if (subjectLabel != null) 'subject_label': subjectLabel,
      if (activityLabel != null) 'activity_label': activityLabel,
      if (ctaLabel != null) 'cta_label': ctaLabel,
      if (difficulty != null) 'difficulty': difficulty,
      if (questionCount != null) 'question_count': questionCount,
      if (estimatedMinutes != null) 'estimated_minutes': estimatedMinutes,
      if (learningGoals != null) 'learning_goals': learningGoals,
    });
  }

  ContentActivityDetailsCompanion copyWith({
    Value<int>? contentId,
    Value<String>? subjectLabel,
    Value<String>? activityLabel,
    Value<String>? ctaLabel,
    Value<String>? difficulty,
    Value<int>? questionCount,
    Value<int>? estimatedMinutes,
    Value<String>? learningGoals,
  }) {
    return ContentActivityDetailsCompanion(
      contentId: contentId ?? this.contentId,
      subjectLabel: subjectLabel ?? this.subjectLabel,
      activityLabel: activityLabel ?? this.activityLabel,
      ctaLabel: ctaLabel ?? this.ctaLabel,
      difficulty: difficulty ?? this.difficulty,
      questionCount: questionCount ?? this.questionCount,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      learningGoals: learningGoals ?? this.learningGoals,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (contentId.present) {
      map['content_id'] = Variable<int>(contentId.value);
    }
    if (subjectLabel.present) {
      map['subject_label'] = Variable<String>(subjectLabel.value);
    }
    if (activityLabel.present) {
      map['activity_label'] = Variable<String>(activityLabel.value);
    }
    if (ctaLabel.present) {
      map['cta_label'] = Variable<String>(ctaLabel.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (questionCount.present) {
      map['question_count'] = Variable<int>(questionCount.value);
    }
    if (estimatedMinutes.present) {
      map['estimated_minutes'] = Variable<int>(estimatedMinutes.value);
    }
    if (learningGoals.present) {
      map['learning_goals'] = Variable<String>(learningGoals.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContentActivityDetailsCompanion(')
          ..write('contentId: $contentId, ')
          ..write('subjectLabel: $subjectLabel, ')
          ..write('activityLabel: $activityLabel, ')
          ..write('ctaLabel: $ctaLabel, ')
          ..write('difficulty: $difficulty, ')
          ..write('questionCount: $questionCount, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('learningGoals: $learningGoals')
          ..write(')'))
        .toString();
  }
}

class $ContentQuestionsTable extends ContentQuestions
    with TableInfo<$ContentQuestionsTable, ContentQuestion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContentQuestionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _contentIdMeta = const VerificationMeta(
    'contentId',
  );
  @override
  late final GeneratedColumn<int> contentId = GeneratedColumn<int>(
    'content_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES contents (id)',
    ),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeLabelMeta = const VerificationMeta(
    'typeLabel',
  );
  @override
  late final GeneratedColumn<String> typeLabel = GeneratedColumn<String>(
    'type_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _promptMeta = const VerificationMeta('prompt');
  @override
  late final GeneratedColumn<String> prompt = GeneratedColumn<String>(
    'prompt',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _optionsTextMeta = const VerificationMeta(
    'optionsText',
  );
  @override
  late final GeneratedColumn<String> optionsText = GeneratedColumn<String>(
    'options_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correctIndexMeta = const VerificationMeta(
    'correctIndex',
  );
  @override
  late final GeneratedColumn<int> correctIndex = GeneratedColumn<int>(
    'correct_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    contentId,
    sortOrder,
    typeLabel,
    prompt,
    optionsText,
    correctIndex,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'content_questions';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContentQuestion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content_id')) {
      context.handle(
        _contentIdMeta,
        contentId.isAcceptableOrUnknown(data['content_id']!, _contentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_contentIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('type_label')) {
      context.handle(
        _typeLabelMeta,
        typeLabel.isAcceptableOrUnknown(data['type_label']!, _typeLabelMeta),
      );
    } else if (isInserting) {
      context.missing(_typeLabelMeta);
    }
    if (data.containsKey('prompt')) {
      context.handle(
        _promptMeta,
        prompt.isAcceptableOrUnknown(data['prompt']!, _promptMeta),
      );
    } else if (isInserting) {
      context.missing(_promptMeta);
    }
    if (data.containsKey('options_text')) {
      context.handle(
        _optionsTextMeta,
        optionsText.isAcceptableOrUnknown(
          data['options_text']!,
          _optionsTextMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_optionsTextMeta);
    }
    if (data.containsKey('correct_index')) {
      context.handle(
        _correctIndexMeta,
        correctIndex.isAcceptableOrUnknown(
          data['correct_index']!,
          _correctIndexMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_correctIndexMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContentQuestion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContentQuestion(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      contentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}content_id'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      typeLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type_label'],
      )!,
      prompt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prompt'],
      )!,
      optionsText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}options_text'],
      )!,
      correctIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_index'],
      )!,
    );
  }

  @override
  $ContentQuestionsTable createAlias(String alias) {
    return $ContentQuestionsTable(attachedDatabase, alias);
  }
}

class ContentQuestion extends DataClass implements Insertable<ContentQuestion> {
  final int id;
  final int contentId;
  final int sortOrder;
  final String typeLabel;
  final String prompt;
  final String optionsText;
  final int correctIndex;
  const ContentQuestion({
    required this.id,
    required this.contentId,
    required this.sortOrder,
    required this.typeLabel,
    required this.prompt,
    required this.optionsText,
    required this.correctIndex,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content_id'] = Variable<int>(contentId);
    map['sort_order'] = Variable<int>(sortOrder);
    map['type_label'] = Variable<String>(typeLabel);
    map['prompt'] = Variable<String>(prompt);
    map['options_text'] = Variable<String>(optionsText);
    map['correct_index'] = Variable<int>(correctIndex);
    return map;
  }

  ContentQuestionsCompanion toCompanion(bool nullToAbsent) {
    return ContentQuestionsCompanion(
      id: Value(id),
      contentId: Value(contentId),
      sortOrder: Value(sortOrder),
      typeLabel: Value(typeLabel),
      prompt: Value(prompt),
      optionsText: Value(optionsText),
      correctIndex: Value(correctIndex),
    );
  }

  factory ContentQuestion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContentQuestion(
      id: serializer.fromJson<int>(json['id']),
      contentId: serializer.fromJson<int>(json['contentId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      typeLabel: serializer.fromJson<String>(json['typeLabel']),
      prompt: serializer.fromJson<String>(json['prompt']),
      optionsText: serializer.fromJson<String>(json['optionsText']),
      correctIndex: serializer.fromJson<int>(json['correctIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'contentId': serializer.toJson<int>(contentId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'typeLabel': serializer.toJson<String>(typeLabel),
      'prompt': serializer.toJson<String>(prompt),
      'optionsText': serializer.toJson<String>(optionsText),
      'correctIndex': serializer.toJson<int>(correctIndex),
    };
  }

  ContentQuestion copyWith({
    int? id,
    int? contentId,
    int? sortOrder,
    String? typeLabel,
    String? prompt,
    String? optionsText,
    int? correctIndex,
  }) => ContentQuestion(
    id: id ?? this.id,
    contentId: contentId ?? this.contentId,
    sortOrder: sortOrder ?? this.sortOrder,
    typeLabel: typeLabel ?? this.typeLabel,
    prompt: prompt ?? this.prompt,
    optionsText: optionsText ?? this.optionsText,
    correctIndex: correctIndex ?? this.correctIndex,
  );
  ContentQuestion copyWithCompanion(ContentQuestionsCompanion data) {
    return ContentQuestion(
      id: data.id.present ? data.id.value : this.id,
      contentId: data.contentId.present ? data.contentId.value : this.contentId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      typeLabel: data.typeLabel.present ? data.typeLabel.value : this.typeLabel,
      prompt: data.prompt.present ? data.prompt.value : this.prompt,
      optionsText: data.optionsText.present
          ? data.optionsText.value
          : this.optionsText,
      correctIndex: data.correctIndex.present
          ? data.correctIndex.value
          : this.correctIndex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContentQuestion(')
          ..write('id: $id, ')
          ..write('contentId: $contentId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('typeLabel: $typeLabel, ')
          ..write('prompt: $prompt, ')
          ..write('optionsText: $optionsText, ')
          ..write('correctIndex: $correctIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    contentId,
    sortOrder,
    typeLabel,
    prompt,
    optionsText,
    correctIndex,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContentQuestion &&
          other.id == this.id &&
          other.contentId == this.contentId &&
          other.sortOrder == this.sortOrder &&
          other.typeLabel == this.typeLabel &&
          other.prompt == this.prompt &&
          other.optionsText == this.optionsText &&
          other.correctIndex == this.correctIndex);
}

class ContentQuestionsCompanion extends UpdateCompanion<ContentQuestion> {
  final Value<int> id;
  final Value<int> contentId;
  final Value<int> sortOrder;
  final Value<String> typeLabel;
  final Value<String> prompt;
  final Value<String> optionsText;
  final Value<int> correctIndex;
  const ContentQuestionsCompanion({
    this.id = const Value.absent(),
    this.contentId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.typeLabel = const Value.absent(),
    this.prompt = const Value.absent(),
    this.optionsText = const Value.absent(),
    this.correctIndex = const Value.absent(),
  });
  ContentQuestionsCompanion.insert({
    this.id = const Value.absent(),
    required int contentId,
    required int sortOrder,
    required String typeLabel,
    required String prompt,
    required String optionsText,
    required int correctIndex,
  }) : contentId = Value(contentId),
       sortOrder = Value(sortOrder),
       typeLabel = Value(typeLabel),
       prompt = Value(prompt),
       optionsText = Value(optionsText),
       correctIndex = Value(correctIndex);
  static Insertable<ContentQuestion> custom({
    Expression<int>? id,
    Expression<int>? contentId,
    Expression<int>? sortOrder,
    Expression<String>? typeLabel,
    Expression<String>? prompt,
    Expression<String>? optionsText,
    Expression<int>? correctIndex,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (contentId != null) 'content_id': contentId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (typeLabel != null) 'type_label': typeLabel,
      if (prompt != null) 'prompt': prompt,
      if (optionsText != null) 'options_text': optionsText,
      if (correctIndex != null) 'correct_index': correctIndex,
    });
  }

  ContentQuestionsCompanion copyWith({
    Value<int>? id,
    Value<int>? contentId,
    Value<int>? sortOrder,
    Value<String>? typeLabel,
    Value<String>? prompt,
    Value<String>? optionsText,
    Value<int>? correctIndex,
  }) {
    return ContentQuestionsCompanion(
      id: id ?? this.id,
      contentId: contentId ?? this.contentId,
      sortOrder: sortOrder ?? this.sortOrder,
      typeLabel: typeLabel ?? this.typeLabel,
      prompt: prompt ?? this.prompt,
      optionsText: optionsText ?? this.optionsText,
      correctIndex: correctIndex ?? this.correctIndex,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (contentId.present) {
      map['content_id'] = Variable<int>(contentId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (typeLabel.present) {
      map['type_label'] = Variable<String>(typeLabel.value);
    }
    if (prompt.present) {
      map['prompt'] = Variable<String>(prompt.value);
    }
    if (optionsText.present) {
      map['options_text'] = Variable<String>(optionsText.value);
    }
    if (correctIndex.present) {
      map['correct_index'] = Variable<int>(correctIndex.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContentQuestionsCompanion(')
          ..write('id: $id, ')
          ..write('contentId: $contentId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('typeLabel: $typeLabel, ')
          ..write('prompt: $prompt, ')
          ..write('optionsText: $optionsText, ')
          ..write('correctIndex: $correctIndex')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $ContentsTable contents = $ContentsTable(this);
  late final $NewsTable news = $NewsTable(this);
  late final $ProgressTable progress = $ProgressTable(this);
  late final $ContentActivityDetailsTable contentActivityDetails =
      $ContentActivityDetailsTable(this);
  late final $ContentQuestionsTable contentQuestions = $ContentQuestionsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    contents,
    news,
    progress,
    contentActivityDetails,
    contentQuestions,
  ];
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      required String username,
      required String password,
      required String name,
      Value<String?> createdAt,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<String> username,
      Value<String> password,
      Value<String> name,
      Value<String?> createdAt,
    });

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProgressTable, List<ProgressData>>
  _progressRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.progress,
    aliasName: $_aliasNameGenerator(db.users.id, db.progress.userId),
  );

  $$ProgressTableProcessedTableManager get progressRefs {
    final manager = $$ProgressTableTableManager(
      $_db,
      $_db.progress,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_progressRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> progressRefs(
    Expression<bool> Function($$ProgressTableFilterComposer f) f,
  ) {
    final $$ProgressTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.progress,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgressTableFilterComposer(
            $db: $db,
            $table: $db.progress,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> progressRefs<T extends Object>(
    Expression<T> Function($$ProgressTableAnnotationComposer a) f,
  ) {
    final $$ProgressTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.progress,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgressTableAnnotationComposer(
            $db: $db,
            $table: $db.progress,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, $$UsersTableReferences),
          User,
          PrefetchHooks Function({bool progressRefs})
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> password = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> createdAt = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                username: username,
                password: password,
                name: name,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String username,
                required String password,
                required String name,
                Value<String?> createdAt = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                username: username,
                password: password,
                name: name,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$UsersTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({progressRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (progressRefs) db.progress],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (progressRefs)
                    await $_getPrefetchedData<User, $UsersTable, ProgressData>(
                      currentTable: table,
                      referencedTable: $$UsersTableReferences
                          ._progressRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$UsersTableReferences(db, table, p0).progressRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.userId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, $$UsersTableReferences),
      User,
      PrefetchHooks Function({bool progressRefs})
    >;
typedef $$ContentsTableCreateCompanionBuilder =
    ContentsCompanion Function({
      Value<int> id,
      required String title,
      Value<String?> description,
      required String type,
      Value<String?> resourcePath,
      Value<String?> category,
      Value<String?> createdAt,
    });
typedef $$ContentsTableUpdateCompanionBuilder =
    ContentsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String?> description,
      Value<String> type,
      Value<String?> resourcePath,
      Value<String?> category,
      Value<String?> createdAt,
    });

final class $$ContentsTableReferences
    extends BaseReferences<_$AppDatabase, $ContentsTable, Content> {
  $$ContentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProgressTable, List<ProgressData>>
  _progressRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.progress,
    aliasName: $_aliasNameGenerator(db.contents.id, db.progress.contentId),
  );

  $$ProgressTableProcessedTableManager get progressRefs {
    final manager = $$ProgressTableTableManager(
      $_db,
      $_db.progress,
    ).filter((f) => f.contentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_progressRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ContentActivityDetailsTable,
    List<ContentActivityDetail>
  >
  _contentActivityDetailsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.contentActivityDetails,
        aliasName: $_aliasNameGenerator(
          db.contents.id,
          db.contentActivityDetails.contentId,
        ),
      );

  $$ContentActivityDetailsTableProcessedTableManager
  get contentActivityDetailsRefs {
    final manager = $$ContentActivityDetailsTableTableManager(
      $_db,
      $_db.contentActivityDetails,
    ).filter((f) => f.contentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _contentActivityDetailsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ContentQuestionsTable, List<ContentQuestion>>
  _contentQuestionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.contentQuestions,
    aliasName: $_aliasNameGenerator(
      db.contents.id,
      db.contentQuestions.contentId,
    ),
  );

  $$ContentQuestionsTableProcessedTableManager get contentQuestionsRefs {
    final manager = $$ContentQuestionsTableTableManager(
      $_db,
      $_db.contentQuestions,
    ).filter((f) => f.contentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _contentQuestionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ContentsTableFilterComposer
    extends Composer<_$AppDatabase, $ContentsTable> {
  $$ContentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get resourcePath => $composableBuilder(
    column: $table.resourcePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> progressRefs(
    Expression<bool> Function($$ProgressTableFilterComposer f) f,
  ) {
    final $$ProgressTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.progress,
      getReferencedColumn: (t) => t.contentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgressTableFilterComposer(
            $db: $db,
            $table: $db.progress,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> contentActivityDetailsRefs(
    Expression<bool> Function($$ContentActivityDetailsTableFilterComposer f) f,
  ) {
    final $$ContentActivityDetailsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.contentActivityDetails,
          getReferencedColumn: (t) => t.contentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ContentActivityDetailsTableFilterComposer(
                $db: $db,
                $table: $db.contentActivityDetails,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> contentQuestionsRefs(
    Expression<bool> Function($$ContentQuestionsTableFilterComposer f) f,
  ) {
    final $$ContentQuestionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contentQuestions,
      getReferencedColumn: (t) => t.contentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentQuestionsTableFilterComposer(
            $db: $db,
            $table: $db.contentQuestions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ContentsTableOrderingComposer
    extends Composer<_$AppDatabase, $ContentsTable> {
  $$ContentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resourcePath => $composableBuilder(
    column: $table.resourcePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ContentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContentsTable> {
  $$ContentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get resourcePath => $composableBuilder(
    column: $table.resourcePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> progressRefs<T extends Object>(
    Expression<T> Function($$ProgressTableAnnotationComposer a) f,
  ) {
    final $$ProgressTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.progress,
      getReferencedColumn: (t) => t.contentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgressTableAnnotationComposer(
            $db: $db,
            $table: $db.progress,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> contentActivityDetailsRefs<T extends Object>(
    Expression<T> Function($$ContentActivityDetailsTableAnnotationComposer a) f,
  ) {
    final $$ContentActivityDetailsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.contentActivityDetails,
          getReferencedColumn: (t) => t.contentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ContentActivityDetailsTableAnnotationComposer(
                $db: $db,
                $table: $db.contentActivityDetails,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> contentQuestionsRefs<T extends Object>(
    Expression<T> Function($$ContentQuestionsTableAnnotationComposer a) f,
  ) {
    final $$ContentQuestionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contentQuestions,
      getReferencedColumn: (t) => t.contentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentQuestionsTableAnnotationComposer(
            $db: $db,
            $table: $db.contentQuestions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ContentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContentsTable,
          Content,
          $$ContentsTableFilterComposer,
          $$ContentsTableOrderingComposer,
          $$ContentsTableAnnotationComposer,
          $$ContentsTableCreateCompanionBuilder,
          $$ContentsTableUpdateCompanionBuilder,
          (Content, $$ContentsTableReferences),
          Content,
          PrefetchHooks Function({
            bool progressRefs,
            bool contentActivityDetailsRefs,
            bool contentQuestionsRefs,
          })
        > {
  $$ContentsTableTableManager(_$AppDatabase db, $ContentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> resourcePath = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> createdAt = const Value.absent(),
              }) => ContentsCompanion(
                id: id,
                title: title,
                description: description,
                type: type,
                resourcePath: resourcePath,
                category: category,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String?> description = const Value.absent(),
                required String type,
                Value<String?> resourcePath = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> createdAt = const Value.absent(),
              }) => ContentsCompanion.insert(
                id: id,
                title: title,
                description: description,
                type: type,
                resourcePath: resourcePath,
                category: category,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ContentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                progressRefs = false,
                contentActivityDetailsRefs = false,
                contentQuestionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (progressRefs) db.progress,
                    if (contentActivityDetailsRefs) db.contentActivityDetails,
                    if (contentQuestionsRefs) db.contentQuestions,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (progressRefs)
                        await $_getPrefetchedData<
                          Content,
                          $ContentsTable,
                          ProgressData
                        >(
                          currentTable: table,
                          referencedTable: $$ContentsTableReferences
                              ._progressRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ContentsTableReferences(
                                db,
                                table,
                                p0,
                              ).progressRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.contentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (contentActivityDetailsRefs)
                        await $_getPrefetchedData<
                          Content,
                          $ContentsTable,
                          ContentActivityDetail
                        >(
                          currentTable: table,
                          referencedTable: $$ContentsTableReferences
                              ._contentActivityDetailsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ContentsTableReferences(
                                db,
                                table,
                                p0,
                              ).contentActivityDetailsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.contentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (contentQuestionsRefs)
                        await $_getPrefetchedData<
                          Content,
                          $ContentsTable,
                          ContentQuestion
                        >(
                          currentTable: table,
                          referencedTable: $$ContentsTableReferences
                              ._contentQuestionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ContentsTableReferences(
                                db,
                                table,
                                p0,
                              ).contentQuestionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.contentId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ContentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContentsTable,
      Content,
      $$ContentsTableFilterComposer,
      $$ContentsTableOrderingComposer,
      $$ContentsTableAnnotationComposer,
      $$ContentsTableCreateCompanionBuilder,
      $$ContentsTableUpdateCompanionBuilder,
      (Content, $$ContentsTableReferences),
      Content,
      PrefetchHooks Function({
        bool progressRefs,
        bool contentActivityDetailsRefs,
        bool contentQuestionsRefs,
      })
    >;
typedef $$NewsTableCreateCompanionBuilder =
    NewsCompanion Function({
      Value<int> id,
      required String title,
      required String body,
      Value<String?> imagePath,
      Value<String?> publishedAt,
    });
typedef $$NewsTableUpdateCompanionBuilder =
    NewsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> body,
      Value<String?> imagePath,
      Value<String?> publishedAt,
    });

class $$NewsTableFilterComposer extends Composer<_$AppDatabase, $NewsTable> {
  $$NewsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NewsTableOrderingComposer extends Composer<_$AppDatabase, $NewsTable> {
  $$NewsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NewsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NewsTable> {
  $$NewsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => column,
  );
}

class $$NewsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NewsTable,
          New,
          $$NewsTableFilterComposer,
          $$NewsTableOrderingComposer,
          $$NewsTableAnnotationComposer,
          $$NewsTableCreateCompanionBuilder,
          $$NewsTableUpdateCompanionBuilder,
          (New, BaseReferences<_$AppDatabase, $NewsTable, New>),
          New,
          PrefetchHooks Function()
        > {
  $$NewsTableTableManager(_$AppDatabase db, $NewsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NewsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NewsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NewsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<String?> publishedAt = const Value.absent(),
              }) => NewsCompanion(
                id: id,
                title: title,
                body: body,
                imagePath: imagePath,
                publishedAt: publishedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String body,
                Value<String?> imagePath = const Value.absent(),
                Value<String?> publishedAt = const Value.absent(),
              }) => NewsCompanion.insert(
                id: id,
                title: title,
                body: body,
                imagePath: imagePath,
                publishedAt: publishedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NewsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NewsTable,
      New,
      $$NewsTableFilterComposer,
      $$NewsTableOrderingComposer,
      $$NewsTableAnnotationComposer,
      $$NewsTableCreateCompanionBuilder,
      $$NewsTableUpdateCompanionBuilder,
      (New, BaseReferences<_$AppDatabase, $NewsTable, New>),
      New,
      PrefetchHooks Function()
    >;
typedef $$ProgressTableCreateCompanionBuilder =
    ProgressCompanion Function({
      Value<int> id,
      required int userId,
      required int contentId,
      required String status,
      Value<String?> completedAt,
    });
typedef $$ProgressTableUpdateCompanionBuilder =
    ProgressCompanion Function({
      Value<int> id,
      Value<int> userId,
      Value<int> contentId,
      Value<String> status,
      Value<String?> completedAt,
    });

final class $$ProgressTableReferences
    extends BaseReferences<_$AppDatabase, $ProgressTable, ProgressData> {
  $$ProgressTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.progress.userId, db.users.id),
  );

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ContentsTable _contentIdTable(_$AppDatabase db) => db.contents
      .createAlias($_aliasNameGenerator(db.progress.contentId, db.contents.id));

  $$ContentsTableProcessedTableManager get contentId {
    final $_column = $_itemColumn<int>('content_id')!;

    final manager = $$ContentsTableTableManager(
      $_db,
      $_db.contents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_contentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProgressTableFilterComposer
    extends Composer<_$AppDatabase, $ProgressTable> {
  $$ProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContentsTableFilterComposer get contentId {
    final $$ContentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentId,
      referencedTable: $db.contents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentsTableFilterComposer(
            $db: $db,
            $table: $db.contents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $ProgressTable> {
  $$ProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContentsTableOrderingComposer get contentId {
    final $$ContentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentId,
      referencedTable: $db.contents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentsTableOrderingComposer(
            $db: $db,
            $table: $db.contents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProgressTable> {
  $$ProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContentsTableAnnotationComposer get contentId {
    final $$ContentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentId,
      referencedTable: $db.contents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentsTableAnnotationComposer(
            $db: $db,
            $table: $db.contents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProgressTable,
          ProgressData,
          $$ProgressTableFilterComposer,
          $$ProgressTableOrderingComposer,
          $$ProgressTableAnnotationComposer,
          $$ProgressTableCreateCompanionBuilder,
          $$ProgressTableUpdateCompanionBuilder,
          (ProgressData, $$ProgressTableReferences),
          ProgressData,
          PrefetchHooks Function({bool userId, bool contentId})
        > {
  $$ProgressTableTableManager(_$AppDatabase db, $ProgressTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<int> contentId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> completedAt = const Value.absent(),
              }) => ProgressCompanion(
                id: id,
                userId: userId,
                contentId: contentId,
                status: status,
                completedAt: completedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userId,
                required int contentId,
                required String status,
                Value<String?> completedAt = const Value.absent(),
              }) => ProgressCompanion.insert(
                id: id,
                userId: userId,
                contentId: contentId,
                status: status,
                completedAt: completedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProgressTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false, contentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userId,
                                referencedTable: $$ProgressTableReferences
                                    ._userIdTable(db),
                                referencedColumn: $$ProgressTableReferences
                                    ._userIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (contentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.contentId,
                                referencedTable: $$ProgressTableReferences
                                    ._contentIdTable(db),
                                referencedColumn: $$ProgressTableReferences
                                    ._contentIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProgressTable,
      ProgressData,
      $$ProgressTableFilterComposer,
      $$ProgressTableOrderingComposer,
      $$ProgressTableAnnotationComposer,
      $$ProgressTableCreateCompanionBuilder,
      $$ProgressTableUpdateCompanionBuilder,
      (ProgressData, $$ProgressTableReferences),
      ProgressData,
      PrefetchHooks Function({bool userId, bool contentId})
    >;
typedef $$ContentActivityDetailsTableCreateCompanionBuilder =
    ContentActivityDetailsCompanion Function({
      Value<int> contentId,
      required String subjectLabel,
      required String activityLabel,
      required String ctaLabel,
      required String difficulty,
      required int questionCount,
      required int estimatedMinutes,
      required String learningGoals,
    });
typedef $$ContentActivityDetailsTableUpdateCompanionBuilder =
    ContentActivityDetailsCompanion Function({
      Value<int> contentId,
      Value<String> subjectLabel,
      Value<String> activityLabel,
      Value<String> ctaLabel,
      Value<String> difficulty,
      Value<int> questionCount,
      Value<int> estimatedMinutes,
      Value<String> learningGoals,
    });

final class $$ContentActivityDetailsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ContentActivityDetailsTable,
          ContentActivityDetail
        > {
  $$ContentActivityDetailsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ContentsTable _contentIdTable(_$AppDatabase db) =>
      db.contents.createAlias(
        $_aliasNameGenerator(
          db.contentActivityDetails.contentId,
          db.contents.id,
        ),
      );

  $$ContentsTableProcessedTableManager get contentId {
    final $_column = $_itemColumn<int>('content_id')!;

    final manager = $$ContentsTableTableManager(
      $_db,
      $_db.contents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_contentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ContentActivityDetailsTableFilterComposer
    extends Composer<_$AppDatabase, $ContentActivityDetailsTable> {
  $$ContentActivityDetailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get subjectLabel => $composableBuilder(
    column: $table.subjectLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activityLabel => $composableBuilder(
    column: $table.activityLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ctaLabel => $composableBuilder(
    column: $table.ctaLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get questionCount => $composableBuilder(
    column: $table.questionCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get learningGoals => $composableBuilder(
    column: $table.learningGoals,
    builder: (column) => ColumnFilters(column),
  );

  $$ContentsTableFilterComposer get contentId {
    final $$ContentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentId,
      referencedTable: $db.contents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentsTableFilterComposer(
            $db: $db,
            $table: $db.contents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContentActivityDetailsTableOrderingComposer
    extends Composer<_$AppDatabase, $ContentActivityDetailsTable> {
  $$ContentActivityDetailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get subjectLabel => $composableBuilder(
    column: $table.subjectLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activityLabel => $composableBuilder(
    column: $table.activityLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ctaLabel => $composableBuilder(
    column: $table.ctaLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get questionCount => $composableBuilder(
    column: $table.questionCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get learningGoals => $composableBuilder(
    column: $table.learningGoals,
    builder: (column) => ColumnOrderings(column),
  );

  $$ContentsTableOrderingComposer get contentId {
    final $$ContentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentId,
      referencedTable: $db.contents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentsTableOrderingComposer(
            $db: $db,
            $table: $db.contents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContentActivityDetailsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContentActivityDetailsTable> {
  $$ContentActivityDetailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get subjectLabel => $composableBuilder(
    column: $table.subjectLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get activityLabel => $composableBuilder(
    column: $table.activityLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ctaLabel =>
      $composableBuilder(column: $table.ctaLabel, builder: (column) => column);

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<int> get questionCount => $composableBuilder(
    column: $table.questionCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get learningGoals => $composableBuilder(
    column: $table.learningGoals,
    builder: (column) => column,
  );

  $$ContentsTableAnnotationComposer get contentId {
    final $$ContentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentId,
      referencedTable: $db.contents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentsTableAnnotationComposer(
            $db: $db,
            $table: $db.contents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContentActivityDetailsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContentActivityDetailsTable,
          ContentActivityDetail,
          $$ContentActivityDetailsTableFilterComposer,
          $$ContentActivityDetailsTableOrderingComposer,
          $$ContentActivityDetailsTableAnnotationComposer,
          $$ContentActivityDetailsTableCreateCompanionBuilder,
          $$ContentActivityDetailsTableUpdateCompanionBuilder,
          (ContentActivityDetail, $$ContentActivityDetailsTableReferences),
          ContentActivityDetail,
          PrefetchHooks Function({bool contentId})
        > {
  $$ContentActivityDetailsTableTableManager(
    _$AppDatabase db,
    $ContentActivityDetailsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContentActivityDetailsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ContentActivityDetailsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ContentActivityDetailsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> contentId = const Value.absent(),
                Value<String> subjectLabel = const Value.absent(),
                Value<String> activityLabel = const Value.absent(),
                Value<String> ctaLabel = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                Value<int> questionCount = const Value.absent(),
                Value<int> estimatedMinutes = const Value.absent(),
                Value<String> learningGoals = const Value.absent(),
              }) => ContentActivityDetailsCompanion(
                contentId: contentId,
                subjectLabel: subjectLabel,
                activityLabel: activityLabel,
                ctaLabel: ctaLabel,
                difficulty: difficulty,
                questionCount: questionCount,
                estimatedMinutes: estimatedMinutes,
                learningGoals: learningGoals,
              ),
          createCompanionCallback:
              ({
                Value<int> contentId = const Value.absent(),
                required String subjectLabel,
                required String activityLabel,
                required String ctaLabel,
                required String difficulty,
                required int questionCount,
                required int estimatedMinutes,
                required String learningGoals,
              }) => ContentActivityDetailsCompanion.insert(
                contentId: contentId,
                subjectLabel: subjectLabel,
                activityLabel: activityLabel,
                ctaLabel: ctaLabel,
                difficulty: difficulty,
                questionCount: questionCount,
                estimatedMinutes: estimatedMinutes,
                learningGoals: learningGoals,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ContentActivityDetailsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({contentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (contentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.contentId,
                                referencedTable:
                                    $$ContentActivityDetailsTableReferences
                                        ._contentIdTable(db),
                                referencedColumn:
                                    $$ContentActivityDetailsTableReferences
                                        ._contentIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ContentActivityDetailsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContentActivityDetailsTable,
      ContentActivityDetail,
      $$ContentActivityDetailsTableFilterComposer,
      $$ContentActivityDetailsTableOrderingComposer,
      $$ContentActivityDetailsTableAnnotationComposer,
      $$ContentActivityDetailsTableCreateCompanionBuilder,
      $$ContentActivityDetailsTableUpdateCompanionBuilder,
      (ContentActivityDetail, $$ContentActivityDetailsTableReferences),
      ContentActivityDetail,
      PrefetchHooks Function({bool contentId})
    >;
typedef $$ContentQuestionsTableCreateCompanionBuilder =
    ContentQuestionsCompanion Function({
      Value<int> id,
      required int contentId,
      required int sortOrder,
      required String typeLabel,
      required String prompt,
      required String optionsText,
      required int correctIndex,
    });
typedef $$ContentQuestionsTableUpdateCompanionBuilder =
    ContentQuestionsCompanion Function({
      Value<int> id,
      Value<int> contentId,
      Value<int> sortOrder,
      Value<String> typeLabel,
      Value<String> prompt,
      Value<String> optionsText,
      Value<int> correctIndex,
    });

final class $$ContentQuestionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $ContentQuestionsTable, ContentQuestion> {
  $$ContentQuestionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ContentsTable _contentIdTable(_$AppDatabase db) =>
      db.contents.createAlias(
        $_aliasNameGenerator(db.contentQuestions.contentId, db.contents.id),
      );

  $$ContentsTableProcessedTableManager get contentId {
    final $_column = $_itemColumn<int>('content_id')!;

    final manager = $$ContentsTableTableManager(
      $_db,
      $_db.contents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_contentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ContentQuestionsTableFilterComposer
    extends Composer<_$AppDatabase, $ContentQuestionsTable> {
  $$ContentQuestionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get typeLabel => $composableBuilder(
    column: $table.typeLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prompt => $composableBuilder(
    column: $table.prompt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get optionsText => $composableBuilder(
    column: $table.optionsText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctIndex => $composableBuilder(
    column: $table.correctIndex,
    builder: (column) => ColumnFilters(column),
  );

  $$ContentsTableFilterComposer get contentId {
    final $$ContentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentId,
      referencedTable: $db.contents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentsTableFilterComposer(
            $db: $db,
            $table: $db.contents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContentQuestionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ContentQuestionsTable> {
  $$ContentQuestionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get typeLabel => $composableBuilder(
    column: $table.typeLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prompt => $composableBuilder(
    column: $table.prompt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get optionsText => $composableBuilder(
    column: $table.optionsText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctIndex => $composableBuilder(
    column: $table.correctIndex,
    builder: (column) => ColumnOrderings(column),
  );

  $$ContentsTableOrderingComposer get contentId {
    final $$ContentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentId,
      referencedTable: $db.contents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentsTableOrderingComposer(
            $db: $db,
            $table: $db.contents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContentQuestionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContentQuestionsTable> {
  $$ContentQuestionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get typeLabel =>
      $composableBuilder(column: $table.typeLabel, builder: (column) => column);

  GeneratedColumn<String> get prompt =>
      $composableBuilder(column: $table.prompt, builder: (column) => column);

  GeneratedColumn<String> get optionsText => $composableBuilder(
    column: $table.optionsText,
    builder: (column) => column,
  );

  GeneratedColumn<int> get correctIndex => $composableBuilder(
    column: $table.correctIndex,
    builder: (column) => column,
  );

  $$ContentsTableAnnotationComposer get contentId {
    final $$ContentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentId,
      referencedTable: $db.contents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentsTableAnnotationComposer(
            $db: $db,
            $table: $db.contents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContentQuestionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContentQuestionsTable,
          ContentQuestion,
          $$ContentQuestionsTableFilterComposer,
          $$ContentQuestionsTableOrderingComposer,
          $$ContentQuestionsTableAnnotationComposer,
          $$ContentQuestionsTableCreateCompanionBuilder,
          $$ContentQuestionsTableUpdateCompanionBuilder,
          (ContentQuestion, $$ContentQuestionsTableReferences),
          ContentQuestion,
          PrefetchHooks Function({bool contentId})
        > {
  $$ContentQuestionsTableTableManager(
    _$AppDatabase db,
    $ContentQuestionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContentQuestionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContentQuestionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContentQuestionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> contentId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String> typeLabel = const Value.absent(),
                Value<String> prompt = const Value.absent(),
                Value<String> optionsText = const Value.absent(),
                Value<int> correctIndex = const Value.absent(),
              }) => ContentQuestionsCompanion(
                id: id,
                contentId: contentId,
                sortOrder: sortOrder,
                typeLabel: typeLabel,
                prompt: prompt,
                optionsText: optionsText,
                correctIndex: correctIndex,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int contentId,
                required int sortOrder,
                required String typeLabel,
                required String prompt,
                required String optionsText,
                required int correctIndex,
              }) => ContentQuestionsCompanion.insert(
                id: id,
                contentId: contentId,
                sortOrder: sortOrder,
                typeLabel: typeLabel,
                prompt: prompt,
                optionsText: optionsText,
                correctIndex: correctIndex,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ContentQuestionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({contentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (contentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.contentId,
                                referencedTable:
                                    $$ContentQuestionsTableReferences
                                        ._contentIdTable(db),
                                referencedColumn:
                                    $$ContentQuestionsTableReferences
                                        ._contentIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ContentQuestionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContentQuestionsTable,
      ContentQuestion,
      $$ContentQuestionsTableFilterComposer,
      $$ContentQuestionsTableOrderingComposer,
      $$ContentQuestionsTableAnnotationComposer,
      $$ContentQuestionsTableCreateCompanionBuilder,
      $$ContentQuestionsTableUpdateCompanionBuilder,
      (ContentQuestion, $$ContentQuestionsTableReferences),
      ContentQuestion,
      PrefetchHooks Function({bool contentId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$ContentsTableTableManager get contents =>
      $$ContentsTableTableManager(_db, _db.contents);
  $$NewsTableTableManager get news => $$NewsTableTableManager(_db, _db.news);
  $$ProgressTableTableManager get progress =>
      $$ProgressTableTableManager(_db, _db.progress);
  $$ContentActivityDetailsTableTableManager get contentActivityDetails =>
      $$ContentActivityDetailsTableTableManager(
        _db,
        _db.contentActivityDetails,
      );
  $$ContentQuestionsTableTableManager get contentQuestions =>
      $$ContentQuestionsTableTableManager(_db, _db.contentQuestions);
}
