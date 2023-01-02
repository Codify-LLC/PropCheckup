import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'room_list_record.g.dart';

abstract class RoomListRecord
    implements Built<RoomListRecord, RoomListRecordBuilder> {
  static Serializer<RoomListRecord> get serializer =>
      _$roomListRecordSerializer;

  @BuiltValueField(wireName: 'Room_Name')
  String? get roomName;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(RoomListRecordBuilder builder) =>
      builder..roomName = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('RoomList');

  static Stream<RoomListRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<RoomListRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  RoomListRecord._();
  factory RoomListRecord([void Function(RoomListRecordBuilder) updates]) =
      _$RoomListRecord;

  static RoomListRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createRoomListRecordData({
  String? roomName,
}) {
  final firestoreData = serializers.toFirestore(
    RoomListRecord.serializer,
    RoomListRecord(
      (r) => r..roomName = roomName,
    ),
  );

  return firestoreData;
}
