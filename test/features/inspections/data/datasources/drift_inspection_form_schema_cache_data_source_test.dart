import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/core/database/app_database.dart';
import 'package:inspetorsys/features/inspections/data/datasources/drift_inspection_form_schema_cache_data_source.dart';
import 'package:inspetorsys/features/inspections/data/dto/inspection_form_schema_dto.dart';

void main() {
  late File databaseFile;
  late AppDatabase database;
  late DriftInspectionFormSchemaCacheDataSource dataSource;

  const schemaDto = InspectionFormSchemaDto(
    workOrderId: 'wo_1001',
    fields: [
      InspectionFormFieldSchemaDto(
        key: 'observation',
        type: 'text',
        label: 'Observação',
        isRequired: true,
        minLength: 10,
      ),
    ],
  );

  setUp(() async {
    databaseFile = File(
      '${Directory.systemTemp.path}/inspetorsys_form_schema_cache_${DateTime.now().microsecondsSinceEpoch}.db',
    );
    database = AppDatabase.forTesting(NativeDatabase(databaseFile));
    dataSource = DriftInspectionFormSchemaCacheDataSource(database);
  });

  tearDown(() async {
    await database.close();
    if (databaseFile.existsSync()) {
      databaseFile.deleteSync();
    }
  });

  test('returns null when schema is not cached', () async {
    final result = await dataSource.get('wo_1001');

    expect(result, isNull);
  });

  test('saves and retrieves schema by work order id', () async {
    await dataSource.save(schemaDto);

    final result = await dataSource.get('wo_1001');

    expect(result, schemaDto);
  });

  test('clearAll removes cached schemas', () async {
    await dataSource.save(schemaDto);
    await dataSource.clearAll();

    final result = await dataSource.get('wo_1001');

    expect(result, isNull);
  });

  test('clearSensitiveSessionData removes cached schemas', () async {
    await dataSource.save(schemaDto);
    await database.clearSensitiveSessionData();

    final result = await dataSource.get('wo_1001');

    expect(result, isNull);
  });
}
