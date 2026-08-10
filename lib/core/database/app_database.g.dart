// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $WorkOrdersTableTable extends WorkOrdersTable
    with TableInfo<$WorkOrdersTableTable, WorkOrdersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkOrdersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scheduledAtMeta = const VerificationMeta(
    'scheduledAt',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledAt = GeneratedColumn<DateTime>(
    'scheduled_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    title,
    description,
    notes,
    address,
    priority,
    status,
    latitude,
    longitude,
    scheduledAt,
    createdAt,
    updatedAt,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'work_orders_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkOrdersTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
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
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('scheduled_at')) {
      context.handle(
        _scheduledAtMeta,
        scheduledAt.isAcceptableOrUnknown(
          data['scheduled_at']!,
          _scheduledAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkOrdersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkOrdersTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priority'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      scheduledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $WorkOrdersTableTable createAlias(String alias) {
    return $WorkOrdersTableTable(attachedDatabase, alias);
  }
}

class WorkOrdersTableData extends DataClass
    implements Insertable<WorkOrdersTableData> {
  final String id;
  final String code;
  final String title;
  final String? description;
  final String? notes;
  final String address;
  final String priority;
  final String status;
  final double? latitude;
  final double? longitude;
  final DateTime? scheduledAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime cachedAt;
  const WorkOrdersTableData({
    required this.id,
    required this.code,
    required this.title,
    this.description,
    this.notes,
    required this.address,
    required this.priority,
    required this.status,
    this.latitude,
    this.longitude,
    this.scheduledAt,
    required this.createdAt,
    required this.updatedAt,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['code'] = Variable<String>(code);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['address'] = Variable<String>(address);
    map['priority'] = Variable<String>(priority);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || scheduledAt != null) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  WorkOrdersTableCompanion toCompanion(bool nullToAbsent) {
    return WorkOrdersTableCompanion(
      id: Value(id),
      code: Value(code),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      address: Value(address),
      priority: Value(priority),
      status: Value(status),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      scheduledAt: scheduledAt == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduledAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      cachedAt: Value(cachedAt),
    );
  }

  factory WorkOrdersTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkOrdersTableData(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      notes: serializer.fromJson<String?>(json['notes']),
      address: serializer.fromJson<String>(json['address']),
      priority: serializer.fromJson<String>(json['priority']),
      status: serializer.fromJson<String>(json['status']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      scheduledAt: serializer.fromJson<DateTime?>(json['scheduledAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'notes': serializer.toJson<String?>(notes),
      'address': serializer.toJson<String>(address),
      'priority': serializer.toJson<String>(priority),
      'status': serializer.toJson<String>(status),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'scheduledAt': serializer.toJson<DateTime?>(scheduledAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  WorkOrdersTableData copyWith({
    String? id,
    String? code,
    String? title,
    Value<String?> description = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    String? address,
    String? priority,
    String? status,
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<DateTime?> scheduledAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? cachedAt,
  }) => WorkOrdersTableData(
    id: id ?? this.id,
    code: code ?? this.code,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    notes: notes.present ? notes.value : this.notes,
    address: address ?? this.address,
    priority: priority ?? this.priority,
    status: status ?? this.status,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    scheduledAt: scheduledAt.present ? scheduledAt.value : this.scheduledAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  WorkOrdersTableData copyWithCompanion(WorkOrdersTableCompanion data) {
    return WorkOrdersTableData(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      notes: data.notes.present ? data.notes.value : this.notes,
      address: data.address.present ? data.address.value : this.address,
      priority: data.priority.present ? data.priority.value : this.priority,
      status: data.status.present ? data.status.value : this.status,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      scheduledAt: data.scheduledAt.present
          ? data.scheduledAt.value
          : this.scheduledAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkOrdersTableData(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('notes: $notes, ')
          ..write('address: $address, ')
          ..write('priority: $priority, ')
          ..write('status: $status, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    title,
    description,
    notes,
    address,
    priority,
    status,
    latitude,
    longitude,
    scheduledAt,
    createdAt,
    updatedAt,
    cachedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkOrdersTableData &&
          other.id == this.id &&
          other.code == this.code &&
          other.title == this.title &&
          other.description == this.description &&
          other.notes == this.notes &&
          other.address == this.address &&
          other.priority == this.priority &&
          other.status == this.status &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.scheduledAt == this.scheduledAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.cachedAt == this.cachedAt);
}

class WorkOrdersTableCompanion extends UpdateCompanion<WorkOrdersTableData> {
  final Value<String> id;
  final Value<String> code;
  final Value<String> title;
  final Value<String?> description;
  final Value<String?> notes;
  final Value<String> address;
  final Value<String> priority;
  final Value<String> status;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<DateTime?> scheduledAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const WorkOrdersTableCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.notes = const Value.absent(),
    this.address = const Value.absent(),
    this.priority = const Value.absent(),
    this.status = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkOrdersTableCompanion.insert({
    required String id,
    required String code,
    required String title,
    this.description = const Value.absent(),
    this.notes = const Value.absent(),
    required String address,
    required String priority,
    required String status,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       code = Value(code),
       title = Value(title),
       address = Value(address),
       priority = Value(priority),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       cachedAt = Value(cachedAt);
  static Insertable<WorkOrdersTableData> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? notes,
    Expression<String>? address,
    Expression<String>? priority,
    Expression<String>? status,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<DateTime>? scheduledAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (notes != null) 'notes': notes,
      if (address != null) 'address': address,
      if (priority != null) 'priority': priority,
      if (status != null) 'status': status,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (scheduledAt != null) 'scheduled_at': scheduledAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkOrdersTableCompanion copyWith({
    Value<String>? id,
    Value<String>? code,
    Value<String>? title,
    Value<String?>? description,
    Value<String?>? notes,
    Value<String>? address,
    Value<String>? priority,
    Value<String>? status,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<DateTime?>? scheduledAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return WorkOrdersTableCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      title: title ?? this.title,
      description: description ?? this.description,
      notes: notes ?? this.notes,
      address: address ?? this.address,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (scheduledAt.present) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkOrdersTableCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('notes: $notes, ')
          ..write('address: $address, ')
          ..write('priority: $priority, ')
          ..write('status: $status, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InspectionsTableTable extends InspectionsTable
    with TableInfo<$InspectionsTableTable, InspectionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InspectionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _workOrderIdMeta = const VerificationMeta(
    'workOrderId',
  );
  @override
  late final GeneratedColumn<String> workOrderId = GeneratedColumn<String>(
    'work_order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workOrderCodeMeta = const VerificationMeta(
    'workOrderCode',
  );
  @override
  late final GeneratedColumn<String> workOrderCode = GeneratedColumn<String>(
    'work_order_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _workOrderLatitudeMeta = const VerificationMeta(
    'workOrderLatitude',
  );
  @override
  late final GeneratedColumn<double> workOrderLatitude =
      GeneratedColumn<double>(
        'work_order_latitude',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _workOrderLongitudeMeta =
      const VerificationMeta('workOrderLongitude');
  @override
  late final GeneratedColumn<double> workOrderLongitude =
      GeneratedColumn<double>(
        'work_order_longitude',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
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
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _capturedAtMeta = const VerificationMeta(
    'capturedAt',
  );
  @override
  late final GeneratedColumn<DateTime> capturedAt = GeneratedColumn<DateTime>(
    'captured_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _formDataJsonMeta = const VerificationMeta(
    'formDataJson',
  );
  @override
  late final GeneratedColumn<String> formDataJson = GeneratedColumn<String>(
    'form_data_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _formSchemaJsonMeta = const VerificationMeta(
    'formSchemaJson',
  );
  @override
  late final GeneratedColumn<String> formSchemaJson = GeneratedColumn<String>(
    'form_schema_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncErrorMessageMeta = const VerificationMeta(
    'syncErrorMessage',
  );
  @override
  late final GeneratedColumn<String> syncErrorMessage = GeneratedColumn<String>(
    'sync_error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    clientId,
    serverId,
    workOrderId,
    workOrderCode,
    workOrderLatitude,
    workOrderLongitude,
    status,
    notes,
    photoPath,
    latitude,
    longitude,
    capturedAt,
    formDataJson,
    formSchemaJson,
    syncErrorMessage,
    createdAt,
    updatedAt,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inspections_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<InspectionsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('work_order_id')) {
      context.handle(
        _workOrderIdMeta,
        workOrderId.isAcceptableOrUnknown(
          data['work_order_id']!,
          _workOrderIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workOrderIdMeta);
    }
    if (data.containsKey('work_order_code')) {
      context.handle(
        _workOrderCodeMeta,
        workOrderCode.isAcceptableOrUnknown(
          data['work_order_code']!,
          _workOrderCodeMeta,
        ),
      );
    }
    if (data.containsKey('work_order_latitude')) {
      context.handle(
        _workOrderLatitudeMeta,
        workOrderLatitude.isAcceptableOrUnknown(
          data['work_order_latitude']!,
          _workOrderLatitudeMeta,
        ),
      );
    }
    if (data.containsKey('work_order_longitude')) {
      context.handle(
        _workOrderLongitudeMeta,
        workOrderLongitude.isAcceptableOrUnknown(
          data['work_order_longitude']!,
          _workOrderLongitudeMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('captured_at')) {
      context.handle(
        _capturedAtMeta,
        capturedAt.isAcceptableOrUnknown(data['captured_at']!, _capturedAtMeta),
      );
    }
    if (data.containsKey('form_data_json')) {
      context.handle(
        _formDataJsonMeta,
        formDataJson.isAcceptableOrUnknown(
          data['form_data_json']!,
          _formDataJsonMeta,
        ),
      );
    }
    if (data.containsKey('form_schema_json')) {
      context.handle(
        _formSchemaJsonMeta,
        formSchemaJson.isAcceptableOrUnknown(
          data['form_schema_json']!,
          _formSchemaJsonMeta,
        ),
      );
    }
    if (data.containsKey('sync_error_message')) {
      context.handle(
        _syncErrorMessageMeta,
        syncErrorMessage.isAcceptableOrUnknown(
          data['sync_error_message']!,
          _syncErrorMessageMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {clientId};
  @override
  InspectionsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InspectionsTableData(
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      ),
      workOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}work_order_id'],
      )!,
      workOrderCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}work_order_code'],
      ),
      workOrderLatitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}work_order_latitude'],
      ),
      workOrderLongitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}work_order_longitude'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      capturedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}captured_at'],
      ),
      formDataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}form_data_json'],
      ),
      formSchemaJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}form_schema_json'],
      ),
      syncErrorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_error_message'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
    );
  }

  @override
  $InspectionsTableTable createAlias(String alias) {
    return $InspectionsTableTable(attachedDatabase, alias);
  }
}

class InspectionsTableData extends DataClass
    implements Insertable<InspectionsTableData> {
  final String clientId;
  final String? serverId;
  final String workOrderId;
  final String? workOrderCode;
  final double? workOrderLatitude;
  final double? workOrderLongitude;
  final String status;
  final String? notes;
  final String? photoPath;
  final double? latitude;
  final double? longitude;
  final DateTime? capturedAt;
  final String? formDataJson;
  final String? formSchemaJson;
  final String? syncErrorMessage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? syncedAt;
  const InspectionsTableData({
    required this.clientId,
    this.serverId,
    required this.workOrderId,
    this.workOrderCode,
    this.workOrderLatitude,
    this.workOrderLongitude,
    required this.status,
    this.notes,
    this.photoPath,
    this.latitude,
    this.longitude,
    this.capturedAt,
    this.formDataJson,
    this.formSchemaJson,
    this.syncErrorMessage,
    required this.createdAt,
    required this.updatedAt,
    this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['client_id'] = Variable<String>(clientId);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<String>(serverId);
    }
    map['work_order_id'] = Variable<String>(workOrderId);
    if (!nullToAbsent || workOrderCode != null) {
      map['work_order_code'] = Variable<String>(workOrderCode);
    }
    if (!nullToAbsent || workOrderLatitude != null) {
      map['work_order_latitude'] = Variable<double>(workOrderLatitude);
    }
    if (!nullToAbsent || workOrderLongitude != null) {
      map['work_order_longitude'] = Variable<double>(workOrderLongitude);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || capturedAt != null) {
      map['captured_at'] = Variable<DateTime>(capturedAt);
    }
    if (!nullToAbsent || formDataJson != null) {
      map['form_data_json'] = Variable<String>(formDataJson);
    }
    if (!nullToAbsent || formSchemaJson != null) {
      map['form_schema_json'] = Variable<String>(formSchemaJson);
    }
    if (!nullToAbsent || syncErrorMessage != null) {
      map['sync_error_message'] = Variable<String>(syncErrorMessage);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    return map;
  }

  InspectionsTableCompanion toCompanion(bool nullToAbsent) {
    return InspectionsTableCompanion(
      clientId: Value(clientId),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      workOrderId: Value(workOrderId),
      workOrderCode: workOrderCode == null && nullToAbsent
          ? const Value.absent()
          : Value(workOrderCode),
      workOrderLatitude: workOrderLatitude == null && nullToAbsent
          ? const Value.absent()
          : Value(workOrderLatitude),
      workOrderLongitude: workOrderLongitude == null && nullToAbsent
          ? const Value.absent()
          : Value(workOrderLongitude),
      status: Value(status),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      capturedAt: capturedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(capturedAt),
      formDataJson: formDataJson == null && nullToAbsent
          ? const Value.absent()
          : Value(formDataJson),
      formSchemaJson: formSchemaJson == null && nullToAbsent
          ? const Value.absent()
          : Value(formSchemaJson),
      syncErrorMessage: syncErrorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(syncErrorMessage),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory InspectionsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InspectionsTableData(
      clientId: serializer.fromJson<String>(json['clientId']),
      serverId: serializer.fromJson<String?>(json['serverId']),
      workOrderId: serializer.fromJson<String>(json['workOrderId']),
      workOrderCode: serializer.fromJson<String?>(json['workOrderCode']),
      workOrderLatitude: serializer.fromJson<double?>(
        json['workOrderLatitude'],
      ),
      workOrderLongitude: serializer.fromJson<double?>(
        json['workOrderLongitude'],
      ),
      status: serializer.fromJson<String>(json['status']),
      notes: serializer.fromJson<String?>(json['notes']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      capturedAt: serializer.fromJson<DateTime?>(json['capturedAt']),
      formDataJson: serializer.fromJson<String?>(json['formDataJson']),
      formSchemaJson: serializer.fromJson<String?>(json['formSchemaJson']),
      syncErrorMessage: serializer.fromJson<String?>(json['syncErrorMessage']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clientId': serializer.toJson<String>(clientId),
      'serverId': serializer.toJson<String?>(serverId),
      'workOrderId': serializer.toJson<String>(workOrderId),
      'workOrderCode': serializer.toJson<String?>(workOrderCode),
      'workOrderLatitude': serializer.toJson<double?>(workOrderLatitude),
      'workOrderLongitude': serializer.toJson<double?>(workOrderLongitude),
      'status': serializer.toJson<String>(status),
      'notes': serializer.toJson<String?>(notes),
      'photoPath': serializer.toJson<String?>(photoPath),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'capturedAt': serializer.toJson<DateTime?>(capturedAt),
      'formDataJson': serializer.toJson<String?>(formDataJson),
      'formSchemaJson': serializer.toJson<String?>(formSchemaJson),
      'syncErrorMessage': serializer.toJson<String?>(syncErrorMessage),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
    };
  }

  InspectionsTableData copyWith({
    String? clientId,
    Value<String?> serverId = const Value.absent(),
    String? workOrderId,
    Value<String?> workOrderCode = const Value.absent(),
    Value<double?> workOrderLatitude = const Value.absent(),
    Value<double?> workOrderLongitude = const Value.absent(),
    String? status,
    Value<String?> notes = const Value.absent(),
    Value<String?> photoPath = const Value.absent(),
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<DateTime?> capturedAt = const Value.absent(),
    Value<String?> formDataJson = const Value.absent(),
    Value<String?> formSchemaJson = const Value.absent(),
    Value<String?> syncErrorMessage = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> syncedAt = const Value.absent(),
  }) => InspectionsTableData(
    clientId: clientId ?? this.clientId,
    serverId: serverId.present ? serverId.value : this.serverId,
    workOrderId: workOrderId ?? this.workOrderId,
    workOrderCode: workOrderCode.present
        ? workOrderCode.value
        : this.workOrderCode,
    workOrderLatitude: workOrderLatitude.present
        ? workOrderLatitude.value
        : this.workOrderLatitude,
    workOrderLongitude: workOrderLongitude.present
        ? workOrderLongitude.value
        : this.workOrderLongitude,
    status: status ?? this.status,
    notes: notes.present ? notes.value : this.notes,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    capturedAt: capturedAt.present ? capturedAt.value : this.capturedAt,
    formDataJson: formDataJson.present ? formDataJson.value : this.formDataJson,
    formSchemaJson: formSchemaJson.present
        ? formSchemaJson.value
        : this.formSchemaJson,
    syncErrorMessage: syncErrorMessage.present
        ? syncErrorMessage.value
        : this.syncErrorMessage,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
  );
  InspectionsTableData copyWithCompanion(InspectionsTableCompanion data) {
    return InspectionsTableData(
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      workOrderId: data.workOrderId.present
          ? data.workOrderId.value
          : this.workOrderId,
      workOrderCode: data.workOrderCode.present
          ? data.workOrderCode.value
          : this.workOrderCode,
      workOrderLatitude: data.workOrderLatitude.present
          ? data.workOrderLatitude.value
          : this.workOrderLatitude,
      workOrderLongitude: data.workOrderLongitude.present
          ? data.workOrderLongitude.value
          : this.workOrderLongitude,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      capturedAt: data.capturedAt.present
          ? data.capturedAt.value
          : this.capturedAt,
      formDataJson: data.formDataJson.present
          ? data.formDataJson.value
          : this.formDataJson,
      formSchemaJson: data.formSchemaJson.present
          ? data.formSchemaJson.value
          : this.formSchemaJson,
      syncErrorMessage: data.syncErrorMessage.present
          ? data.syncErrorMessage.value
          : this.syncErrorMessage,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InspectionsTableData(')
          ..write('clientId: $clientId, ')
          ..write('serverId: $serverId, ')
          ..write('workOrderId: $workOrderId, ')
          ..write('workOrderCode: $workOrderCode, ')
          ..write('workOrderLatitude: $workOrderLatitude, ')
          ..write('workOrderLongitude: $workOrderLongitude, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('photoPath: $photoPath, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('capturedAt: $capturedAt, ')
          ..write('formDataJson: $formDataJson, ')
          ..write('formSchemaJson: $formSchemaJson, ')
          ..write('syncErrorMessage: $syncErrorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    clientId,
    serverId,
    workOrderId,
    workOrderCode,
    workOrderLatitude,
    workOrderLongitude,
    status,
    notes,
    photoPath,
    latitude,
    longitude,
    capturedAt,
    formDataJson,
    formSchemaJson,
    syncErrorMessage,
    createdAt,
    updatedAt,
    syncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InspectionsTableData &&
          other.clientId == this.clientId &&
          other.serverId == this.serverId &&
          other.workOrderId == this.workOrderId &&
          other.workOrderCode == this.workOrderCode &&
          other.workOrderLatitude == this.workOrderLatitude &&
          other.workOrderLongitude == this.workOrderLongitude &&
          other.status == this.status &&
          other.notes == this.notes &&
          other.photoPath == this.photoPath &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.capturedAt == this.capturedAt &&
          other.formDataJson == this.formDataJson &&
          other.formSchemaJson == this.formSchemaJson &&
          other.syncErrorMessage == this.syncErrorMessage &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncedAt == this.syncedAt);
}

class InspectionsTableCompanion extends UpdateCompanion<InspectionsTableData> {
  final Value<String> clientId;
  final Value<String?> serverId;
  final Value<String> workOrderId;
  final Value<String?> workOrderCode;
  final Value<double?> workOrderLatitude;
  final Value<double?> workOrderLongitude;
  final Value<String> status;
  final Value<String?> notes;
  final Value<String?> photoPath;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<DateTime?> capturedAt;
  final Value<String?> formDataJson;
  final Value<String?> formSchemaJson;
  final Value<String?> syncErrorMessage;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> syncedAt;
  final Value<int> rowid;
  const InspectionsTableCompanion({
    this.clientId = const Value.absent(),
    this.serverId = const Value.absent(),
    this.workOrderId = const Value.absent(),
    this.workOrderCode = const Value.absent(),
    this.workOrderLatitude = const Value.absent(),
    this.workOrderLongitude = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.capturedAt = const Value.absent(),
    this.formDataJson = const Value.absent(),
    this.formSchemaJson = const Value.absent(),
    this.syncErrorMessage = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InspectionsTableCompanion.insert({
    required String clientId,
    this.serverId = const Value.absent(),
    required String workOrderId,
    this.workOrderCode = const Value.absent(),
    this.workOrderLatitude = const Value.absent(),
    this.workOrderLongitude = const Value.absent(),
    required String status,
    this.notes = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.capturedAt = const Value.absent(),
    this.formDataJson = const Value.absent(),
    this.formSchemaJson = const Value.absent(),
    this.syncErrorMessage = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : clientId = Value(clientId),
       workOrderId = Value(workOrderId),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<InspectionsTableData> custom({
    Expression<String>? clientId,
    Expression<String>? serverId,
    Expression<String>? workOrderId,
    Expression<String>? workOrderCode,
    Expression<double>? workOrderLatitude,
    Expression<double>? workOrderLongitude,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<String>? photoPath,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<DateTime>? capturedAt,
    Expression<String>? formDataJson,
    Expression<String>? formSchemaJson,
    Expression<String>? syncErrorMessage,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (clientId != null) 'client_id': clientId,
      if (serverId != null) 'server_id': serverId,
      if (workOrderId != null) 'work_order_id': workOrderId,
      if (workOrderCode != null) 'work_order_code': workOrderCode,
      if (workOrderLatitude != null) 'work_order_latitude': workOrderLatitude,
      if (workOrderLongitude != null)
        'work_order_longitude': workOrderLongitude,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (photoPath != null) 'photo_path': photoPath,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (capturedAt != null) 'captured_at': capturedAt,
      if (formDataJson != null) 'form_data_json': formDataJson,
      if (formSchemaJson != null) 'form_schema_json': formSchemaJson,
      if (syncErrorMessage != null) 'sync_error_message': syncErrorMessage,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InspectionsTableCompanion copyWith({
    Value<String>? clientId,
    Value<String?>? serverId,
    Value<String>? workOrderId,
    Value<String?>? workOrderCode,
    Value<double?>? workOrderLatitude,
    Value<double?>? workOrderLongitude,
    Value<String>? status,
    Value<String?>? notes,
    Value<String?>? photoPath,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<DateTime?>? capturedAt,
    Value<String?>? formDataJson,
    Value<String?>? formSchemaJson,
    Value<String?>? syncErrorMessage,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? syncedAt,
    Value<int>? rowid,
  }) {
    return InspectionsTableCompanion(
      clientId: clientId ?? this.clientId,
      serverId: serverId ?? this.serverId,
      workOrderId: workOrderId ?? this.workOrderId,
      workOrderCode: workOrderCode ?? this.workOrderCode,
      workOrderLatitude: workOrderLatitude ?? this.workOrderLatitude,
      workOrderLongitude: workOrderLongitude ?? this.workOrderLongitude,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      photoPath: photoPath ?? this.photoPath,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      capturedAt: capturedAt ?? this.capturedAt,
      formDataJson: formDataJson ?? this.formDataJson,
      formSchemaJson: formSchemaJson ?? this.formSchemaJson,
      syncErrorMessage: syncErrorMessage ?? this.syncErrorMessage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (workOrderId.present) {
      map['work_order_id'] = Variable<String>(workOrderId.value);
    }
    if (workOrderCode.present) {
      map['work_order_code'] = Variable<String>(workOrderCode.value);
    }
    if (workOrderLatitude.present) {
      map['work_order_latitude'] = Variable<double>(workOrderLatitude.value);
    }
    if (workOrderLongitude.present) {
      map['work_order_longitude'] = Variable<double>(workOrderLongitude.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (capturedAt.present) {
      map['captured_at'] = Variable<DateTime>(capturedAt.value);
    }
    if (formDataJson.present) {
      map['form_data_json'] = Variable<String>(formDataJson.value);
    }
    if (formSchemaJson.present) {
      map['form_schema_json'] = Variable<String>(formSchemaJson.value);
    }
    if (syncErrorMessage.present) {
      map['sync_error_message'] = Variable<String>(syncErrorMessage.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InspectionsTableCompanion(')
          ..write('clientId: $clientId, ')
          ..write('serverId: $serverId, ')
          ..write('workOrderId: $workOrderId, ')
          ..write('workOrderCode: $workOrderCode, ')
          ..write('workOrderLatitude: $workOrderLatitude, ')
          ..write('workOrderLongitude: $workOrderLongitude, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('photoPath: $photoPath, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('capturedAt: $capturedAt, ')
          ..write('formDataJson: $formDataJson, ')
          ..write('formSchemaJson: $formSchemaJson, ')
          ..write('syncErrorMessage: $syncErrorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTableTable extends SyncQueueTable
    with TableInfo<$SyncQueueTableTable, SyncQueueTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _inspectionClientIdMeta =
      const VerificationMeta('inspectionClientId');
  @override
  late final GeneratedColumn<String> inspectionClientId =
      GeneratedColumn<String>(
        'inspection_client_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
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
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastAttemptAtMeta = const VerificationMeta(
    'lastAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>(
        'last_attempt_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nextRetryAtMeta = const VerificationMeta(
    'nextRetryAt',
  );
  @override
  late final GeneratedColumn<DateTime> nextRetryAt = GeneratedColumn<DateTime>(
    'next_retry_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastErrorMessageMeta = const VerificationMeta(
    'lastErrorMessage',
  );
  @override
  late final GeneratedColumn<String> lastErrorMessage = GeneratedColumn<String>(
    'last_error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    inspectionClientId,
    status,
    retryCount,
    lastAttemptAt,
    nextRetryAt,
    lastErrorMessage,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('inspection_client_id')) {
      context.handle(
        _inspectionClientIdMeta,
        inspectionClientId.isAcceptableOrUnknown(
          data['inspection_client_id']!,
          _inspectionClientIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_inspectionClientIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('last_attempt_at')) {
      context.handle(
        _lastAttemptAtMeta,
        lastAttemptAt.isAcceptableOrUnknown(
          data['last_attempt_at']!,
          _lastAttemptAtMeta,
        ),
      );
    }
    if (data.containsKey('next_retry_at')) {
      context.handle(
        _nextRetryAtMeta,
        nextRetryAt.isAcceptableOrUnknown(
          data['next_retry_at']!,
          _nextRetryAtMeta,
        ),
      );
    }
    if (data.containsKey('last_error_message')) {
      context.handle(
        _lastErrorMessageMeta,
        lastErrorMessage.isAcceptableOrUnknown(
          data['last_error_message']!,
          _lastErrorMessageMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      inspectionClientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}inspection_client_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      lastAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_attempt_at'],
      ),
      nextRetryAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_retry_at'],
      ),
      lastErrorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error_message'],
      ),
    );
  }

  @override
  $SyncQueueTableTable createAlias(String alias) {
    return $SyncQueueTableTable(attachedDatabase, alias);
  }
}

class SyncQueueTableData extends DataClass
    implements Insertable<SyncQueueTableData> {
  final int id;
  final String inspectionClientId;
  final String status;
  final int retryCount;
  final DateTime? lastAttemptAt;
  final DateTime? nextRetryAt;
  final String? lastErrorMessage;
  const SyncQueueTableData({
    required this.id,
    required this.inspectionClientId,
    required this.status,
    required this.retryCount,
    this.lastAttemptAt,
    this.nextRetryAt,
    this.lastErrorMessage,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['inspection_client_id'] = Variable<String>(inspectionClientId);
    map['status'] = Variable<String>(status);
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt);
    }
    if (!nullToAbsent || nextRetryAt != null) {
      map['next_retry_at'] = Variable<DateTime>(nextRetryAt);
    }
    if (!nullToAbsent || lastErrorMessage != null) {
      map['last_error_message'] = Variable<String>(lastErrorMessage);
    }
    return map;
  }

  SyncQueueTableCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueTableCompanion(
      id: Value(id),
      inspectionClientId: Value(inspectionClientId),
      status: Value(status),
      retryCount: Value(retryCount),
      lastAttemptAt: lastAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAt),
      nextRetryAt: nextRetryAt == null && nullToAbsent
          ? const Value.absent()
          : Value(nextRetryAt),
      lastErrorMessage: lastErrorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(lastErrorMessage),
    );
  }

  factory SyncQueueTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueTableData(
      id: serializer.fromJson<int>(json['id']),
      inspectionClientId: serializer.fromJson<String>(
        json['inspectionClientId'],
      ),
      status: serializer.fromJson<String>(json['status']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
      nextRetryAt: serializer.fromJson<DateTime?>(json['nextRetryAt']),
      lastErrorMessage: serializer.fromJson<String?>(json['lastErrorMessage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'inspectionClientId': serializer.toJson<String>(inspectionClientId),
      'status': serializer.toJson<String>(status),
      'retryCount': serializer.toJson<int>(retryCount),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
      'nextRetryAt': serializer.toJson<DateTime?>(nextRetryAt),
      'lastErrorMessage': serializer.toJson<String?>(lastErrorMessage),
    };
  }

  SyncQueueTableData copyWith({
    int? id,
    String? inspectionClientId,
    String? status,
    int? retryCount,
    Value<DateTime?> lastAttemptAt = const Value.absent(),
    Value<DateTime?> nextRetryAt = const Value.absent(),
    Value<String?> lastErrorMessage = const Value.absent(),
  }) => SyncQueueTableData(
    id: id ?? this.id,
    inspectionClientId: inspectionClientId ?? this.inspectionClientId,
    status: status ?? this.status,
    retryCount: retryCount ?? this.retryCount,
    lastAttemptAt: lastAttemptAt.present
        ? lastAttemptAt.value
        : this.lastAttemptAt,
    nextRetryAt: nextRetryAt.present ? nextRetryAt.value : this.nextRetryAt,
    lastErrorMessage: lastErrorMessage.present
        ? lastErrorMessage.value
        : this.lastErrorMessage,
  );
  SyncQueueTableData copyWithCompanion(SyncQueueTableCompanion data) {
    return SyncQueueTableData(
      id: data.id.present ? data.id.value : this.id,
      inspectionClientId: data.inspectionClientId.present
          ? data.inspectionClientId.value
          : this.inspectionClientId,
      status: data.status.present ? data.status.value : this.status,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
      nextRetryAt: data.nextRetryAt.present
          ? data.nextRetryAt.value
          : this.nextRetryAt,
      lastErrorMessage: data.lastErrorMessage.present
          ? data.lastErrorMessage.value
          : this.lastErrorMessage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueTableData(')
          ..write('id: $id, ')
          ..write('inspectionClientId: $inspectionClientId, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('nextRetryAt: $nextRetryAt, ')
          ..write('lastErrorMessage: $lastErrorMessage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    inspectionClientId,
    status,
    retryCount,
    lastAttemptAt,
    nextRetryAt,
    lastErrorMessage,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueTableData &&
          other.id == this.id &&
          other.inspectionClientId == this.inspectionClientId &&
          other.status == this.status &&
          other.retryCount == this.retryCount &&
          other.lastAttemptAt == this.lastAttemptAt &&
          other.nextRetryAt == this.nextRetryAt &&
          other.lastErrorMessage == this.lastErrorMessage);
}

class SyncQueueTableCompanion extends UpdateCompanion<SyncQueueTableData> {
  final Value<int> id;
  final Value<String> inspectionClientId;
  final Value<String> status;
  final Value<int> retryCount;
  final Value<DateTime?> lastAttemptAt;
  final Value<DateTime?> nextRetryAt;
  final Value<String?> lastErrorMessage;
  const SyncQueueTableCompanion({
    this.id = const Value.absent(),
    this.inspectionClientId = const Value.absent(),
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.nextRetryAt = const Value.absent(),
    this.lastErrorMessage = const Value.absent(),
  });
  SyncQueueTableCompanion.insert({
    this.id = const Value.absent(),
    required String inspectionClientId,
    required String status,
    this.retryCount = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.nextRetryAt = const Value.absent(),
    this.lastErrorMessage = const Value.absent(),
  }) : inspectionClientId = Value(inspectionClientId),
       status = Value(status);
  static Insertable<SyncQueueTableData> custom({
    Expression<int>? id,
    Expression<String>? inspectionClientId,
    Expression<String>? status,
    Expression<int>? retryCount,
    Expression<DateTime>? lastAttemptAt,
    Expression<DateTime>? nextRetryAt,
    Expression<String>? lastErrorMessage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (inspectionClientId != null)
        'inspection_client_id': inspectionClientId,
      if (status != null) 'status': status,
      if (retryCount != null) 'retry_count': retryCount,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
      if (nextRetryAt != null) 'next_retry_at': nextRetryAt,
      if (lastErrorMessage != null) 'last_error_message': lastErrorMessage,
    });
  }

  SyncQueueTableCompanion copyWith({
    Value<int>? id,
    Value<String>? inspectionClientId,
    Value<String>? status,
    Value<int>? retryCount,
    Value<DateTime?>? lastAttemptAt,
    Value<DateTime?>? nextRetryAt,
    Value<String?>? lastErrorMessage,
  }) {
    return SyncQueueTableCompanion(
      id: id ?? this.id,
      inspectionClientId: inspectionClientId ?? this.inspectionClientId,
      status: status ?? this.status,
      retryCount: retryCount ?? this.retryCount,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
      nextRetryAt: nextRetryAt ?? this.nextRetryAt,
      lastErrorMessage: lastErrorMessage ?? this.lastErrorMessage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (inspectionClientId.present) {
      map['inspection_client_id'] = Variable<String>(inspectionClientId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt.value);
    }
    if (nextRetryAt.present) {
      map['next_retry_at'] = Variable<DateTime>(nextRetryAt.value);
    }
    if (lastErrorMessage.present) {
      map['last_error_message'] = Variable<String>(lastErrorMessage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueTableCompanion(')
          ..write('id: $id, ')
          ..write('inspectionClientId: $inspectionClientId, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('nextRetryAt: $nextRetryAt, ')
          ..write('lastErrorMessage: $lastErrorMessage')
          ..write(')'))
        .toString();
  }
}

class $InspectionFormSchemasTableTable extends InspectionFormSchemasTable
    with
        TableInfo<
          $InspectionFormSchemasTableTable,
          InspectionFormSchemasTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InspectionFormSchemasTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _workOrderIdMeta = const VerificationMeta(
    'workOrderId',
  );
  @override
  late final GeneratedColumn<String> workOrderId = GeneratedColumn<String>(
    'work_order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _schemaJsonMeta = const VerificationMeta(
    'schemaJson',
  );
  @override
  late final GeneratedColumn<String> schemaJson = GeneratedColumn<String>(
    'schema_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [workOrderId, schemaJson, cachedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inspection_form_schemas_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<InspectionFormSchemasTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('work_order_id')) {
      context.handle(
        _workOrderIdMeta,
        workOrderId.isAcceptableOrUnknown(
          data['work_order_id']!,
          _workOrderIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workOrderIdMeta);
    }
    if (data.containsKey('schema_json')) {
      context.handle(
        _schemaJsonMeta,
        schemaJson.isAcceptableOrUnknown(data['schema_json']!, _schemaJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_schemaJsonMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {workOrderId};
  @override
  InspectionFormSchemasTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InspectionFormSchemasTableData(
      workOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}work_order_id'],
      )!,
      schemaJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}schema_json'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $InspectionFormSchemasTableTable createAlias(String alias) {
    return $InspectionFormSchemasTableTable(attachedDatabase, alias);
  }
}

class InspectionFormSchemasTableData extends DataClass
    implements Insertable<InspectionFormSchemasTableData> {
  final String workOrderId;
  final String schemaJson;
  final DateTime cachedAt;
  const InspectionFormSchemasTableData({
    required this.workOrderId,
    required this.schemaJson,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['work_order_id'] = Variable<String>(workOrderId);
    map['schema_json'] = Variable<String>(schemaJson);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  InspectionFormSchemasTableCompanion toCompanion(bool nullToAbsent) {
    return InspectionFormSchemasTableCompanion(
      workOrderId: Value(workOrderId),
      schemaJson: Value(schemaJson),
      cachedAt: Value(cachedAt),
    );
  }

  factory InspectionFormSchemasTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InspectionFormSchemasTableData(
      workOrderId: serializer.fromJson<String>(json['workOrderId']),
      schemaJson: serializer.fromJson<String>(json['schemaJson']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workOrderId': serializer.toJson<String>(workOrderId),
      'schemaJson': serializer.toJson<String>(schemaJson),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  InspectionFormSchemasTableData copyWith({
    String? workOrderId,
    String? schemaJson,
    DateTime? cachedAt,
  }) => InspectionFormSchemasTableData(
    workOrderId: workOrderId ?? this.workOrderId,
    schemaJson: schemaJson ?? this.schemaJson,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  InspectionFormSchemasTableData copyWithCompanion(
    InspectionFormSchemasTableCompanion data,
  ) {
    return InspectionFormSchemasTableData(
      workOrderId: data.workOrderId.present
          ? data.workOrderId.value
          : this.workOrderId,
      schemaJson: data.schemaJson.present
          ? data.schemaJson.value
          : this.schemaJson,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InspectionFormSchemasTableData(')
          ..write('workOrderId: $workOrderId, ')
          ..write('schemaJson: $schemaJson, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(workOrderId, schemaJson, cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InspectionFormSchemasTableData &&
          other.workOrderId == this.workOrderId &&
          other.schemaJson == this.schemaJson &&
          other.cachedAt == this.cachedAt);
}

class InspectionFormSchemasTableCompanion
    extends UpdateCompanion<InspectionFormSchemasTableData> {
  final Value<String> workOrderId;
  final Value<String> schemaJson;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const InspectionFormSchemasTableCompanion({
    this.workOrderId = const Value.absent(),
    this.schemaJson = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InspectionFormSchemasTableCompanion.insert({
    required String workOrderId,
    required String schemaJson,
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  }) : workOrderId = Value(workOrderId),
       schemaJson = Value(schemaJson),
       cachedAt = Value(cachedAt);
  static Insertable<InspectionFormSchemasTableData> custom({
    Expression<String>? workOrderId,
    Expression<String>? schemaJson,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (workOrderId != null) 'work_order_id': workOrderId,
      if (schemaJson != null) 'schema_json': schemaJson,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InspectionFormSchemasTableCompanion copyWith({
    Value<String>? workOrderId,
    Value<String>? schemaJson,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return InspectionFormSchemasTableCompanion(
      workOrderId: workOrderId ?? this.workOrderId,
      schemaJson: schemaJson ?? this.schemaJson,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (workOrderId.present) {
      map['work_order_id'] = Variable<String>(workOrderId.value);
    }
    if (schemaJson.present) {
      map['schema_json'] = Variable<String>(schemaJson.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InspectionFormSchemasTableCompanion(')
          ..write('workOrderId: $workOrderId, ')
          ..write('schemaJson: $schemaJson, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WorkOrdersTableTable workOrdersTable = $WorkOrdersTableTable(
    this,
  );
  late final $InspectionsTableTable inspectionsTable = $InspectionsTableTable(
    this,
  );
  late final $SyncQueueTableTable syncQueueTable = $SyncQueueTableTable(this);
  late final $InspectionFormSchemasTableTable inspectionFormSchemasTable =
      $InspectionFormSchemasTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    workOrdersTable,
    inspectionsTable,
    syncQueueTable,
    inspectionFormSchemasTable,
  ];
}

typedef $$WorkOrdersTableTableCreateCompanionBuilder =
    WorkOrdersTableCompanion Function({
      required String id,
      required String code,
      required String title,
      Value<String?> description,
      Value<String?> notes,
      required String address,
      required String priority,
      required String status,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<DateTime?> scheduledAt,
      required DateTime createdAt,
      required DateTime updatedAt,
      required DateTime cachedAt,
      Value<int> rowid,
    });
typedef $$WorkOrdersTableTableUpdateCompanionBuilder =
    WorkOrdersTableCompanion Function({
      Value<String> id,
      Value<String> code,
      Value<String> title,
      Value<String?> description,
      Value<String?> notes,
      Value<String> address,
      Value<String> priority,
      Value<String> status,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<DateTime?> scheduledAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });

class $$WorkOrdersTableTableFilterComposer
    extends Composer<_$AppDatabase, $WorkOrdersTableTable> {
  $$WorkOrdersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
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

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WorkOrdersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkOrdersTableTable> {
  $$WorkOrdersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
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

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkOrdersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkOrdersTableTable> {
  $$WorkOrdersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$WorkOrdersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkOrdersTableTable,
          WorkOrdersTableData,
          $$WorkOrdersTableTableFilterComposer,
          $$WorkOrdersTableTableOrderingComposer,
          $$WorkOrdersTableTableAnnotationComposer,
          $$WorkOrdersTableTableCreateCompanionBuilder,
          $$WorkOrdersTableTableUpdateCompanionBuilder,
          (
            WorkOrdersTableData,
            BaseReferences<
              _$AppDatabase,
              $WorkOrdersTableTable,
              WorkOrdersTableData
            >,
          ),
          WorkOrdersTableData,
          PrefetchHooks Function()
        > {
  $$WorkOrdersTableTableTableManager(
    _$AppDatabase db,
    $WorkOrdersTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkOrdersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkOrdersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkOrdersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<DateTime?> scheduledAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkOrdersTableCompanion(
                id: id,
                code: code,
                title: title,
                description: description,
                notes: notes,
                address: address,
                priority: priority,
                status: status,
                latitude: latitude,
                longitude: longitude,
                scheduledAt: scheduledAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String code,
                required String title,
                Value<String?> description = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required String address,
                required String priority,
                required String status,
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<DateTime?> scheduledAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                required DateTime cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => WorkOrdersTableCompanion.insert(
                id: id,
                code: code,
                title: title,
                description: description,
                notes: notes,
                address: address,
                priority: priority,
                status: status,
                latitude: latitude,
                longitude: longitude,
                scheduledAt: scheduledAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WorkOrdersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkOrdersTableTable,
      WorkOrdersTableData,
      $$WorkOrdersTableTableFilterComposer,
      $$WorkOrdersTableTableOrderingComposer,
      $$WorkOrdersTableTableAnnotationComposer,
      $$WorkOrdersTableTableCreateCompanionBuilder,
      $$WorkOrdersTableTableUpdateCompanionBuilder,
      (
        WorkOrdersTableData,
        BaseReferences<
          _$AppDatabase,
          $WorkOrdersTableTable,
          WorkOrdersTableData
        >,
      ),
      WorkOrdersTableData,
      PrefetchHooks Function()
    >;
typedef $$InspectionsTableTableCreateCompanionBuilder =
    InspectionsTableCompanion Function({
      required String clientId,
      Value<String?> serverId,
      required String workOrderId,
      Value<String?> workOrderCode,
      Value<double?> workOrderLatitude,
      Value<double?> workOrderLongitude,
      required String status,
      Value<String?> notes,
      Value<String?> photoPath,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<DateTime?> capturedAt,
      Value<String?> formDataJson,
      Value<String?> formSchemaJson,
      Value<String?> syncErrorMessage,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });
typedef $$InspectionsTableTableUpdateCompanionBuilder =
    InspectionsTableCompanion Function({
      Value<String> clientId,
      Value<String?> serverId,
      Value<String> workOrderId,
      Value<String?> workOrderCode,
      Value<double?> workOrderLatitude,
      Value<double?> workOrderLongitude,
      Value<String> status,
      Value<String?> notes,
      Value<String?> photoPath,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<DateTime?> capturedAt,
      Value<String?> formDataJson,
      Value<String?> formSchemaJson,
      Value<String?> syncErrorMessage,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });

class $$InspectionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $InspectionsTableTable> {
  $$InspectionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workOrderCode => $composableBuilder(
    column: $table.workOrderCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get workOrderLatitude => $composableBuilder(
    column: $table.workOrderLatitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get workOrderLongitude => $composableBuilder(
    column: $table.workOrderLongitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get capturedAt => $composableBuilder(
    column: $table.capturedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get formDataJson => $composableBuilder(
    column: $table.formDataJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get formSchemaJson => $composableBuilder(
    column: $table.formSchemaJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncErrorMessage => $composableBuilder(
    column: $table.syncErrorMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InspectionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $InspectionsTableTable> {
  $$InspectionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workOrderCode => $composableBuilder(
    column: $table.workOrderCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get workOrderLatitude => $composableBuilder(
    column: $table.workOrderLatitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get workOrderLongitude => $composableBuilder(
    column: $table.workOrderLongitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get capturedAt => $composableBuilder(
    column: $table.capturedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get formDataJson => $composableBuilder(
    column: $table.formDataJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get formSchemaJson => $composableBuilder(
    column: $table.formSchemaJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncErrorMessage => $composableBuilder(
    column: $table.syncErrorMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InspectionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $InspectionsTableTable> {
  $$InspectionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workOrderCode => $composableBuilder(
    column: $table.workOrderCode,
    builder: (column) => column,
  );

  GeneratedColumn<double> get workOrderLatitude => $composableBuilder(
    column: $table.workOrderLatitude,
    builder: (column) => column,
  );

  GeneratedColumn<double> get workOrderLongitude => $composableBuilder(
    column: $table.workOrderLongitude,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<DateTime> get capturedAt => $composableBuilder(
    column: $table.capturedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get formDataJson => $composableBuilder(
    column: $table.formDataJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get formSchemaJson => $composableBuilder(
    column: $table.formSchemaJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncErrorMessage => $composableBuilder(
    column: $table.syncErrorMessage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$InspectionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InspectionsTableTable,
          InspectionsTableData,
          $$InspectionsTableTableFilterComposer,
          $$InspectionsTableTableOrderingComposer,
          $$InspectionsTableTableAnnotationComposer,
          $$InspectionsTableTableCreateCompanionBuilder,
          $$InspectionsTableTableUpdateCompanionBuilder,
          (
            InspectionsTableData,
            BaseReferences<
              _$AppDatabase,
              $InspectionsTableTable,
              InspectionsTableData
            >,
          ),
          InspectionsTableData,
          PrefetchHooks Function()
        > {
  $$InspectionsTableTableTableManager(
    _$AppDatabase db,
    $InspectionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InspectionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InspectionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InspectionsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> clientId = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                Value<String> workOrderId = const Value.absent(),
                Value<String?> workOrderCode = const Value.absent(),
                Value<double?> workOrderLatitude = const Value.absent(),
                Value<double?> workOrderLongitude = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<DateTime?> capturedAt = const Value.absent(),
                Value<String?> formDataJson = const Value.absent(),
                Value<String?> formSchemaJson = const Value.absent(),
                Value<String?> syncErrorMessage = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InspectionsTableCompanion(
                clientId: clientId,
                serverId: serverId,
                workOrderId: workOrderId,
                workOrderCode: workOrderCode,
                workOrderLatitude: workOrderLatitude,
                workOrderLongitude: workOrderLongitude,
                status: status,
                notes: notes,
                photoPath: photoPath,
                latitude: latitude,
                longitude: longitude,
                capturedAt: capturedAt,
                formDataJson: formDataJson,
                formSchemaJson: formSchemaJson,
                syncErrorMessage: syncErrorMessage,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String clientId,
                Value<String?> serverId = const Value.absent(),
                required String workOrderId,
                Value<String?> workOrderCode = const Value.absent(),
                Value<double?> workOrderLatitude = const Value.absent(),
                Value<double?> workOrderLongitude = const Value.absent(),
                required String status,
                Value<String?> notes = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<DateTime?> capturedAt = const Value.absent(),
                Value<String?> formDataJson = const Value.absent(),
                Value<String?> formSchemaJson = const Value.absent(),
                Value<String?> syncErrorMessage = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InspectionsTableCompanion.insert(
                clientId: clientId,
                serverId: serverId,
                workOrderId: workOrderId,
                workOrderCode: workOrderCode,
                workOrderLatitude: workOrderLatitude,
                workOrderLongitude: workOrderLongitude,
                status: status,
                notes: notes,
                photoPath: photoPath,
                latitude: latitude,
                longitude: longitude,
                capturedAt: capturedAt,
                formDataJson: formDataJson,
                formSchemaJson: formSchemaJson,
                syncErrorMessage: syncErrorMessage,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InspectionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InspectionsTableTable,
      InspectionsTableData,
      $$InspectionsTableTableFilterComposer,
      $$InspectionsTableTableOrderingComposer,
      $$InspectionsTableTableAnnotationComposer,
      $$InspectionsTableTableCreateCompanionBuilder,
      $$InspectionsTableTableUpdateCompanionBuilder,
      (
        InspectionsTableData,
        BaseReferences<
          _$AppDatabase,
          $InspectionsTableTable,
          InspectionsTableData
        >,
      ),
      InspectionsTableData,
      PrefetchHooks Function()
    >;
typedef $$SyncQueueTableTableCreateCompanionBuilder =
    SyncQueueTableCompanion Function({
      Value<int> id,
      required String inspectionClientId,
      required String status,
      Value<int> retryCount,
      Value<DateTime?> lastAttemptAt,
      Value<DateTime?> nextRetryAt,
      Value<String?> lastErrorMessage,
    });
typedef $$SyncQueueTableTableUpdateCompanionBuilder =
    SyncQueueTableCompanion Function({
      Value<int> id,
      Value<String> inspectionClientId,
      Value<String> status,
      Value<int> retryCount,
      Value<DateTime?> lastAttemptAt,
      Value<DateTime?> nextRetryAt,
      Value<String?> lastErrorMessage,
    });

class $$SyncQueueTableTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableFilterComposer({
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

  ColumnFilters<String> get inspectionClientId => $composableBuilder(
    column: $table.inspectionClientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextRetryAt => $composableBuilder(
    column: $table.nextRetryAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastErrorMessage => $composableBuilder(
    column: $table.lastErrorMessage,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableOrderingComposer({
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

  ColumnOrderings<String> get inspectionClientId => $composableBuilder(
    column: $table.inspectionClientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextRetryAt => $composableBuilder(
    column: $table.nextRetryAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastErrorMessage => $composableBuilder(
    column: $table.lastErrorMessage,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get inspectionClientId => $composableBuilder(
    column: $table.inspectionClientId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextRetryAt => $composableBuilder(
    column: $table.nextRetryAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastErrorMessage => $composableBuilder(
    column: $table.lastErrorMessage,
    builder: (column) => column,
  );
}

class $$SyncQueueTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncQueueTableTable,
          SyncQueueTableData,
          $$SyncQueueTableTableFilterComposer,
          $$SyncQueueTableTableOrderingComposer,
          $$SyncQueueTableTableAnnotationComposer,
          $$SyncQueueTableTableCreateCompanionBuilder,
          $$SyncQueueTableTableUpdateCompanionBuilder,
          (
            SyncQueueTableData,
            BaseReferences<
              _$AppDatabase,
              $SyncQueueTableTable,
              SyncQueueTableData
            >,
          ),
          SyncQueueTableData,
          PrefetchHooks Function()
        > {
  $$SyncQueueTableTableTableManager(
    _$AppDatabase db,
    $SyncQueueTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> inspectionClientId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<DateTime?> nextRetryAt = const Value.absent(),
                Value<String?> lastErrorMessage = const Value.absent(),
              }) => SyncQueueTableCompanion(
                id: id,
                inspectionClientId: inspectionClientId,
                status: status,
                retryCount: retryCount,
                lastAttemptAt: lastAttemptAt,
                nextRetryAt: nextRetryAt,
                lastErrorMessage: lastErrorMessage,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String inspectionClientId,
                required String status,
                Value<int> retryCount = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<DateTime?> nextRetryAt = const Value.absent(),
                Value<String?> lastErrorMessage = const Value.absent(),
              }) => SyncQueueTableCompanion.insert(
                id: id,
                inspectionClientId: inspectionClientId,
                status: status,
                retryCount: retryCount,
                lastAttemptAt: lastAttemptAt,
                nextRetryAt: nextRetryAt,
                lastErrorMessage: lastErrorMessage,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncQueueTableTable,
      SyncQueueTableData,
      $$SyncQueueTableTableFilterComposer,
      $$SyncQueueTableTableOrderingComposer,
      $$SyncQueueTableTableAnnotationComposer,
      $$SyncQueueTableTableCreateCompanionBuilder,
      $$SyncQueueTableTableUpdateCompanionBuilder,
      (
        SyncQueueTableData,
        BaseReferences<_$AppDatabase, $SyncQueueTableTable, SyncQueueTableData>,
      ),
      SyncQueueTableData,
      PrefetchHooks Function()
    >;
typedef $$InspectionFormSchemasTableTableCreateCompanionBuilder =
    InspectionFormSchemasTableCompanion Function({
      required String workOrderId,
      required String schemaJson,
      required DateTime cachedAt,
      Value<int> rowid,
    });
typedef $$InspectionFormSchemasTableTableUpdateCompanionBuilder =
    InspectionFormSchemasTableCompanion Function({
      Value<String> workOrderId,
      Value<String> schemaJson,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });

class $$InspectionFormSchemasTableTableFilterComposer
    extends Composer<_$AppDatabase, $InspectionFormSchemasTableTable> {
  $$InspectionFormSchemasTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get schemaJson => $composableBuilder(
    column: $table.schemaJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InspectionFormSchemasTableTableOrderingComposer
    extends Composer<_$AppDatabase, $InspectionFormSchemasTableTable> {
  $$InspectionFormSchemasTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get schemaJson => $composableBuilder(
    column: $table.schemaJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InspectionFormSchemasTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $InspectionFormSchemasTableTable> {
  $$InspectionFormSchemasTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get workOrderId => $composableBuilder(
    column: $table.workOrderId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get schemaJson => $composableBuilder(
    column: $table.schemaJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$InspectionFormSchemasTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InspectionFormSchemasTableTable,
          InspectionFormSchemasTableData,
          $$InspectionFormSchemasTableTableFilterComposer,
          $$InspectionFormSchemasTableTableOrderingComposer,
          $$InspectionFormSchemasTableTableAnnotationComposer,
          $$InspectionFormSchemasTableTableCreateCompanionBuilder,
          $$InspectionFormSchemasTableTableUpdateCompanionBuilder,
          (
            InspectionFormSchemasTableData,
            BaseReferences<
              _$AppDatabase,
              $InspectionFormSchemasTableTable,
              InspectionFormSchemasTableData
            >,
          ),
          InspectionFormSchemasTableData,
          PrefetchHooks Function()
        > {
  $$InspectionFormSchemasTableTableTableManager(
    _$AppDatabase db,
    $InspectionFormSchemasTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InspectionFormSchemasTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$InspectionFormSchemasTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$InspectionFormSchemasTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> workOrderId = const Value.absent(),
                Value<String> schemaJson = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InspectionFormSchemasTableCompanion(
                workOrderId: workOrderId,
                schemaJson: schemaJson,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String workOrderId,
                required String schemaJson,
                required DateTime cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => InspectionFormSchemasTableCompanion.insert(
                workOrderId: workOrderId,
                schemaJson: schemaJson,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InspectionFormSchemasTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InspectionFormSchemasTableTable,
      InspectionFormSchemasTableData,
      $$InspectionFormSchemasTableTableFilterComposer,
      $$InspectionFormSchemasTableTableOrderingComposer,
      $$InspectionFormSchemasTableTableAnnotationComposer,
      $$InspectionFormSchemasTableTableCreateCompanionBuilder,
      $$InspectionFormSchemasTableTableUpdateCompanionBuilder,
      (
        InspectionFormSchemasTableData,
        BaseReferences<
          _$AppDatabase,
          $InspectionFormSchemasTableTable,
          InspectionFormSchemasTableData
        >,
      ),
      InspectionFormSchemasTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WorkOrdersTableTableTableManager get workOrdersTable =>
      $$WorkOrdersTableTableTableManager(_db, _db.workOrdersTable);
  $$InspectionsTableTableTableManager get inspectionsTable =>
      $$InspectionsTableTableTableManager(_db, _db.inspectionsTable);
  $$SyncQueueTableTableTableManager get syncQueueTable =>
      $$SyncQueueTableTableTableManager(_db, _db.syncQueueTable);
  $$InspectionFormSchemasTableTableTableManager
  get inspectionFormSchemasTable =>
      $$InspectionFormSchemasTableTableTableManager(
        _db,
        _db.inspectionFormSchemasTable,
      );
}
