import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'master_inspection_type_record.g.dart';

abstract class MasterInspectionTypeRecord
    implements
        Built<MasterInspectionTypeRecord, MasterInspectionTypeRecordBuilder> {
  static Serializer<MasterInspectionTypeRecord> get serializer =>
      _$masterInspectionTypeRecordSerializer;

  @BuiltValueField(wireName: 'Master_Inspection_Type_List')
  String? get masterInspectionTypeList;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(MasterInspectionTypeRecordBuilder builder) =>
      builder..masterInspectionTypeList = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Master_Inspection_Type');

  static Stream<MasterInspectionTypeRecord> getDocument(
          DocumentReference ref) =>
      ref.snapshots().map(
          (s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<MasterInspectionTypeRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s))!);

  MasterInspectionTypeRecord._();
  factory MasterInspectionTypeRecord(
          [void Function(MasterInspectionTypeRecordBuilder) updates]) =
      _$MasterInspectionTypeRecord;

  static MasterInspectionTypeRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createMasterInspectionTypeRecordData({
  String? masterInspectionTypeList,
}) {
  final firestoreData = serializers.toFirestore(
    MasterInspectionTypeRecord.serializer,
    MasterInspectionTypeRecord(
      (m) => m..masterInspectionTypeList = masterInspectionTypeList,
    ),
  );

  return firestoreData;
}
