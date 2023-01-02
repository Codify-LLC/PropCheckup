import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 're_inspection_record.g.dart';

abstract class ReInspectionRecord
    implements Built<ReInspectionRecord, ReInspectionRecordBuilder> {
  static Serializer<ReInspectionRecord> get serializer =>
      _$reInspectionRecordSerializer;

  String? get observation;

  DateTime? get date;

  String? get impact;

  String? get photo;

  String? get unitUniqueNo;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(ReInspectionRecordBuilder builder) => builder
    ..observation = ''
    ..impact = ''
    ..photo = ''
    ..unitUniqueNo = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('ReInspection');

  static Stream<ReInspectionRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<ReInspectionRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s))!);

  ReInspectionRecord._();
  factory ReInspectionRecord(
          [void Function(ReInspectionRecordBuilder) updates]) =
      _$ReInspectionRecord;

  static ReInspectionRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createReInspectionRecordData({
  String? observation,
  DateTime? date,
  String? impact,
  String? photo,
  String? unitUniqueNo,
}) {
  final firestoreData = serializers.toFirestore(
    ReInspectionRecord.serializer,
    ReInspectionRecord(
      (r) => r
        ..observation = observation
        ..date = date
        ..impact = impact
        ..photo = photo
        ..unitUniqueNo = unitUniqueNo,
    ),
  );

  return firestoreData;
}
