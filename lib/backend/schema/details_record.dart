import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'details_record.g.dart';

abstract class DetailsRecord
    implements Built<DetailsRecord, DetailsRecordBuilder> {
  static Serializer<DetailsRecord> get serializer => _$detailsRecordSerializer;

  @BuiltValueField(wireName: 'Inspection_Date')
  DateTime? get inspectionDate;

  @BuiltValueField(wireName: 'Inspection_ID')
  String? get inspectionID;

  @BuiltValueField(wireName: 'Inspection_Type')
  String? get inspectionType;

  @BuiltValueField(wireName: 'Unit_ID')
  String? get unitID;

  @BuiltValueField(wireName: 'Project_Name')
  String? get projectName;

  @BuiltValueField(wireName: 'Flat_No')
  String? get flatNo;

  @BuiltValueField(wireName: 'Room')
  BuiltList<String>? get room;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(DetailsRecordBuilder builder) => builder
    ..inspectionID = ''
    ..inspectionType = ''
    ..unitID = ''
    ..projectName = ''
    ..flatNo = ''
    ..room = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Details');

  static Stream<DetailsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<DetailsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  DetailsRecord._();
  factory DetailsRecord([void Function(DetailsRecordBuilder) updates]) =
      _$DetailsRecord;

  static DetailsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createDetailsRecordData({
  DateTime? inspectionDate,
  String? inspectionID,
  String? inspectionType,
  String? unitID,
  String? projectName,
  String? flatNo,
}) {
  final firestoreData = serializers.toFirestore(
    DetailsRecord.serializer,
    DetailsRecord(
      (d) => d
        ..inspectionDate = inspectionDate
        ..inspectionID = inspectionID
        ..inspectionType = inspectionType
        ..unitID = unitID
        ..projectName = projectName
        ..flatNo = flatNo
        ..room = null,
    ),
  );

  return firestoreData;
}
