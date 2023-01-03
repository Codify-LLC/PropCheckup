import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/lat_lng.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _RoomLS = prefs.getString('ff_RoomLS') ?? _RoomLS;
    _FlatLS = prefs.getString('ff_FlatLS') ?? _FlatLS;
    _ProjectLS = prefs.getString('ff_ProjectLS') ?? _ProjectLS;
    _UnitID = prefs.getString('ff_UnitID') ?? _UnitID;
    _uploadedImages = prefs.getStringList('ff_uploadedImages')?.map((x) {
          try {
            return jsonDecode(x);
          } catch (e) {
            print("Can't decode persisted json. Error: $e.");
            return {};
          }
        }).toList() ??
        _uploadedImages;
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _InspectionTypeList = 'Home Inspection';
  String get InspectionTypeList => _InspectionTypeList;
  set InspectionTypeList(String _value) {
    _InspectionTypeList = _value;
  }

  String _RoomLS = '';
  String get RoomLS => _RoomLS;
  set RoomLS(String _value) {
    _RoomLS = _value;
    prefs.setString('ff_RoomLS', _value);
  }

  String _FlatLS = '';
  String get FlatLS => _FlatLS;
  set FlatLS(String _value) {
    _FlatLS = _value;
    prefs.setString('ff_FlatLS', _value);
  }

  String _ProjectLS = '';
  String get ProjectLS => _ProjectLS;
  set ProjectLS(String _value) {
    _ProjectLS = _value;
    prefs.setString('ff_ProjectLS', _value);
  }

  String _UnitID = '';
  String get UnitID => _UnitID;
  set UnitID(String _value) {
    _UnitID = _value;
    prefs.setString('ff_UnitID', _value);
  }

  String _urlImages = '';
  String get urlImages => _urlImages;
  set urlImages(String _value) {
    _urlImages = _value;
  }

  List<dynamic> _uploadedImages = [];
  List<dynamic> get uploadedImages => _uploadedImages;
  set uploadedImages(List<dynamic> _value) {
    _uploadedImages = _value;
    prefs.setStringList(
        'ff_uploadedImages', _value.map((x) => jsonEncode(x)).toList());
  }

  void addToUploadedImages(dynamic _value) {
    _uploadedImages.add(_value);
    prefs.setStringList('ff_uploadedImages',
        _uploadedImages.map((x) => jsonEncode(x)).toList());
  }

  void removeFromUploadedImages(dynamic _value) {
    _uploadedImages.remove(_value);
    prefs.setStringList('ff_uploadedImages',
        _uploadedImages.map((x) => jsonEncode(x)).toList());
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
