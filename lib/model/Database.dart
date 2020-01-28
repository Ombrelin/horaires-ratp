import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

part 'Database.g.dart';

const tableStations = SqfEntityTable(
    tableName: 'stations',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    modelName: null,
    fields: [
      SqfEntityField('name', DbType.text),
      SqfEntityField('slug', DbType.text),
      SqfEntityField('type', DbType.text),
      SqfEntityField('way', DbType.text),
      SqfEntityField('line', DbType.text),
      SqfEntityField('destination', DbType.text)
    ]
);

@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
    modelName: 'StationsModel', // optional
    databaseName: 'StationsORMv2.db',
    databaseTables: [tableStations],
    bundledDatabasePath: null
);