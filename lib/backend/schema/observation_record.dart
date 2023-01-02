import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'observation_record.g.dart';

abstract class ObservationRecord
    implements Built<ObservationRecord, ObservationRecordBuilder> {
  static Serializer<ObservationRecord> get serializer =>
      _$observationRecordSerializer;

  @BuiltValueField(wireName: 'Inspection_Date')
  DateTime? get inspectionDate;

  @BuiltValueField(wireName: 'Re-Inspection_Date')
  DateTime? get reInspectionDate;

  @BuiltValueField(wireName: 'Unit_ID')
  String? get unitID;

  @BuiltValueField(wireName: 'Inspection_ID')
  String? get inspectionID;

  @BuiltValueField(wireName: 'Room')
  String? get room;

  @BuiltValueField(wireName: 'Type')
  String? get type;

  @BuiltValueField(wireName: 'Category')
  String? get category;

  @BuiltValueField(wireName: 'Observation')
  String? get observation;

  @BuiltValueField(wireName: 'Impact')
  String? get impact;

  @BuiltValueField(wireName: 'Contractor_Type')
  String? get contractorType;

  @BuiltValueField(wireName: 'Defect_Type')
  String? get defectType;

  @BuiltValueField(wireName: 'Location_Note')
  String? get locationNote;

  @BuiltValueField(wireName: 'Remark')
  String? get remark;

  @BuiltValueField(wireName: 'ReInspection_Remark')
  String? get reInspectionRemark;

  @BuiltValueField(wireName: 'ReInspection_Photo')
  String? get reInspectionPhoto;

  @BuiltValueField(wireName: 'Inspection_Photo')
  String? get inspectionPhoto;

  @BuiltValueField(wireName: 'Inspection_Type')
  String? get inspectionType;

  @BuiltValueField(wireName: 'Project_Name')
  String? get projectName;

  @BuiltValueField(wireName: 'Property_Address')
  String? get propertyAddress;

  @BuiltValueField(wireName: 'Customer_Name')
  String? get customerName;

  @BuiltValueField(wireName: 'Wing_Block')
  String? get wingBlock;

  @BuiltValueField(wireName: 'Unit_No')
  String? get unitNo;

  @BuiltValueField(wireName: 'Property_Size_CarpetSqFt')
  double? get propertySizeCarpetSqFt;

  @BuiltValueField(wireName: 'Property_Configuration')
  String? get propertyConfiguration;

  @BuiltValueField(wireName: 'Unit_Facing')
  String? get unitFacing;

  @BuiltValueField(wireName: 'Assinged_Users')
  BuiltList<String>? get assingedUsers;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(ObservationRecordBuilder builder) => builder
    ..unitID = ''
    ..inspectionID = ''
    ..room = ''
    ..type = ''
    ..category = ''
    ..observation = ''
    ..impact = ''
    ..contractorType = ''
    ..defectType = ''
    ..locationNote = ''
    ..remark = ''
    ..reInspectionRemark = ''
    ..reInspectionPhoto = ''
    ..inspectionPhoto = ''
    ..inspectionType = ''
    ..projectName = ''
    ..propertyAddress = ''
    ..customerName = ''
    ..wingBlock = ''
    ..unitNo = ''
    ..propertySizeCarpetSqFt = 0.0
    ..propertyConfiguration = ''
    ..unitFacing = ''
    ..assingedUsers = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Observation');

  static Stream<ObservationRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<ObservationRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  ObservationRecord._();
  factory ObservationRecord([void Function(ObservationRecordBuilder) updates]) =
      _$ObservationRecord;

  static ObservationRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createObservationRecordData({
  DateTime? inspectionDate,
  DateTime? reInspectionDate,
  String? unitID,
  String? inspectionID,
  String? room,
  String? type,
  String? category,
  String? observation,
  String? impact,
  String? contractorType,
  String? defectType,
  String? locationNote,
  String? remark,
  String? reInspectionRemark,
  String? reInspectionPhoto,
  String? inspectionPhoto,
  String? inspectionType,
  String? projectName,
  String? propertyAddress,
  String? customerName,
  String? wingBlock,
  String? unitNo,
  double? propertySizeCarpetSqFt,
  String? propertyConfiguration,
  String? unitFacing,
}) {
  final firestoreData = serializers.toFirestore(
    ObservationRecord.serializer,
    ObservationRecord(
      (o) => o
        ..inspectionDate = inspectionDate
        ..reInspectionDate = reInspectionDate
        ..unitID = unitID
        ..inspectionID = inspectionID
        ..room = room
        ..type = type
        ..category = category
        ..observation = observation
        ..impact = impact
        ..contractorType = contractorType
        ..defectType = defectType
        ..locationNote = locationNote
        ..remark = remark
        ..reInspectionRemark = reInspectionRemark
        ..reInspectionPhoto = reInspectionPhoto
        ..inspectionPhoto = inspectionPhoto
        ..inspectionType = inspectionType
        ..projectName = projectName
        ..propertyAddress = propertyAddress
        ..customerName = customerName
        ..wingBlock = wingBlock
        ..unitNo = unitNo
        ..propertySizeCarpetSqFt = propertySizeCarpetSqFt
        ..propertyConfiguration = propertyConfiguration
        ..unitFacing = unitFacing
        ..assingedUsers = null,
    ),
  );

  return firestoreData;
}
