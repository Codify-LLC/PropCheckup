import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'home_inspection_table_record.g.dart';

abstract class HomeInspectionTableRecord
    implements
        Built<HomeInspectionTableRecord, HomeInspectionTableRecordBuilder> {
  static Serializer<HomeInspectionTableRecord> get serializer =>
      _$homeInspectionTableRecordSerializer;

  @BuiltValueField(wireName: 'Observatin')
  String? get observatin;

  @BuiltValueField(wireName: 'Type')
  String? get type;

  String? get impact;

  @BuiltValueField(wireName: 'Photo')
  String? get photo;

  @BuiltValueField(wireName: 'Date')
  int? get date;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(HomeInspectionTableRecordBuilder builder) =>
      builder
        ..observatin = ''
        ..type = ''
        ..impact = ''
        ..photo = ''
        ..date = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('HomeInspectionTable');

  static Stream<HomeInspectionTableRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map(
          (s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<HomeInspectionTableRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s))!);

  HomeInspectionTableRecord._();
  factory HomeInspectionTableRecord(
          [void Function(HomeInspectionTableRecordBuilder) updates]) =
      _$HomeInspectionTableRecord;

  static HomeInspectionTableRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createHomeInspectionTableRecordData({
  String? observatin,
  String? type,
  String? impact,
  String? photo,
  int? date,
}) {
  final firestoreData = serializers.toFirestore(
    HomeInspectionTableRecord.serializer,
    HomeInspectionTableRecord(
      (h) => h
        ..observatin = observatin
        ..type = type
        ..impact = impact
        ..photo = photo
        ..date = date,
    ),
  );

  return firestoreData;
}
