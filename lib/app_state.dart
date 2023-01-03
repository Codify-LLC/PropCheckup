import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
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
    secureStorage = FlutterSecureStorage();
    _uploadedImages =
        (await secureStorage.getStringList('ff_uploadedImages'))?.map((x) {
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

  late FlutterSecureStorage secureStorage;

  List<dynamic> _uploadedImages = [];
  List<dynamic> get uploadedImages => _uploadedImages;
  set uploadedImages(List<dynamic> _value) {
    _uploadedImages = _value;
    secureStorage.setStringList(
        'ff_uploadedImages', _value.map((x) => jsonEncode(x)).toList());
  }

  void deleteUploadedImages() {
    secureStorage.delete(key: 'ff_uploadedImages');
  }

  void addToUploadedImages(dynamic _value) {
    _uploadedImages.add(_value);
    secureStorage.setStringList('ff_uploadedImages',
        _uploadedImages.map((x) => jsonEncode(x)).toList());
  }

  void removeFromUploadedImages(dynamic _value) {
    _uploadedImages.remove(_value);
    secureStorage.setStringList('ff_uploadedImages',
        _uploadedImages.map((x) => jsonEncode(x)).toList());
  }

  List<int> _test = [];
  List<int> get test => _test;
  set test(List<int> _value) {
    _test = _value;
  }

  void addToTest(int _value) {
    _test.add(_value);
  }

  void removeFromTest(int _value) {
    _test.remove(_value);
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

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await write(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await write(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await write(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await write(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await write(key: key, value: ListToCsvConverter().convert([value]));
}
