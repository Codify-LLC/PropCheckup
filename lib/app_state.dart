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
