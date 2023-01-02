// Automatic FlutterFlow imports
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '../../flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

final ImagePicker _picker = ImagePicker();

Future takePhoto() async {
  try {
    final XFile? photoURL = await _picker.pickImage(source: ImageSource.camera);
    if (photoURL != null) {
      FFAppState().urlImages = photoURL.path;
    }
  } catch (e) {
    print(e.toString());
  }
}
