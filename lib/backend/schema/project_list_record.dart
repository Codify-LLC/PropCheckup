import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'project_list_record.g.dart';

abstract class ProjectListRecord
    implements Built<ProjectListRecord, ProjectListRecordBuilder> {
  static Serializer<ProjectListRecord> get serializer =>
      _$projectListRecordSerializer;

  @BuiltValueField(wireName: 'Project_Name')
  String? get projectName;

  @BuiltValueField(wireName: 'Project_Status')
  String? get projectStatus;

  @BuiltValueField(wireName: 'Project_ID')
  String? get projectID;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(ProjectListRecordBuilder builder) => builder
    ..projectName = ''
    ..projectStatus = ''
    ..projectID = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('ProjectList');

  static Stream<ProjectListRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<ProjectListRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  ProjectListRecord._();
  factory ProjectListRecord([void Function(ProjectListRecordBuilder) updates]) =
      _$ProjectListRecord;

  static ProjectListRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createProjectListRecordData({
  String? projectName,
  String? projectStatus,
  String? projectID,
}) {
  final firestoreData = serializers.toFirestore(
    ProjectListRecord.serializer,
    ProjectListRecord(
      (p) => p
        ..projectName = projectName
        ..projectStatus = projectStatus
        ..projectID = projectID,
    ),
  );

  return firestoreData;
}
