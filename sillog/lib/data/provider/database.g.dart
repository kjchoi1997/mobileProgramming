// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class UserFileData extends DataClass implements Insertable<UserFileData> {
  final int id;
  final String title;
  final String beforePath;
  final String appPath;
  final String category;
  final String extension;
  final int size;
  final String linkedSillog;
  final DateTime createdAt;
  UserFileData(
      {required this.id,
      required this.title,
      required this.beforePath,
      required this.appPath,
      required this.category,
      required this.extension,
      required this.size,
      required this.linkedSillog,
      required this.createdAt});
  factory UserFileData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return UserFileData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      beforePath: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}before_path'])!,
      appPath: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}app_path'])!,
      category: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category'])!,
      extension: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}extension'])!,
      size: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}size'])!,
      linkedSillog: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}linked_sillog'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['before_path'] = Variable<String>(beforePath);
    map['app_path'] = Variable<String>(appPath);
    map['category'] = Variable<String>(category);
    map['extension'] = Variable<String>(extension);
    map['size'] = Variable<int>(size);
    map['linked_sillog'] = Variable<String>(linkedSillog);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UserFileCompanion toCompanion(bool nullToAbsent) {
    return UserFileCompanion(
      id: Value(id),
      title: Value(title),
      beforePath: Value(beforePath),
      appPath: Value(appPath),
      category: Value(category),
      extension: Value(extension),
      size: Value(size),
      linkedSillog: Value(linkedSillog),
      createdAt: Value(createdAt),
    );
  }

  factory UserFileData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return UserFileData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      beforePath: serializer.fromJson<String>(json['beforePath']),
      appPath: serializer.fromJson<String>(json['appPath']),
      category: serializer.fromJson<String>(json['category']),
      extension: serializer.fromJson<String>(json['extension']),
      size: serializer.fromJson<int>(json['size']),
      linkedSillog: serializer.fromJson<String>(json['linkedSillog']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'beforePath': serializer.toJson<String>(beforePath),
      'appPath': serializer.toJson<String>(appPath),
      'category': serializer.toJson<String>(category),
      'extension': serializer.toJson<String>(extension),
      'size': serializer.toJson<int>(size),
      'linkedSillog': serializer.toJson<String>(linkedSillog),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UserFileData copyWith(
          {int? id,
          String? title,
          String? beforePath,
          String? appPath,
          String? category,
          String? extension,
          int? size,
          String? linkedSillog,
          DateTime? createdAt}) =>
      UserFileData(
        id: id ?? this.id,
        title: title ?? this.title,
        beforePath: beforePath ?? this.beforePath,
        appPath: appPath ?? this.appPath,
        category: category ?? this.category,
        extension: extension ?? this.extension,
        size: size ?? this.size,
        linkedSillog: linkedSillog ?? this.linkedSillog,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('UserFileData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('beforePath: $beforePath, ')
          ..write('appPath: $appPath, ')
          ..write('category: $category, ')
          ..write('extension: $extension, ')
          ..write('size: $size, ')
          ..write('linkedSillog: $linkedSillog, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, beforePath, appPath, category,
      extension, size, linkedSillog, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserFileData &&
          other.id == this.id &&
          other.title == this.title &&
          other.beforePath == this.beforePath &&
          other.appPath == this.appPath &&
          other.category == this.category &&
          other.extension == this.extension &&
          other.size == this.size &&
          other.linkedSillog == this.linkedSillog &&
          other.createdAt == this.createdAt);
}

class UserFileCompanion extends UpdateCompanion<UserFileData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> beforePath;
  final Value<String> appPath;
  final Value<String> category;
  final Value<String> extension;
  final Value<int> size;
  final Value<String> linkedSillog;
  final Value<DateTime> createdAt;
  const UserFileCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.beforePath = const Value.absent(),
    this.appPath = const Value.absent(),
    this.category = const Value.absent(),
    this.extension = const Value.absent(),
    this.size = const Value.absent(),
    this.linkedSillog = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UserFileCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String beforePath,
    required String appPath,
    required String category,
    required String extension,
    required int size,
    required String linkedSillog,
    this.createdAt = const Value.absent(),
  })  : title = Value(title),
        beforePath = Value(beforePath),
        appPath = Value(appPath),
        category = Value(category),
        extension = Value(extension),
        size = Value(size),
        linkedSillog = Value(linkedSillog);
  static Insertable<UserFileData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? beforePath,
    Expression<String>? appPath,
    Expression<String>? category,
    Expression<String>? extension,
    Expression<int>? size,
    Expression<String>? linkedSillog,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (beforePath != null) 'before_path': beforePath,
      if (appPath != null) 'app_path': appPath,
      if (category != null) 'category': category,
      if (extension != null) 'extension': extension,
      if (size != null) 'size': size,
      if (linkedSillog != null) 'linked_sillog': linkedSillog,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UserFileCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? beforePath,
      Value<String>? appPath,
      Value<String>? category,
      Value<String>? extension,
      Value<int>? size,
      Value<String>? linkedSillog,
      Value<DateTime>? createdAt}) {
    return UserFileCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      beforePath: beforePath ?? this.beforePath,
      appPath: appPath ?? this.appPath,
      category: category ?? this.category,
      extension: extension ?? this.extension,
      size: size ?? this.size,
      linkedSillog: linkedSillog ?? this.linkedSillog,
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
    if (beforePath.present) {
      map['before_path'] = Variable<String>(beforePath.value);
    }
    if (appPath.present) {
      map['app_path'] = Variable<String>(appPath.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (extension.present) {
      map['extension'] = Variable<String>(extension.value);
    }
    if (size.present) {
      map['size'] = Variable<int>(size.value);
    }
    if (linkedSillog.present) {
      map['linked_sillog'] = Variable<String>(linkedSillog.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserFileCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('beforePath: $beforePath, ')
          ..write('appPath: $appPath, ')
          ..write('category: $category, ')
          ..write('extension: $extension, ')
          ..write('size: $size, ')
          ..write('linkedSillog: $linkedSillog, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $UserFileTable extends UserFile
    with TableInfo<$UserFileTable, UserFileData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $UserFileTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _beforePathMeta = const VerificationMeta('beforePath');
  late final GeneratedColumn<String?> beforePath = GeneratedColumn<String?>(
      'before_path', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _appPathMeta = const VerificationMeta('appPath');
  late final GeneratedColumn<String?> appPath = GeneratedColumn<String?>(
      'app_path', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  late final GeneratedColumn<String?> category = GeneratedColumn<String?>(
      'category', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 10),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _extensionMeta = const VerificationMeta('extension');
  late final GeneratedColumn<String?> extension = GeneratedColumn<String?>(
      'extension', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 10),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _sizeMeta = const VerificationMeta('size');
  late final GeneratedColumn<int?> size = GeneratedColumn<int?>(
      'size', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _linkedSillogMeta =
      const VerificationMeta('linkedSillog');
  late final GeneratedColumn<String?> linkedSillog = GeneratedColumn<String?>(
      'linked_sillog', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        beforePath,
        appPath,
        category,
        extension,
        size,
        linkedSillog,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? 'user_file';
  @override
  String get actualTableName => 'user_file';
  @override
  VerificationContext validateIntegrity(Insertable<UserFileData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('before_path')) {
      context.handle(
          _beforePathMeta,
          beforePath.isAcceptableOrUnknown(
              data['before_path']!, _beforePathMeta));
    } else if (isInserting) {
      context.missing(_beforePathMeta);
    }
    if (data.containsKey('app_path')) {
      context.handle(_appPathMeta,
          appPath.isAcceptableOrUnknown(data['app_path']!, _appPathMeta));
    } else if (isInserting) {
      context.missing(_appPathMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('extension')) {
      context.handle(_extensionMeta,
          extension.isAcceptableOrUnknown(data['extension']!, _extensionMeta));
    } else if (isInserting) {
      context.missing(_extensionMeta);
    }
    if (data.containsKey('size')) {
      context.handle(
          _sizeMeta, size.isAcceptableOrUnknown(data['size']!, _sizeMeta));
    } else if (isInserting) {
      context.missing(_sizeMeta);
    }
    if (data.containsKey('linked_sillog')) {
      context.handle(
          _linkedSillogMeta,
          linkedSillog.isAcceptableOrUnknown(
              data['linked_sillog']!, _linkedSillogMeta));
    } else if (isInserting) {
      context.missing(_linkedSillogMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserFileData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return UserFileData.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UserFileTable createAlias(String alias) {
    return $UserFileTable(_db, alias);
  }
}

class MyTagData extends DataClass implements Insertable<MyTagData> {
  final int id;
  final String category;
  final String tagname;
  MyTagData({required this.id, required this.category, required this.tagname});
  factory MyTagData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return MyTagData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      category: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category'])!,
      tagname: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}tagname'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category'] = Variable<String>(category);
    map['tagname'] = Variable<String>(tagname);
    return map;
  }

  MyTagCompanion toCompanion(bool nullToAbsent) {
    return MyTagCompanion(
      id: Value(id),
      category: Value(category),
      tagname: Value(tagname),
    );
  }

  factory MyTagData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MyTagData(
      id: serializer.fromJson<int>(json['id']),
      category: serializer.fromJson<String>(json['category']),
      tagname: serializer.fromJson<String>(json['tagname']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category': serializer.toJson<String>(category),
      'tagname': serializer.toJson<String>(tagname),
    };
  }

  MyTagData copyWith({int? id, String? category, String? tagname}) => MyTagData(
        id: id ?? this.id,
        category: category ?? this.category,
        tagname: tagname ?? this.tagname,
      );
  @override
  String toString() {
    return (StringBuffer('MyTagData(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('tagname: $tagname')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, category, tagname);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MyTagData &&
          other.id == this.id &&
          other.category == this.category &&
          other.tagname == this.tagname);
}

class MyTagCompanion extends UpdateCompanion<MyTagData> {
  final Value<int> id;
  final Value<String> category;
  final Value<String> tagname;
  const MyTagCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.tagname = const Value.absent(),
  });
  MyTagCompanion.insert({
    this.id = const Value.absent(),
    required String category,
    required String tagname,
  })  : category = Value(category),
        tagname = Value(tagname);
  static Insertable<MyTagData> custom({
    Expression<int>? id,
    Expression<String>? category,
    Expression<String>? tagname,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (tagname != null) 'tagname': tagname,
    });
  }

  MyTagCompanion copyWith(
      {Value<int>? id, Value<String>? category, Value<String>? tagname}) {
    return MyTagCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      tagname: tagname ?? this.tagname,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (tagname.present) {
      map['tagname'] = Variable<String>(tagname.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MyTagCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('tagname: $tagname')
          ..write(')'))
        .toString();
  }
}

class $MyTagTable extends MyTag with TableInfo<$MyTagTable, MyTagData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $MyTagTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  late final GeneratedColumn<String?> category = GeneratedColumn<String?>(
      'category', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 6),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _tagnameMeta = const VerificationMeta('tagname');
  late final GeneratedColumn<String?> tagname = GeneratedColumn<String?>(
      'tagname', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 10),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, category, tagname];
  @override
  String get aliasedName => _alias ?? 'my_tag';
  @override
  String get actualTableName => 'my_tag';
  @override
  VerificationContext validateIntegrity(Insertable<MyTagData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('tagname')) {
      context.handle(_tagnameMeta,
          tagname.isAcceptableOrUnknown(data['tagname']!, _tagnameMeta));
    } else if (isInserting) {
      context.missing(_tagnameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MyTagData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return MyTagData.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $MyTagTable createAlias(String alias) {
    return $MyTagTable(_db, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $UserFileTable userFile = $UserFileTable(this);
  late final $MyTagTable myTag = $MyTagTable(this);
  late final UserFileDao userFileDao = UserFileDao(this as Database);
  late final MyTagDao myTagDao = MyTagDao(this as Database);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [userFile, myTag];
}
